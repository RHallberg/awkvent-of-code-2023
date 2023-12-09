BEGIN{lr_map["L"]=1;lr_map["R"]=2;SUBSEP=";";last = "ZZZ"; current = "AAA"}

NR == 1 {
  split($1,directions,"")
  next
}

NR > 2 {
 n_name = $1;n_l=$3;n_r=$4
 gsub(/(\(|\,)/,"",n_l);gsub(/\)/,"",n_r)
 nodes[n_name] = sprintf("%s%s%s",n_l,SUBSEP,n_r)
}

$1 ~ /A$/ {nbr_current++; current_nodes[nbr_current] = $1}
$1 ~ /Z$/ {end_nodes[$1] = $1}

function step(node,direction){
  split(nodes[node],paths,SUBSEP)
  p = paths[lr_map[direction]]
  delete paths
  return p
}
function gcd(a,b){
  while(b){
    r = a % b
    a = b;b = r
  }
  return a
}
END {
  n=0;i=1
  while(nbrwins < nbr_current){
    direction = directions[i]
    if(!direction){i=1; direction = directions[i]}
    for(j=1;j<=nbr_current;j++){
      new_node = step(current_nodes[j],direction)
      current_nodes[j] = new_node
      win = new_node in end_nodes
      if(win && !(j in wins)){
        wins[j] = n+1
        nbrwins++
      }
    }
    i++;n++
  }
  sum = 1
  for(i=1;i <= length(wins); i++){
    v = wins[i]
    sum = (sum * v) / gcd(sum,v)
  }
  print int(sum)
}
