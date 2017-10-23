# A Dockerfile for development.

FROM alpine:3.6

RUN apk add --no-cache \
    # Runtime deps
    ruby ruby-bundler ruby-bigdecimal ruby-io-console tzdata nodejs bash \
    # Bundle install deps
    build-base ruby-dev libc-dev linux-headers gmp-dev libxml2-dev \
    libxslt-dev mariadb-dev git libffi-dev

ENV BUNDLE_SILENCE_ROOT_WARNING=1

ENV APP_HOME /demo
WORKDIR $APP_HOME
RUN mkdir -p $APP_HOME

# Copy Gemfile and run bundle install first to allow for caching
ADD Gemfile $APP_HOME/
RUN bundle install && true


ADD . $APP_HOME/
RUN bundle exec rake assets:precompile

CMD ./run_prod.sh
