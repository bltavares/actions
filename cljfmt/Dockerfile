FROM clojure:lein-alpine

RUN apk --no-cache add \
  curl \
  jq \
  ca-certificates \
  bash \
  git

COPY entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

LABEL "com.github.actions.name"="cljfmt"
LABEL "com.github.actions.description"="Provides linting and fixes using cljfmt"
LABEL "com.github.actions.icon"="user-check"
LABEL "com.github.actions.color"="green"

LABEL "repository"="http://github.com/bltavares/actions"
LABEL "homepage"="http://github.com/bltavares/actions"
LABEL "maintainer"="Bruno Tavares <connect+githubactions@bltavares.com>"
