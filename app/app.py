from flask import abort
from flask import Flask
from flask import request
from flask import Response
from pathlib import Path
from unoserver import converter
from file_helpers import is_file_allowed
from file_helpers import unzip_into_bytes

app = Flask(__name__)
unoconvert = converter.UnoConverter()
healthCheckSampleFilepath = Path(__file__).resolve().parent.joinpath("sample_for_health_check.odt")

@app.route("/health")
def health():
    pdfContent = unoconvert.convert(inpath=healthCheckSampleFilepath, convert_to="pdf")
    if (len(pdfContent) == 11614):
        return 'Ok'
    else:
        abort(500)

@app.route('/convert-file', methods=['POST'])
def convert_file():    
    if 'file' not in request.files:
        return 'No file part'

    file = request.files['file']

    if file.filename == '':
        return 'No selected file'

    if file and is_file_allowed(file.filename):
        return return_pdf(
            content = unoconvert.convert(indata = file.read(), convert_to = "pdf")
        )

@app.route('/convert-zip-from-url', methods=['POST'])
def convert_zip_from_url():
    url_to_download = request.json['url']
    file_bytes = unzip_into_bytes(url_to_download)
    return return_pdf(
        content = unoconvert.convert(indata = file_bytes, convert_to = "pdf")
    )

def return_pdf(content, filename="preview.pdf"):
    response = Response(content, mimetype="application/pdf")
    response.headers['Content-Disposition'] = "attachment; filename=" + filename
    return response

if __name__ == "__main__":
    app.run()
