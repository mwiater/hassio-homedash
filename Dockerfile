ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

ENV NOKOGIRI_USE_SYSTEM_LIBRARIES=1
ENV PORT=8888

RUN apk update && \
apk add make gcc musl-dev nodejs && \
  apk add --update ruby && \
  apk add --update libffi-dev \
           ruby-etc \
           ruby-bigdecimal \
           ruby-io-console \
           ruby-irb \
           ca-certificates \
           libressl \
           less \
           build-base \
           ruby-dev \
           libressl-dev \
  && gem install --no-rdoc --no-ri bundler:'~> 2.0' \
                                 json \
  && bundle config build.nokogiri --use-system-libraries \
  && bundle config git.allow_insecure true \
  \
  && gem cleanup \
  && rm -rf /usr/lib/ruby/gems/*/cache/* \
          /var/cache/apk/* \
          /tmp/* \
          /var/tmp/*

COPY . /app/

RUN cd /app && bundle install

RUN chmod a+x /app/dockerRunArm.sh

# Add-on persistent data directory.
WORKDIR /data

CMD [ "/bin/ash", "/app/dockerRunArm.sh" ]
