#!/bin/bash
set -u
echo "${1} -> ${2}"
#gs -dNOPAUSE -dQUIET -dBATCH -sDEVICE=pdfwrite -dPDFSETTINGS=/printer -sOutputFile="${2}" "${1}"
gs -dNOPAUSE -dQUIET -dBATCH -sDEVICE=pdfwrite -dPDFSETTINGS=/ebook -sOutputFile="${2}" "${1}"
exit
