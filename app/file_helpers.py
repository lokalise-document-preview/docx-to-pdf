from io import BytesIO
from zipfile import ZipFile
import urllib.request

ALLOWED_EXTENSIONS = set(['docx'])

def is_file_allowed(filename):
    return '.' in filename and \
        filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def unzip_into_bytes(url):
    zip = urllib.request.urlopen(url)
    archive = ZipFile(BytesIO(zip.read()))
    for file in archive.filelist:
        if not file.filename.endswith("/"):
            return archive.read(file)
