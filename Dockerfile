FROM python:3.6.3-alpine3.6

ARG ICE_VERSION=3.7.0.1

RUN set -ex \
  && apk add --no-cache \
    libstdc++ \
    openssl-dev \
  && apk add --no-cache --virtual .build-deps \
    bzip2-dev \
    g++ \
  && pip install --global-option=build_ext --global-option="-D__USE_UNIX98" zeroc-ice==${ICE_VERSION} \
  && apk del .build-deps \
  && find /usr/local -depth \
       \( \
         \( -type d -a \( -name test -o -name tests \) \) \
         -o \
         \( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
       \) -exec rm -rf '{}' +;

CMD ["/bin/sh"]
