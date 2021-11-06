import http from 'k6/http';
import { sleep } from 'k6';

export default function () {
  http.post(
    '{ "url": "S3-url-here" }',
    'https://docx-to-pdf-convert-with-libreoffice.fly.dev/convert-zip-from-url',
    { headers: { 'Content-Type': 'application/json' } }
  );
}
