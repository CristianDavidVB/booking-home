FROM ruby:3.2.2-slim-bullseye

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      build-essential \
      postgresql-client \
      git \
      curl \
      libpq-dev \
      pkg-config \
      libpq5 && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives


WORKDIR /app

COPY . .

RUN bundle install

RUN bundle exec bootsnap precompile app/ lib/

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]