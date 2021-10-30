ALLOWED_EXTENSIONS = set(['docx'])

def is_file_allowed(filename):
    return '.' in filename and \
        filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS
