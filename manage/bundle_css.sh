#!/bin/bash

cd $ELT_HOME
source venv
cd manage
css-bundler -c .
