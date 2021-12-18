#!/bin/bash
#Install pyvenv with jupiter in current directory

cp -n ~/.local/bin/setupjupiter/{Makefile,requirements.txt} .
make setup
