#!/bin/bash

export REPO_NAME="alphagov/govuk-content-schemas"
export CONTEXT_MESSAGE="Verify manuals-frontend against schema examples"

exec ./jenkins.sh
