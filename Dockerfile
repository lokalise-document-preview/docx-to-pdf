FROM ubuntu:20.04

ENV TZ=Etc/UTC

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        libreoffice-writer \
        python3-uno \
        python3-pip

COPY ./app/requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip3 install -r requirements.txt

COPY ./app /app

ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=2121
ENV FLASK_ENV=development

EXPOSE 2121

CMD ["/app/start.sh"]
