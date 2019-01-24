FROM garethr/kubeval:0.7.3 as kubeval
FROM alpine:3.8

LABEL "com.github.actions.name"="kubeval"
LABEL "com.github.actions.description"="Provides k8s linting using kubeval"
LABEL "com.github.actions.icon"="user-check"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="http://github.com/bltavares/actions"
LABEL "homepage"="http://github.com/bltavares/actions"
LABEL "maintainer"="Bruno Tavares <connect+githubactions@bltavares.com>"

COPY --from=kubeval /kubeval /bin/kubeval

RUN apk --no-cache add \
  curl=7.61.1-r1 \
  jq=1.6_rc1-r1 \
  bash=4.4.19-r1 \
  git=2.18.1-r0

COPY lib.sh /lib.sh
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
