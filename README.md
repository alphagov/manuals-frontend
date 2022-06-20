**Manuals Frontend is retired and all manuals are now being rendered by [Government Frontend](https://github.com/alphagov/government-frontend/)**

# Manuals Frontend

Front-end app for the manuals format on GOV.UK

## Nomenclature

- **Manuals** – documents published using [Manuals Publisher](https://github.com/alphagov/manuals-publisher).
- **HMRC Manuals** – Manuals published by HMRC and populated via [HMRC Manuals API](https://github.com/alphagov/hmrc-manuals-api).
- **Sections** - individual sub-pages of a Manual or HMRC Manual.

## Live examples

- [Manual: gov.uk/guidance/content-design](https://www.gov.uk/guidance/content-design)
- [Manual Section: gov.uk/guidance/content-design/what-is-content-design](https://www.gov.uk/guidance/content-design/what-is-content-design)
- [HMRC Manual: gov.uk/hmrc-internal-manuals/pensions-tax-manual](https://www.gov.uk/hmrc-internal-manuals/pensions-tax-manual)
- [HMRC Manual Section: gov.uk/hmrc-internal-manuals/pensions-tax-manual/ptm000001](https://www.gov.uk/hmrc-internal-manuals/pensions-tax-manual/ptm000001)

## Technical documentation

This is a Ruby on Rails app, and should follow [our Rails app conventions](https://docs.publishing.service.gov.uk/manual/conventions-for-rails-applications.html).

You can use the [GOV.UK Docker environment](https://github.com/alphagov/govuk-docker) or the local `startup.sh` script to run the app. Read the [guidance on local frontend development](https://docs.publishing.service.gov.uk/manual/local-frontend-development.html) to find out more about each approach, before you get started.

If you are using GOV.UK Docker, remember to combine it with the commands that follow. See the [GOV.UK Docker usage instructions](https://github.com/alphagov/govuk-docker#usage) for examples.

### Running the tests

```
bundle exec rake
```

## License

[MIT License](LICENSE)
