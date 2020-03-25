FROM ruby:2.6.3


# sudo apt-get install python-software-properties
RUN apt-get update -qq && apt-get install -y ca-certificates wget && apt-get clean all

RUN curl -sL https://deb.nodesource.com/setup_13.x | bash -

RUN apt-get update -qq && apt-get install -y nodejs  \
    ca-certificates \
    libxml2-dev \
    libxslt-dev \
    tzdata \
    libmariadb-dev \
    nodejs \

RUN gem install bundler && bundler config --global frozen 1

RUN mkdir /app

WORKDIR /app

ENV RAILS_ENV production

# Node 모듈 설치
COPY package.json yarn.lock ./

RUN cat package.json

RUN npm install yarn -g --force

RUN yarn install --production

COPY Gemfile Gemfile.lock ./

RUN bundle install --without development test

COPY . .

RUN bundle exec rails assets:precompile

EXPOSE 80


CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "80"]
VOLUME ["/app/storage", "/app/log"]
