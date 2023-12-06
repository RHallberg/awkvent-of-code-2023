BEGIN{SUBSEP=";"}
$1 ~ /seeds/ {
  for(i=2;i<=NF;i++)seeds[i-1] = $i;next
}

$1 ~ /[[:alnum:]]-/ {split($1,a,"-"); dest = a[3]; next}

$0 == "" {dest = ""; next}

dest ~ /soil/ {soils[$2,$2+($3-1)] = sprintf("%s%s%s",$1,SUBSEP,$1+($3-1))}

dest ~ /fertilizer/ {fertilizers[$2,$2+($3-1)] = sprintf("%s%s%s",$1,SUBSEP,$1+($3-1))}

dest ~ /water/ {waters[$2,$2+($3-1)] = sprintf("%s%s%s",$1,SUBSEP,$1+($3-1))}

dest ~ /light/ {lights[$2,$2+($3-1)] = sprintf("%s%s%s",$1,SUBSEP,$1+($3-1))}

dest ~ /temperature/ {temperatures[$2,$2+($3-1)] = sprintf("%s%s%s",$1,SUBSEP,$1+($3-1))}

dest ~ /humidity/ {humidities[$2,$2+($3-1)] = sprintf("%s%s%s",$1,SUBSEP,$1+($3-1))}

dest ~ /location/ {locations[$2,$2+($3-1)] = sprintf("%s%s%s",$1,SUBSEP,$1+($3-1))}


function corr_val(a,val){

  for (range in a){
    split(range,inr,SUBSEP)
    if(val >= inr[1] && val <= inr[2]){
      # print val "is in range: " range " corresponding range: " a[range]
      split(a[range],outr,SUBSEP)
      # print "corresponding value is: " outr[1]+(val-inr[1])
      return outr[1]+(val-inr[1])
    }
  }
  # print "corresponding value is: " val
  return val
}


END{
  i=1
  res = __INT_MAX__
  for(seed in seeds){
    v=corr_val(soils,seeds[i])
    v=corr_val(fertilizers,v)
    v=corr_val(waters,v)
    v=corr_val(lights,v)
    v=corr_val(temperatures,v)
    v=corr_val(humidities,v)
    v=corr_val(locations,v)
    print v
    i++
  }
  i=0
}
