BEGIN{sum=0}
{
  for(i=1;i<=NF;i++){
    if(mynums && winnums[NR,$i]){
      nbrwins++
      if(nbrwins == 1){
        rsum = 1
      }
      else{
        rsum = rsum*2
      }
    }
    else if(!mynums){
      winnums[NR,$i] = 1
    }
    mynums = mynums || $i == "|"

  }
  sum += rsum
  nbrwins = 0
  rsum = 0
  mynums = 0
}
END{
  print sum
}

