FROM ruby:2.6.3

RUN rm -rf ./tmp/*

# sudo apt-get install python-software-properties
RUN apt-get update -qq && apt-get install -y ca-certificates wget && apt-get clean all

RUN curl -sL https://deb.nodesource.com/setup_13.x | bash -

RUN apt-get update -qq && apt-get install -y nodejs  \
    ca-certificates \
    libxml2-dev \
    libxslt-dev \
    tzdata \
    libmariadb-dev \
    nodejs

RUN gem install bundler && bundler config --global frozen 1

RUN apt-get install nginx -y


# NodeJS/Bundler/Nginx 설치

RUN mkdir /app

WORKDIR /app

ENV RAILS_ENV production

COPY package.json yarn.lock ./

RUN npm install yarn -g --force

RUN yarn install --production

COPY Gemfile Gemfile.lock ./

RUN bundle install --without development test
# ? 배포용 gem 설치

COPY . .

RUN bundle exec rails assets:precompile RAILS_ENV=production
# nginx 설정

EXPOSE 80

COPY ./config/nginx_default.conf /etc/nginx/sites-available/default
COPY ./config/nginx_default.conf /etc/nginx/sites-enabled/default

RUN cat /etc/nginx/sites-available/default

# NGINX 설정
RUN nginx -t
# nginx Syntax 오류 검사
RUN service nginx restart


CMD ["bundle", "exec", "unicorn_rails", "-E", "production", "-c", "./config/unicorn.rb", "-d"]

# CMD ["bundle", "exec", "unicorn_rails", "-c", "./config/unicorn.rb", "-D"]
# ! Daemonize

VOLUME ["/app/storage", "/app/public", "/app/log"]
# 외부 공개
