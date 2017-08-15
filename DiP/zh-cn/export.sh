#!/bin/sh

########################################
# Build diveintopython with xsltproc usage  build.sh
########################################
# Author:Zoom.Quiet (Zoom.Quiet@gmail.com)
# Version: 
#   0.5 zoomq::070823 fixed for DIP5.4b tag matter
#   0.4 chmod fixed
#   0.3 append mod 
#	0.2 fixed for export 
#	0.1 : First release 
#
cd '/data1/www/www.woodpecker/data/share/projects/diveintopy-zh-5.4b/zh-cn/'
chmod -R 775 ./
pwd
logf="/var/log/svn/2007obpexport/dipexport-`date +"%Y%m%d"`.log"
echo "###----------------------------###" > $logf
echo "###::start>" `date +"%Y/%m/%d %H:%M:%S"` >> $logf

./build.sh 2>> $logf &

#echo "###::end  >" `date +"%Y/%m/%d %H:%M:%S"` >> $logf
echo "###---------------------------###" >> $logf
exit

