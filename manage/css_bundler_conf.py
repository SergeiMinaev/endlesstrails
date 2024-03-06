import os


SRC_FILES = ['front/style/core/core.css', 'front/style/admin/admin.css']
SRC_DIR = os.environ['ELT_HOME']
OUT_DIR = os.path.join(os.environ['ELT_HOME'], 'static/style')
