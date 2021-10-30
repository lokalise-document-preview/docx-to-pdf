#!/bin/bash

echo "Starting unoserver"
unoserver --daemon

sleep 1s

echo "Starting flask"
gunicorn \
    --workers 1 --worker-class sync \
    --timeout 10 --graceful-timeout 5 \
    --bind ${FLASK_RUN_HOST}:${FLASK_RUN_PORT} \
    --error-logfile '-' --log-level 'error' \
    app:app
