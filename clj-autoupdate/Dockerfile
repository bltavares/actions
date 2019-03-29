FROM alpine:3.9

LABEL "com.github.actions.name"="autobump"
LABEL "com.github.actions.description"="Provides actions to bump commons"
LABEL "com.github.actions.icon"="git-commit"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="http://github.com/bltavares/actions"
LABEL "homepage"="http://github.com/bltavares/actions"
LABEL "maintainer"="Bruno Tavares <connect+githubactions@bltavares.com>"

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

RUN apk --no-cache add \
  curl~=7 \
  jq~=1.6 \
  bash~=4 \
  git~=2 \
  python3~=3.6 \
  coreutils~=8 \
  && pip3 install --no-cache-dir awscli==1.16.134

COPY lib.sh /lib.sh
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
