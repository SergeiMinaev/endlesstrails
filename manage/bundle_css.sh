#!/bin/bash

echo 'Bundle CSS.'
cd $ELT_HOME
source venv
cd manage
css-bundler -c .
