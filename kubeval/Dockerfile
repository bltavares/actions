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
  curl~=7 \
  jq~=1.6 \
  bash~=4 \
  git~=2

COPY lib.sh /lib.sh
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
