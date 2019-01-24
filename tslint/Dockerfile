FROM node:alpine

LABEL "com.github.actions.name"="tslint"
LABEL "com.github.actions.description"="Provides linting for TypeScript files"
LABEL "com.github.actions.icon"="user-check"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="http://github.com/bltavares/actions"
LABEL "homepage"="http://github.com/bltavares/actions"
LABEL "maintainer"="Bruno Tavares <connect+githubactions@bltavares.com>"

RUN npm install -g tslint@5.12.1 typescript@3.2.4

RUN apk --no-cache add \
  curl=7.61.1-r1 \
  jq=1.6_rc1-r1 \
  bash=4.4.19-r1 \
  git=2.18.1-r0

COPY lib.sh /lib.sh
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
