FROM clojure:boot-alpine

LABEL "com.github.actions.name"="zprint"
LABEL "com.github.actions.description"="Provides linting and fixes using zprint"
LABEL "com.github.actions.icon"="user-check"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="http://github.com/bltavares/actions"
LABEL "homepage"="http://github.com/bltavares/actions"
LABEL "maintainer"="Bruno Tavares <connect+githubactions@bltavares.com>"

RUN echo '{:search-config? true}' >~/.zprint.edn \
  && boot -d boot-fmt:0.1.8 -d zprint:0.4.15 fmt --help >/dev/null
RUN apk --no-cache add \
  curl=7.61.1-r1 \
  jq=1.6_rc1-r1 \
  bash=4.4.19-r1 \
  git=2.18.1-r0

COPY lib.sh /lib.sh
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
