FROM alpine:3.8

LABEL "com.github.actions.name"="autobump"
LABEL "com.github.actions.description"="Bump patch and tag prerelease version based on git tags"
LABEL "com.github.actions.icon"="sunrise"
LABEL "com.github.actions.color"="yellow"

LABEL "repository"="http://github.com/bltavares/actions"
LABEL "homepage"="http://github.com/bltavares/actions"
LABEL "maintainer"="Bruno Tavares <connect+githubactions@bltavares.com>"

RUN apk --no-cache add \
  curl~=7 \
  jq~=1.6 \
  bash~=4 \
  git~=2

COPY lib.sh /lib.sh
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
