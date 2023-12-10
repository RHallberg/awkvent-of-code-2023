BEGIN{
  FS=""
  # Mapping of y x transforms and direction you'd be coming from
  tf["|","N"] = "1;0;N"
  tf["|","S"] = "-1;0;S"
  tf["-","W"] = "0;1;W"
  tf["-","E"] = "0;-1;E"
  tf["F","E"] = "1;0;N"
  tf["F","S"] = "0;1;W"
  tf["J","W"] = "-1;0;S"
  tf["J","N"] = "0;-1;E"
  tf["L","N"] = "0;1;W"
  tf["L","E"] = "-1;0;S"
  tf["7","W"] = "1;0;N"
  tf["7","S"] = "0;-1;E"

}

{
  for(i=1;i<=NF;i++){
    if($i ~ /[^\.]/){
      if($i == "S")start = sprintf("%s;%s", NR, i)
      pipes[NR,i] = $i
    }
  }
}

function step(pos){
  split(pos,pos_a,";");py=pos_a[1];px=pos_a[2];dir=pos_a[3]
  pipe = pipes[py,px]
  split(tf[pipe,dir],tfs,";");y=tfs[1];x=tfs[2];d=tfs[3]
  py += y; px += x; dir = d
  return sprintf("%s;%s;%s",py,px,dir)
}


END{
  split(start,s_a,";");sy=s_a[1];sx=s_a[2]
  if(tf[pipes[sy-1,sx],"S"]){n++;pp[n] = sprintf("%s;%s;S",sy-1,sx)}
  if(tf[pipes[sy+1,sx],"N"]){n++;pp[n] = sprintf("%s;%s;N",sy+1,sx)}
  if(tf[pipes[sy,sx+1],"W"]){n++;pp[n] = sprintf("%s;%s;W",sy,sx+1)}
  if(tf[pipes[sy,sx-1],"E"]){n++;pp[n] = sprintf("%s;%s;E",sy,sx-1)}

  p1 = pp[1]
  p2 = pp[2]
  n = 1; split(p1,pp1,";");split(p2,pp2,";")
  while(pp1[1] != pp2[1] || pp1[2] != pp2[2]){
    p1 = step(p1)
    p2 = step(p2)
    n++
    split(p1,pp1,";");split(p2,pp2,";")
  }

  print n
}
