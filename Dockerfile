FROM ubuntu:20.04

ENV TZ=Etc/UTC

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
    && fc-cache -f -v

COPY ./app/requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip3 install -r requirements.txt

COPY ./app /app

ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=2121
ENV FLASK_ENV=production

EXPOSE 2121

CMD ["/app/start.sh"]
