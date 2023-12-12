{
  nbr_l = split($1,ss,"")
  nbr_b = split($2,bb,",")
  for(v in bb)r_tot += bb[v]
  perms[++nbr_p] = ""
  for(i=1;i<=nbr_l;i++){
    if(ss[i] ~ /(#|\.)/){
      if(ss[i] == "#")is_s=1
      for(p in perms){
        nbr_s[p]+=is_s
        perms[p] = sprintf("%s%s",perms[p],ss[i])
      }
      is_s = 0
    }
    else{
      n = nbr_p
      for(j=1;j<=n;j++){
        p2 = perms[j]
        perms[j] = sprintf("%s%s",perms[j],".")
        nbr = nbr_s[j]
        if(nbr_s[j] < r_tot){
          perms[++nbr_p] = sprintf("%s#",p2)
          nbr_s[nbr_p] = nbr+1
        }
      }
    }

  }
  

  
  for(i=1;i<=nbr_p;i++){
    n=1
    permutation = perms[i]
    if(nbr_s[i] == r_tot){
      valid = 1
      while(match(substr(perms[i],start),/#+/)){
        line = substr(perms[i], RSTART, RLENGTH)
        perms[i] = substr(perms[i],RSTART + RLENGTH)
        if(bb[n] != length(line)){valid = 0;break}
        n++

      }
      if(valid)print permutation
    }
  }
  delete perms;delete nbr_s;r_tot=0;delete bb; delete ss;nbr_p = 0

}
