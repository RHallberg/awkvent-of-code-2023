BEGIN{sum=0}
{
  cards[NR]=check_row($0)
}
function check_row(row){
  nbrwins = 0
  mynums = 0

  nbrf = split(row,fields)
  for(f=1; f<=nbrf;f++){
    if(mynums && winnums[NR,fields[f]]){
      nbrwins++
    }
    else if(!mynums){
      winnums[NR,fields[f]] = 1
    }
    mynums = mynums || fields[f] == "|"
  }
  return nbrwins
}

END{
  for(currcard=1;currcard<=NR;currcard++){
    newcards = cards[currcard]
    nbrcards[currcard]++
    nbrcurrcard = nbrcards[currcard]
    for(i=1;i<=nbrcurrcard;i++){
      for(j=1;j<=newcards;j++){
        nbrcards[j+currcard]++
      }
    }


  }
  sum=0
  for(card=1;card <= NR; card++){
    sum+=(nbrcards[card])
  }
  print sum
}


