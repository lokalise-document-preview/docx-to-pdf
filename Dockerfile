FROM ubuntu:20.04

ARG TZ=Etc/UTC
ARG INIT_SRC=/usr/local/bin/dumb-init
ARG INIT_REPO=https://github.com/Yelp/dumb-init

ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=2121
ENV FLASK_ENV=production

EXPOSE 2121

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    &&  echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        libreoffice-writer \
        msttcorefonts \
        ttf-mscorefonts-installer \
        fontconfig \
        python3-uno \
        python3-pip \
        wget \
    && wget -O $INIT_SRC "$INIT_REPO/releases/download/v1.2.5/dumb-init_1.2.5_x86_64" \
    && chmod +x $INIT_SRC \
    && fc-cache -f -v \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


COPY ./app/requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip3 install -r requirements.txt

COPY ./app /app

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
CMD ["/app/start.sh"]
