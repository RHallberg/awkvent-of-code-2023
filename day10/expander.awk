BEGIN{FS=""}

{
  for(i=1;i<=NF;i++){
    if($i == "."){
      r1 = sprintf("%s,,,",r1)
      r2 = sprintf("%s*,*",r2)
      r3 = sprintf("%s,*,",r3)
    }
    else if($i == "-"){
      r1 = sprintf("%s,,,",r1)
      r2 = sprintf("%s---",r2)
      r3 = sprintf("%s,,,",r3)
    }
    else if($i == "|"){
      r1 = sprintf("%s,|,",r1)
      r2 = sprintf("%s,|,",r2)
      r3 = sprintf("%s,|,",r3)
    }
    else if($i == "7"){
      r1 = sprintf("%s,,,",r1)
      r2 = sprintf("%s-7,",r2)
      r3 = sprintf("%s,|,",r3)
    }
    else if($i == "F"){
      r1 = sprintf("%s,,,",r1)
      r2 = sprintf("%s,F-",r2)
      r3 = sprintf("%s,|,",r3)
    }
    else if($i == "L"){
      r1 = sprintf("%s,|,",r1)
      r2 = sprintf("%s,L-",r2)
      r3 = sprintf("%s,,,",r3)
    }
    else if($i == "J"){
      r1 = sprintf("%s,|,",r1)
      r2 = sprintf("%s-J,",r2)
      r3 = sprintf("%s,,,",r3)
    }
    else if($i == "S"){
      r1 = sprintf("%s,|,",r1)
      r2 = sprintf("%s-S,",r2)
      r3 = sprintf("%s,,,",r3)
    }
  }
  printf("%s\n",r1)
  printf("%s\n",r2)
  printf("%s\n",r3)
  r1="";r2="";r3=""
}
