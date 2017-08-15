#!/bin/sh
#
# script name : build.sh
##################################################
# Build diveintopython with xsltproc usage shell #
##################################################
#
# Osmond Liang (sinosmond@gmail.com)
#
# Version 0.5 : Compress with bzip2
# Version 0.4 : Add xml zip file to download
# Version 0.3 : Add chm file to download
# Version 0.2 : Compress html and htmlflat with zip
# Version 0.1 : First release
#
##################################################
# 1. Let's build html files
##################################################
### 1.1. Let's chunk the doc in different files
##################################################
rm -rf ./dist/html
mkdir -p ./dist/html/images/callouts
cp ../common/images/*.png ./dist/html/images
cp ../common/images/callouts/*.png ./dist/html/images/callouts
cp ../common/css/diveintopython.css ./dist/html
cd xml
xsltproc \
    --timing \
    --stringparam base.dir "../dist/html/" \
    --output diveintopython.html \
    ../../common/xsl/html.xsl \
    diveintopython.xml
xsltproc \
    --timing \
    --output ../dist/html/index.html \
    ../../common/xsl/index.xsl \
    index.xml
cd ..
# Colorize Python program listings embedded in HTML pages
python ../common/py/colorize.py dist/html/
##################################################
# Add OA in the end of *.html for .deb build     #
##################################################
sh add_oa.sh
##################################################
### 1.2. Let's build the doc in one big file
##################################################
rm -rf ./dist/htmlflat
mkdir -p ./dist/htmlflat/images/callouts
cp ../common/images/*.png ./dist/htmlflat/images
cp ../common/images/callouts/*.png ./dist/htmlflat/images/callouts
cp ../common/css/diveintopython.css ./dist/htmlflat
cd xml
xsltproc \
    --timing \
    --output ../dist/htmlflat/diveintopython.html \
    ../../common/xsl/htmlsingle.xsl \
    diveintopython.xml
cd ..
# Colorize Python program listings embedded in HTML pages
python ../common/py/colorize.py dist/htmlflat/diveintopython.html

##################################################
# 2. Let's build bzip files
##################################################
lang='zh-cn'
version='5.4'
vl='5.4_zh-ch'
rm ../common/py/*.pyc
rm ../common/py/*.log
rm -rf ./dist/download
##################################################
### 2.1. Let's build bzip for html files
##################################################
mkdir -p ./dist/download/diveintopython-html-$vl
mkdir -p ./dist/download/diveintopython-htmlflat-$vl/html

cp -r ./dist/html ./dist/download/diveintopython-html-$vl
##  copy result html to zip dir
cp -r ../common/py ./dist/download/diveintopython-html-$vl
cp -r ./dist/htmlflat/* ./dist/download/diveintopython-htmlflat-$vl/html
cp -r ../common/py ./dist/download/diveintopython-htmlflat-$vl

cd ./dist/download/
tar -jcvf diveintopython-html-$vl.tar.bz2 diveintopython-html-$vl
tar -jcvf diveintopython-htmlflat-$vl.tar.bz2 diveintopython-htmlflat-$vl

rm -rf diveintopython-html-$vl diveintopython-htmlflat-$vl
cd ../..
##################################################
### 2.2. Let's build bzip for xml files
##################################################
mkdir -p ./dist/download/diveintopython-xml-$vl
cp -r xml ./dist/download/diveintopython-xml-$vl
cp build.sh build.xml make.bat make.sh ./dist/download/diveintopython-xml-$vl
cd ./dist/download/
tar -jcvf diveintopython-xml-$vl.tar.bz2 diveintopython-xml-$vl
rm -rf diveintopython-xml-$vl
cd ../..

##########################################################
# 3. Let's copy release files to dist/html/download
##########################################################
mkdir ./dist/html/download
cp -f ./dist/download/*.tar.bz2 ./dist/html/download
cp -f ./dist/chm/*.chm ./dist/html/download

exit
