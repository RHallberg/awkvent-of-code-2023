BEGIN {sum = 0}
# Loading the array of indices of symbols
NR == FNR {
  for(i=1;i<=length($0);i++){
    if (substr($0,i,1) == "S"){
      sym_ix[sprintf("%s:%s", FNR, i)] = 1
    }
  }
  next
}

{
  start = 1
  # Checking symbols on same line
  while(match(substr($0,start),/(S[0-9]+|[0-9]+S)/)){
    num = substr($0, start + RSTART -1, RLENGTH)
    gsub("S", "", num)
    sum += num
    start = start + RSTART + RLENGTH -2
  }

  start = 1
  # Checking symbols on adjacent lines
  while(match(substr($0,start),/\.[0-9]+\./)){
    p = start + RSTART -1
    num = substr($0, start + RSTART, RLENGTH - 2)
    if (!(check_symbols(p,FNR - 1, RLENGTH) && check_symbols(p,FNR + 1, RLENGTH))){
      sum += num
    }
    start = start + RSTART + RLENGTH - 2
  }
}

function check_symbols(xpos,ypos,xlen){
  no_adj = 1
  for(i=1;i<=xlen;i++){
    s = sprintf("%s:%s", ypos, xpos + i -1)
    no_adj = no_adj && (sym_ix[s] == 0)
  }
  return no_adj
}
END{print sum}



