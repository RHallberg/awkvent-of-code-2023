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

  sym["|"] = "┃"
  sym["-"] = "━"
  sym["F"] = "┏"
  sym["J"] = "┛"
  sym["L"] = "┗"
  sym["7"] = "┓"

}

{
  for(i=1;i<=NF;i++){
    if($i ~ /[^,*]/){
      out[NR,i] = "\033[47m\033[30m*\033[0m"
      if($i == "S"){
        start = sprintf("%s;%s", NR, i)
        out[NR,i] = "\033[42mS\033[0m"
      }
      pipes[NR,i] = $i
    }
    else if($i == "*"){
      out[NR,i] = "\033[47m\033[30m*\033[0m"
    }
    else{
      out[NR,i] = "\033[36m \033[0m"
    }
  }
}

function step(pos){
  split(pos,pos_a,";");py=pos_a[1];px=pos_a[2];dir=pos_a[3]
  pipe = pipes[py,px]
  pipe_loop[py,px] = pipe
  out[py,px] = sprintf("\033[31m%s\033[0m",sym[pipe])
  split(tf[pipe,dir],tfs,";");y=tfs[1];x=tfs[2];d=tfs[3]
  py += y; px += x; dir = d
  return sprintf("%s;%s;%s",py,px,dir)
}

function push(val){
  stack[++top] = val
}

function pop(){
  return stack[top--]
}

function flood(start){
  push(start)
  while(top > 0){
    v = pop();split(v,vv,";");vy = vv[1];vx = vv[2];vd = vv[3]
    pipe = pipe_loop[vy,vx]
    if(vy <= NR+1 && vx <= NF && vy>= 1 && vx >= 1 && !pipe && !filled[vy,vx]){
      out[vy,vx] = sprintf("\033[46m%s\033[0m"," ")
      filled[vy,vx] = 1
      push(sprintf("%s;%s;S",vy-1,vx))
      push(sprintf("%s;%s;N",vy+1,vx))
      push(sprintf("%s;%s;W",vy,vx+1))
      push(sprintf("%s;%s;E",vy,vx-1))
    }
  }

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
  step(p1)
  flood("1;1")



  for(i=0;i<=NR+1;i++){
    for(j=0;j<=NF+1;j++){
      printf out[i,j]
    }
    print ""
  }
  print n
}
