#!/bin/sh
#
# script name : add_oa.sh
##################################################
# Add OA in the end of *.html for .deb build     #
##################################################
#
# Osmond Liang (sinosmond@gmail.com)
#
# Version 0.1 : First release
##################################################
cd dist/html/
cat <<! >>index.html

!
for dest in *; do
if [ -d $dest -a "$dest" != "images" -a "$dest" != "download" ]; then
for i in $dest/*.html; do
cat <<! >>$i

!
done
fi
done
cd ../..
exit