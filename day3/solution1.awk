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
  while(match(substr($0,start),/[0-9]+/)){
    p = start + RSTART - 1
    num = substr($0, start + RSTART - 1, RLENGTH)
    start = start + RSTART + RLENGTH - 1
    if (check_symbols(p - 1,FNR,1) || check_symbols(start,FNR,1) || check_symbols(p - 1,FNR - 1, RLENGTH + 2) || check_symbols(p - 1,FNR + 1, RLENGTH + 2)){
      sum += num
    }
  }
}

function check_symbols(xpos,ypos,xlen){
  for(i=1;i<=xlen;i++){
    s = sprintf("%s:%s", ypos, xpos + i -1)
    if(sym_ix[s] == 1){
      return 1
    }
  }
}
END{print sum}



