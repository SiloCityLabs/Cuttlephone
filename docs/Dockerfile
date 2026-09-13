FROM ruby:3.3-slim

# native gems need a compiler and headers
# git is for jekyll-remote-theme
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    libssl-dev \
    pkg-config \
    zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

# Gemfile.lock is gitignored, so the image resolves its own
COPY Gemfile ./
RUN bundle install

EXPOSE 4000

# force_polling for file change events
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--port", "4000", "--force_polling"]
