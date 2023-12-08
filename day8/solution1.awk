BEGIN{lr_map["L"]=1;lr_map["R"]=2;SUBSEP=";";last = "ZZZ"; current = "AAA"}

NR == 1 {
  split($1,directions,"")
}

NR > 2 {
 n_name = $1;n_l=$3;n_r=$4
 gsub(/(\(|\,)/,"",n_l);gsub(/\)/,"",n_r)
 nodes[n_name] = sprintf("%s%s%s",n_l,SUBSEP,n_r)
}

function step(node,direction){
  split(nodes[node],paths,SUBSEP)
  p = paths[lr_map[direction]]
  delete paths
  return p
}

END {
  n=0;i=1
  while(current != last){
    direction = directions[i]
    if(!direction){i=1; direction = directions[i]}
    current = step(current,direction)
    i++;n++
  }
  print n
}
