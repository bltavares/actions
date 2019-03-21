FROM japaric/`'TARGET

ENV RUSTUP_HOME=/usr/local/rustup \
  CARGO_HOME=/usr/local/cargo \
  PATH=/usr/local/cargo/bin:$PATH \
  RUST_VERSION=1.33.0

# Action toolchain
RUN apt-get update -qq && apt-get install -qqy --no-install-recommends \
  curl=7.* \
  jq=1.* \
  bash=4.* \
  git=1:2.* \
  && rm -rf /var/lib/apt/lists/*

# Rust toolchain
RUN curl https://sh.rustup.rs -sSf -o /rustup.sh \
  && sh /rustup.sh -y \
  --no-modify-path \
  --default-toolchain $RUST_VERSION \
  && rm /rustup.sh \
  && chmod -R a+w $RUSTUP_HOME $CARGO_HOME

# Cross compilation target toolchain
RUN rustup target add `'TARGET 

# And tool for defining the type of lib to produce: dynamic OR static
RUN cargo install --force cargo-crate-type

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
