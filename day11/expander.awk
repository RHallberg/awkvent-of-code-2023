BEGIN{FS=""}
{
  for(i=1;i<=NF;i++){
    input[NR,i] = $i
    if($i == "#"){
      g_x[i]++;g_y[NR]++;
    }
  }

}
END{
  for(i=1;i<=NR;i++){
    for(j=1;j<=NF;j++){
      out = sprintf("%s%s",out,input[i,j])
      if(!g_x[j]){
        out = sprintf("%sX",out)
      }
    }
    print out
    if(!g_y[i]){
      gsub(".","Y",out)
      print out
    }
    out = ""
  }

}
