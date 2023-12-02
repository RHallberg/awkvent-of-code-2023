BEGIN{
  nbrcolors["blue"] = 14
  nbrcolors["green"] = 13
  nbrcolors["red"] = 12
  sum = 0
}
{
 match($0, /[0-9]+:/)
 id = substr($0,RSTART,RLENGTH)
 gsub(".+:","")
 split($0,sets,";")
 possible = 1
 for(i=1;i<=length(sets);i++){
  split(sets[i], colors, ",")
  for(j=1;j<=length(colors);j++){
    # val[1] is number & val[2] is color
    split(colors[j],val," ")
    possible = possible && (val[1] <= nbrcolors[val[2]])
    }
  }
  if(possible){
    sum += id
    }
}
END {print sum}
