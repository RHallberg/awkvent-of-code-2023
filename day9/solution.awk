{
  n = split($0,row)
  pred1 = $NF
  a2[n-1] = row[1]
  while(1){
    non_zeroes = 0
    for(i = 1; i < n; i++){
      row[i] = row[i+1] - row[i]
      non_zeroes += !(row[i] == 0)
    }
    pred1 += row[i-1]
    a2[n-2] = row[1]
    delete row[i+1];n -= 1
    if(!non_zeroes)break
  }
  for(i=1;i<=length(a2);i++) pred2 = a2[i] - pred2
  sum1+=pred1
  sum2+=pred2
  n=0;delete a2;pred2=0
}

END{print sum1 ORS sum2}

