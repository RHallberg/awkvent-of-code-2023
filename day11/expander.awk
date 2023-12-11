BEGIN{FS=""}
{
  for(i=1;i<=NF;i++){
    if($i == "#"){
      g_x[i]++;g_y[NR]++;
      input[NR,i] = ++galaxies
    }
    else{
      input[NR,i] = $i
    }
  }

}
END{
  for(i=1;i<=NR;i++){
    for(j=1;j<=NF;j++){
      out = sprintf("%s%s",out,input[i,j])
      if(!g_x[j]){

        out = sprintf("%s.",out)

      }
    }
    print out
    if(!g_y[i]){
      print out
    }
    out = ""
  }

}
