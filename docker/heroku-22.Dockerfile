
ENV WORKSPACE_DIR=/app
ENV PATH=/app/vendor/heroku/heroku-buildpack-php/support/build/_util:$PATH

RUN apt-get update && \
    apt-get install -y php-dev autoconf make gcc g++ && \
    apt-get clean