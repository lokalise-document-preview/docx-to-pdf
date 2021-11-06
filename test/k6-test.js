import http from 'k6/http';
import { sleep } from 'k6';

export default function () {
  http.post(
    'http://localhost:2121/convert-zip-from-url',
    '{ "url": "S3-url-here" }',
    { headers: { 'Content-Type': 'application/json' } }
  );
}
