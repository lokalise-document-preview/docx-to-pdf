## Deploy
Run minimal instance: https://fly.io/docs/about/pricing/
```
docker build . --platform linux/amd64 -t ghcr.io/lokalise-document-preview/docx-to-pdf-convert-with-libreoffice:latest
docker push ghcr.io/lokalise-document-preview/docx-to-pdf-convert-with-libreoffice:latest
flyctl --app docx-to-pdf-convert-with-libreoffice deploy .
```


## Load testing

https://k6.io/docs/getting-started/running-k6/
```
docker run \
    --memory="256m" \
    --cpus="1" \
    -p 2121:2121 \
    ghcr.io/lokalise-document-preview/docx-to-pdf-convert-with-libreoffice:latest

k6 run --vus 3  --duration 30s test/k6-test.js
```