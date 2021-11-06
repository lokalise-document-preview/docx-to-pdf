Run minimal instance: https://fly.io/docs/about/pricing/
```
docker run \
    --memory="256m" \
    --cpus="1" \
    -p 2121:2121 \
    ghcr.io/lokalise-document-preview/docx-to-pdf-convert-with-libreoffice:latest
```

https://k6.io/docs/getting-started/running-k6/
```
k6 run --vus 3  --duration 30s test/k6-test.js
```