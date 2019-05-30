FROM clojure:tools-deps-alpine

LABEL "com.github.actions.name"="clj-kondo"
LABEL "com.github.actions.description"="Provides linting and fixes using clj-kondo"
LABEL "com.github.actions.icon"="user-check"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="http://github.com/bltavares/actions"
LABEL "homepage"="http://github.com/bltavares/actions"
LABEL "maintainer"="Bruno Tavares <connect+githubactions@bltavares.com>"

RUN apk --no-cache add \
  curl~=7 \
  jq~=1.6 \
  bash~=4 \
  zip~=3 \
  git~=2

RUN curl -sO https://raw.githubusercontent.com/borkdude/clj-kondo/master/script/install-clj-kondo && \
  bash ./install-clj-kondo && \
  rm install-clj-kondo

COPY lib.sh /lib.sh
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
