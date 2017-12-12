FROM python:3.6.3-alpine3.6

ARG ICE_VERSION=3.7.0.1
ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="Krutov Alexander <goozler@mail.ru>" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/goozler/zeroc_ice_python.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0-rc.1" \
      org.label-schema.description="An Alpine image with precompiled ZeroC ICE \
framework Python package"

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
