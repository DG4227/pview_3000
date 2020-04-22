FROM ruby:2.6.5-alpine
ENV BUNDLER_VERSION=2.0.2
RUN apk add --update \
  build-base \
  libxml2-dev \
  libxslt-dev \
  postgresql-dev \
  pkgconfig \
  imagemagick \
  imagemagick-dev \
  imagemagick-libs \
  tzdata \
  && rm -rf /var/cache/apk/*

RUN gem install bundler -v 2.0.2
RUN mkdir /photo_viewer
WORKDIR /photo_viewer
COPY Gemfile /photo_viewer/Gemfile
COPY Gemfile.lock /photo_viewer/Gemfile.lock
COPY . /photo_viewer

RUN bundle check || bundle install

EXPOSE 3000

CMD [ "rails", "s", "-b", "0.0.0.0" ]
