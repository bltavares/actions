FROM ruby:2-slim

LABEL "com.github.actions.name"="rubocop"
LABEL "com.github.actions.description"="Provides linting and fixes using rubocop"
LABEL "com.github.actions.icon"="user-check"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="http://github.com/bltavares/actions"
LABEL "homepage"="http://github.com/bltavares/actions"
LABEL "maintainer"="Bruno Tavares <connect+githubactions@bltavares.com>"

RUN apt-get update -qq && apt-get install -qqy --no-install-recommends \
  curl=7.52* \
  jq=1.5* \
  bash=4.4* \
  git=1:2.11* \
  make=4.1* \
  gcc=4:6.3* \
  && rm -rf /var/lib/apt/lists/*

RUN gem install rubocop

COPY lib.sh /lib.sh
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
