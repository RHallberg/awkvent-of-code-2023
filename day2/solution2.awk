BEGIN{
  sum = 0
}
{
 gsub(".+:","")
 split($0,sets,";")
 maxcolor["blue"] = 0
 maxcolor["green"] = 0
 maxcolor["red"] = 0
 for(i=1;i<=length(sets);i++){
  split(sets[i], colors, ",")
  for(j=1;j<=length(colors);j++){
    # val[1] is number & val[2] is color
    split(colors[j],val," ")
    if(val[1] > maxcolor[val[2]]){
      maxcolor[val[2]] = val[1]
      }
    }
  }
  sum += maxcolor["blue"] * maxcolor["green"] * maxcolor["red"]
}
END {print sum}
