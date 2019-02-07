FROM mvdan/shfmt:v2.6.3 as shfmt
FROM alpine:3.8

LABEL "com.github.actions.name"="shfmt"
LABEL "com.github.actions.description"="Provides linting and fixes using shfmt"
LABEL "com.github.actions.icon"="user-check"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="http://github.com/bltavares/actions"
LABEL "homepage"="http://github.com/bltavares/actions"
LABEL "maintainer"="Bruno Tavares <connect+githubactions@bltavares.com>"

COPY --from=shfmt /bin/shfmt /bin/shfmt

RUN apk --no-cache add \
  curl~=7 \
  jq~=1.6 \
  bash~=4 \
  git~=2

COPY lib.sh /lib.sh
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
