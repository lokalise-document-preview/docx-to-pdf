import http from 'k6/http';
import { sleep } from 'k6';

export default function () {
  http.post(
    'https://docx-to-pdf-convert-with-libreoffice.fly.dev/convert-zip-from-url',
    '{ "url": "https://s3-eu-west-1.amazonaws.com/lokalise-assets/files/export/730319336169a6dad41f59.61887305/7a658152e03163d4f5752f27d9b2284e/HTML_test_project.zip" }',
    { headers: { 'Content-Type': 'application/json' } }
  );
}
