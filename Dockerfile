# Dockerfile for docker image `apigen/apigen`.
#
#    docker build -t apigen/apigen:latest .
#    docker build -t apigen/apigen:4.1 --build-arg VERSION=4.1 .

FROM graze/composer
MAINTAINER deizel <deizel@gmail.com>

ARG VERSION=@stable
ARG USER=apigen

# Workarounds for base image
ENV COMPOSER_HOME /root/composer/
ENV PATH $COMPOSER_HOME/vendor/bin:$PATH
RUN ln -s /usr/bin/php7 /usr/bin/php

# Install ApiGen
RUN composer global config repositories.apigen/apigen vcs "https://github.com/$USER/apigen" && \
    composer global require "apigen/apigen:$VERSION" && \
    rm -r $COMPOSER_HOME/cache

ENTRYPOINT ["apigen"]
CMD ["--version"]
