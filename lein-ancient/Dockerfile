FROM clojure:lein-alpine

LABEL "com.github.actions.name"="lein-ancient"
LABEL "com.github.actions.description"="Provides version check and bumps using lein-ancient"
LABEL "com.github.actions.icon"="user-check"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="http://github.com/bltavares/actions"
LABEL "homepage"="http://github.com/bltavares/actions"
LABEL "maintainer"="Bruno Tavares <connect+githubactions@bltavares.com>"

RUN mkdir -p ~/.lein && echo '{:user {:plugins [[lein-ancient "0.6.15"]]}}' > ~/.lein/profiles.clj

RUN apk --no-cache add \
  curl~=7 \
  jq~=1.6 \
  bash~=4 \
  git~=2

COPY lib.sh /lib.sh
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
