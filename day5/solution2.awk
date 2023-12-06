BEGIN{SUBSEP=";"}
$1 ~ /seeds/ {
  for(i=2;i<=NF;i+=2){
    rs = $i; re = $i+($(i+1)-1)
    seeds[i] = sprintf("%s%s%s", rs,SUBSEP,re)
  }
  next
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
    split(a[range],inr,SUBSEP)
    if(val >= inr[1] && val <= inr[2]){
      split(range,outr,SUBSEP)
      return outr[1]+(val-inr[1])
    }
  }
  return val
}
function check_seeds(val){

  for (seed in seeds){
    split(seeds[seed],inr,SUBSEP)
    if(val >= inr[1] && val <= inr[2]){
      split(range,outr,SUBSEP)
      return 1
    }
  }
  print val " not in seeds"
  return 0
}


END{
  i=1
  for(i = 1111558812; i<=1614928763;i++){
    v=corr_val(locations,i)
    v=corr_val(humidities,v)
    v=corr_val(temperatures,v)
    v=corr_val(lights,v)
    v=corr_val(waters,v)
    v=corr_val(fertilizers,v)
    v=corr_val(soils,v)
    if(check_seeds(v)){
      print v
      break
    }
    i++
  }
  i=0
}
