import os
from os.path import join


BASE_DIR = os.environ['ELT_HOME']


PATHS = [
    {
        'dir': join(BASE_DIR, 'front/js'),
    },
    {
        'dir': join(BASE_DIR, 'front/templates'),
    },
    {
        'dir': join(BASE_DIR, 'front/style'),
        'onchange': {
            'cmds': [
                './bundle_css.sh',
            ],
        },
    },
    {
        'dir': join(BASE_DIR, 'front/ext'),
    },
]
