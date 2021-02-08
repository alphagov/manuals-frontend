Manuals Frontend
================

## Purpose

Front-end app for the manuals format on GOV.UK

## Live examples

- [gov.uk/guidance/content-design](https://www.gov.uk/guidance/content-design)
- [gov.uk/hmrc-internal-manuals/pensions-tax-manual](https://www.gov.uk/hmrc-internal-manuals/pensions-tax-manual)

## Nomenclature

- **Manuals** – documents published using [github.com/alphagov/manuals-publisher](https://github.com/alphagov/manuals-publisher).
- **HMRC Manuals** – Manuals published by HMRC and populated via their API: [github.com/alphagov/hmrc-manuals-api](https://github.com/alphagov/hmrc-manuals-api).


## Dependencies
- [https://github.com/alphagov/static](https://github.com/alphagov/static) – Provides static assets (JS/CSS)
- [https://github.com/alphagov/content-store](https://github.com/alphagov/content-store) – Provides content


## Installation and running

In a terminal, run:

```
./startup.sh
```

or using bowler:

`bowl manuals-frontend`

If you are using the GDS development virtual machine then the application will be available on the host at http://manuals-frontend.dev.gov.uk/

## Running the tests

The test suite includes testing against govuk-content-schemas, so you will need a copy of this repo on your file system. By default this should be in a sibling directory to your project. Alternatively, you can specify their location with the GOVUK_CONTENT_SCHEMAS_PATH environment variable.

All tests can be run using `bundle exec rake` as well.

## Viewing a manual

You can see the content design manual at http://manuals-frontend.dev.gov.uk/guidance/content-design


## Publishing a manual on dev

Manuals are published using `manuals-publisher` to publish a manual run `manuals-publisher` (instructions here: https://github.com/alphagov/manuals-publisher), publish a manual, and you should then be able to view it on `manuals-frontend`. If you have replicated from preview recently then you should be able to see currently published manuals at http://manuals-frontend.dev.gov.uk/[preview-slug] too.
