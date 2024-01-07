#!/bin/bash

NUMBER_OF_EXPERIMENTS=$2
NUMBER_OF_TRIALS=$1
#ESTIMATED_TIME_PER_EXPERIMENT=0
#ESTIMATED_TIME_REMAINING=0
#TRIALS_TOTAL=0
#TOTAL_RUNTIME=0

for i in $(seq 1 $NUMBER_OF_EXPERIMENTS)
do
    #start=`date +%s`
    #TRIALS_TOTAL=$((TRIALS_TOTAL+1))
    python3 rando.py $NUMBER_OF_TRIALS
    xsltproc ../botox/scores.xsl results.xml > /tmp/rando$i.html
   # end=`date +%s.%N`
   # runtime=$( echo "$end - $start" | bc -l )
   # runtime=`printf "%.0f\n" "$runtime"`
   # TOTAL_RUNTIME = $((TOTAL_RUNTIME + runtime))
   # ESTIMATED_TIME_PER_EXPERIMENT = $((TOTAL_RUNTIME / TRIALS_TOTAL)) 
   # echo "RUNTIME: $runtime"
   # echo "AVERAGE RUNTIME: $ESTIMATED_TIME_PER_EXPERIMENT"
    
done

echo "<html>" > /tmp/bundle.html
xsltproc ../botox/bundle-reports.xsl /tmp/rando*.html >> /tmp/bundle.html
echo "</html>" >> /tmp/bundle.html

xsltproc ../botox/tableize-reports.xsl /tmp/bundle.html | sed -e "s/<\!--\/TR-->/<\/TR>/g" | sed -e "s/<\!--TR-->/<TR>/g" > /tmp/report.html
