#!/bin/bash

NUMBER_OF_EXPERIMENTS=$2
NUMBER_OF_TRIALS=$1

for i in $(seq 1 $NUMBER_OF_EXPERIMENTS)
do

    python3 rando.py $NUMBER_OF_TRIALS
    xsltproc ../botox/scores.xsl results.xml > /tmp/rando$i.html
    
done

echo "<html>" > /tmp/bundle.html
xsltproc ../botox/bundle-reports.xsl /tmp/rando*.html >> /tmp/bundle.html
echo "</html>" >> /tmp/bundle.html

xsltproc ../botox/tableize-reports.xsl /tmp/bundle.html | sed -e "s/<\!--\/TR-->/<\/TR>/g" | sed -e "s/<\!--TR-->/<TR>/g" > /tmp/report.html
