BEGIN{FS=""}

$0 ~ /Y/ {y_offset++;next}

{
  for(i=1;i<=NF;i++){
    if($i == "#"){
      g[++galaxies] = sprintf("%s;%s",NR,i)
      gg[galaxies] = sprintf("%s;%s",NR+(y_offset*((10**6)-2)),i+(x_offset*((10**6)-2)))
    }
    if($i == "X"){
      x_offset++
    }
  }
  x_offset = 0
}
function abs(v){
  if(v<0)return -v
  return v
}

function dist(p1,p2){
  split(p1,pp,";");p1y = pp[1]; p1x = pp[2]
  split(p2,pp,";");p2y = pp[1]; p2x = pp[2]
  return abs(p2y-p1y)+abs(p2x-p1x)

}

END{
  for(i=1;i<=galaxies;i++){
    for(j=i+1;j<=galaxies;j++){
      g1 = g[i]; g2 = g[j]
      g1_2 = gg[i]; g2_2 = gg[j]
      
      sum += dist(g1,g2)
      sum2 += dist(g1_2,g2_2)
    }

  }
  print "sum1: " sum
  print "sum2: " sum2


}
