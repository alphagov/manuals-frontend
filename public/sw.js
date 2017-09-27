importScripts("workbox-sw.prod.v2.0.2-rc1-2.0.2-rc1.0.js");

const workboxSW = new self.WorkboxSW();

self.addEventListener("message", event => {
  console.log('received message ' + event.data + ' from ' + event.source.url);

  const url = event.source.url
  const path = url.split("//")[1].split("/").slice(1).join("/");
  const contentUrl = `https://www.gov.uk/api/content/${path}`;

  fetch(contentUrl)
	.then(response => response.json())
	.then(data => {
		const groups = data.details.child_section_groups;

		const paths = groups.reduce((array, group) => {
			return array.concat(group.child_sections.map(section => section.base_path));
		}, [path]);

		const manifest = paths.map(path => {
			return { "url": path, "revision": "1" };
		});

		workboxSW.precache(manifest.concat([
			{ "url": "https://assets.publishing.service.gov.uk/static/fonts-5ff8c53913434afd0072a480d7cfca67cace4c8d03f6ef96b78a4455728ce745.css", "revision": "1" },
			{ "url": "https://assets.publishing.service.gov.uk/static/core-layout-270983440a087ff31e3c149f48773168d65ceefff6fd9ec24307bf5dc6c42680.css", "revision": "1" },
			{ "url": "/manuals-frontend/application.css?body=1", "revision": "1" },
			{ "url": "/manuals-frontend/application.js?body=1", "revision": "1" },
			{ "url": "/manuals-frontend/govuk/multivariate-test.js?body=1", "revision": "1" },
			{ "url": "/manuals-frontend/govuk/primary-links.js?body=1", "revision": "1" },
			{ "url": "/manuals-frontend/govuk/stick-at-top-when-scrolling.js?body=1", "revision": "1" },
			{ "url": "/manuals-frontend/govuk/stop-scrolling-at-footer.js?body=1", "revision": "1" },
			{ "url": "/manuals-frontend/govuk_toolkit.js?body=1", "revision": "1" },
			{ "url": "/manuals-frontend/modules/collapsible.js?body=1", "revision": "1" },
			{ "url": "/manuals-frontend/modules/collapsible_collection.js?body=1", "revision": "1" },
			{ "url": "/manuals-frontend/modules/current_location.js?body=1", "revision": "1" },
		]));

		workboxSW._revisionedCacheManager.install();
	})
	.catch((error) => console.log(error));
});
