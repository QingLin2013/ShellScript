#!bin/bash
printf "%-50s %-10s %-10s %-10s\n" "" AVG COUNT MAX
for PATTERN in "time\[[0-9]+\].*search_configuration" "time\[[0-9]+\].*search_product"
do
  egrep $PATTERN OCA.log | egrep -o "time\[[0-9]+\]" | egrep -o "[0-9]+" | awk -v var=$PATTERN 'BEGIN{
    sum = 0;
    max = 0;
  }
  {
    sum+=$0;
    if(max<$0) max = $0;
  }; 
  END{
    if(NR>0) {
        printf("%-50s %-10d% -10d% -10dI\n",var, sum/NR, NR, max); 
    }
  }' 2>/dev/null
done  
exit 0
