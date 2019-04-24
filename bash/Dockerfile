FROM alpine:3.8

LABEL "com.github.actions.name"="bash"
LABEL "com.github.actions.description"="Provides shell utilities such as curl and make"
LABEL "com.github.actions.icon"="settings"
LABEL "com.github.actions.color"="yellow"

LABEL "repository"="http://github.com/bltavares/actions"
LABEL "homepage"="http://github.com/bltavares/actions"
LABEL "maintainer"="Bruno Tavares <connect+githubactions@bltavares.com>"

RUN apk --no-cache add \
  curl~=7 \
  wget~=1.20 \
  jq~=1.6 \
  bash~=4 \
  git~=2 \
  make~=4.2 \
  binutils~=2.30 \
  file~=5.32 \
  zip~=3.0

COPY lib.sh /lib.sh
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
