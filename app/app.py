from flask import Flask
from flask import request
from flask import Response
from pathlib import Path
from unoserver import converter
from file_helpers import is_file_allowed

app = Flask(__name__)
unoconvert = converter.UnoConverter()

# TODO Health check: convert a minimal ODF into PDF and verify that they are the same ***
@app.route("/health")
def health():
    return 'Ok'

@app.route('/upload', methods=['POST'])
def upload_file():    
    if 'file' not in request.files:
        return 'No file part'

    file = request.files['file']

    if file.filename == '':
        return 'No selected file'

    if file and is_file_allowed(file.filename):
        pdfFilename = Path(file.filename).stem + ".pdf"
        pdfContent = unoconvert.convert(indata=file.read(), convert_to="pdf")

        response = Response(pdfContent, mimetype="application/pdf")
        response.headers['Content-Disposition'] = "attachment; filename=" + pdfFilename
        return response

if __name__ == "__main__":
    app.run()
