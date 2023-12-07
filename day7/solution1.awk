BEGIN{
  card_scoring["A"]=114
  card_scoring["K"]=113
  card_scoring["Q"]=112
  card_scoring["J"]=111
  card_scoring["T"]=110
  for(i=9;i>1;i--){
    card_scoring[i]=i+100
  }

}
{
  len = split($1,chars,"")
  for (i=1;i <= len; i++){
    card_score = sprintf("%s%s",card_score,card_scoring[chars[i]])
    nbrchars[chars[i]]++
  }
  for(n in nbrchars){
    nbr = nbrchars[n]
    # Five of a kind
    if(nbr == 5){
      card_score = sprintf("%s%s",107,card_score)
      scored=1
      break
    }
    # Four of a kind
    else if(nbr == 4){
      card_score = sprintf("%s%s",106,card_score)
      scored=1
      break
    }
    else if(nbr == 3){
      three = 1
    }
    else if(nbr == 2){
      pairs++
    }
    # Full house
    if(three && pairs){
      card_score = sprintf("%s%s",105,card_score)
      scored = 1
      break
    }
  }
  # Three of a kind
  if(three && !scored){
    card_score = sprintf("%s%s",104,card_score)
  }
  # Two pairs
  else if(pairs == 2 && !scored){
    card_score = sprintf("%s%s",103,card_score)
  }
  # One pair
  else if(pairs == 1 && !scored){
    card_score = sprintf("%s%s",102,card_score)
  }
  # High card
  else if(!scored){
    card_score = sprintf("%s%s",101,card_score)
  }
  print card_score FS $1 FS $2
  delete nbrchars;delete chars;card_score="";pairs=0;three=0;scored=0
}
