BEGIN{sum1=1}

function lower_bound(t,d){
  x=(t/2 - sqrt((t/2)**2-(d+1)));return int(x)+(x>int(x))
}

function upper_bound(t,d){
  x=(t/2 + sqrt((t/2)**2-(d+1)));return int(x)
}
$1 ~ /Time/ {for(i=2;i<=NF;i++){times[i]=$i;time2 = sprintf("%s%s",time2,$i)}}
$1 ~ /Distance/ {
  for(i=2;i<=NF;i++){sum1 *= (upper_bound(times[i],$i) - lower_bound(times[i],$i) + 1);distance2 = sprintf("%s%s",distance2,$i)}
  print sum1
  print upper_bound(time2,distance2) - lower_bound(time2,distance2) + 1
}

