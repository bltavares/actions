FROM koalaman/shellcheck-alpine:stable

LABEL "com.github.actions.name"="shellcheck"
LABEL "com.github.actions.description"="Provides linting using shellcheck"
LABEL "com.github.actions.icon"="user-check"
LABEL "com.github.actions.color"="green"

LABEL "repository"="http://github.com/bltavares/actions"
LABEL "homepage"="http://github.com/bltavares/actions"
LABEL "maintainer"="Bruno Tavares <connect+githubactions@bltavares.com>"

RUN apk --no-cache add \
  curl \
  jq \
  ca-certificates \
  bash \
  git

COPY lib.sh /lib.sh
COPY entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]
