:: WORK-IN-PROGRESS
@echo off
::curl -s -F "file=@$1;type=text/css" -F output=text "http://jigsaw.w3.org/css-validator/validator/"
curl -s -F "file=@%1;type=text/css" -F output=text "http://jigsaw.w3.org/css-validator/validator/"
