BEGIN{SUBSEP=";"}
$1 ~ /seeds/ {
  for(i=2;i<=NF;i+=2){
    rs = $i; re = $i+($(i+1)-1)
    srange = sprintf("%s%s%s", rs,SUBSEP,re)
    seeds[srange] = srange
  }
  next
}
$1 ~ /[[:alnum:]]-/ {split($1,a,"-"); dest = a[3]; next}
$0 == "" {dest = ""; next}

dest ~ /soil/ {soils[$2,$2+($3-1)] = sprintf("%s%s%s",$1,SUBSEP,$1+($3-1))}

dest ~ /fertilizer/ {fertilizers[$2,$2+($3-1)] = sprintf("%s%s%s",$1,SUBSEP,$1+($3-1))}

dest ~ /water/ {waters[$2,$2+($3-1)] = sprintf("%s%s%s",$1,SUBSEP,$1+($3-1))}

dest ~ /light/ {lights[$2,$2+($3-1)] = sprintf("%s%s%s",$1,SUBSEP,$1+($3-1))}

dest ~ /temperature/ {temperatures[$2,$2+($3-1)] = sprintf("%s%s%s",$1,SUBSEP,$1+($3-1))}

dest ~ /humidity/ {humidities[$2,$2+($3-1)] = sprintf("%s%s%s",$1,SUBSEP,$1+($3-1))}

dest ~ /location/ {locations[$2,$2+($3-1)] = sprintf("%s%s%s",$1,SUBSEP,$1+($3-1))}


function corr_val(a,val){

  for (range in a){
    split(range,inr,SUBSEP)
    if(val >= inr[1] && val <= inr[2]){
      split(a[range],outr,SUBSEP)
      return outr[1]+(val-inr[1])
    }
  }
  return val
}

function move_down(seed_r, src_r,src_a,from_a,to_a){
  # print "checking intersection of seed_r " seed_r " and src_r " src_r
  split(seed_r,seedr,SUBSEP)
  split(src_r,srcr,SUBSEP)
  r1_start = seedr[1];r1_end = seedr[2]
  r2_start = srcr[1];r2_end = srcr[2]
  # Check if seed_r is contained within source/dest range
  if (r1_start >= r2_start && r1_end <= r2_end){
    new_r1_start = corr_val(src_a,r1_start);new_r1_end = corr_val(src_a,r1_end)
    new_seed_r = sprintf("%s%s%s", new_r1_start,SUBSEP,new_r1_end)
    to_a[new_seed_r] = new_seed_r
    delete from_a[seed_r]
    return
  }

  # Check if source/dest range is fully within seed_r
  else if(r2_start >= r1_start && r2_end <= r1_end){
    isct_r = sprintf("%s%s%s",corr_val(src_a, r2_start),SUBSEP,corr_val(src_a,r2_end))
    new_r1_1_start = r1_start; new_r1_1_end = r2_start-1
    new_r1_2_start = r2_end+1;new_r1_2_end = r1_end
    new_r1_1 = sprintf("%s%s%s",new_r1_1_start,SUBSEP,new_r1_1_end)
    new_r1_2 = sprintf("%s%s%s",new_r1_2_start,SUBSEP,new_r1_2_end)
    to_a[isct_r] = isct_r
    delete from_a[seed_r]
    from_a[new_r1_1] = new_r1_1;from_a[new_r1_2] = new_r1_2

    return
  }
  # Check if seed_r and src_r intersect
  if ((r1_start <= r2_end) && (r2_start <= r1_end)) {
    if(r1_start > r2_start){
      intersect_start = r1_start
      new_r1_end = r1_end
    }
    else{
      intersect_start = r2_start
      new_r1_end = r2_start-1
    }
    if(r1_end < r2_end){
      intersect_end = r1_end
      new_r1_start = r1_start
    }
    else{
      intersect_end = r2_end
      new_r1_start = r2_end+1
    }
    isct_r = sprintf("%s%s%s",corr_val(src_a, intersect_start),SUBSEP,corr_val(src_a,intersect_end))
    new_r1 = sprintf("%s%s%s",new_r1_start,SUBSEP,new_r1_end)
    from_a[new_r1] = new_r1
    delete from_a[seed_r]
    to_a[isct_r]

    return
  }
}
END{
  for(soil in soils){
    for(seed in seeds){
      move_down(seed,soil,soils,seeds,level2)
    }
  }
  for(seed in seeds){
    level2[seed] = seed
    delete seeds[seed]
  }
  for(fertilizer in fertilizers){
    for(seed in level2){
      move_down(seed,fertilizer,fertilizers,level2,level3)
    }
  }
  for(seed in level2){

    level3[seed] = seed
    delete level2[seed]
  }
  for(water in waters){
    for(seed in level3){
      move_down(seed,water,waters,level3,level4)
    }
  }
  for(seed in level3){
    level4[seed] = seed
    delete level3[seed]
  }
  for(light in lights){
    for(seed in level4){
      move_down(seed,light,lights,level4,level5)
    }
  }
  for(seed in level4){
    level5[seed] = seed
    delete level4[seed]
  }
  for(temperature in temperatures){
    for(seed in level5){
      move_down(seed,temperature,temperatures,level5,level6)
    }
  }
  for(seed in level5){
    level6[seed] = seed
    delete level5[seed]
  }
  for(humidity in humidities){
    for(seed in level6){
      move_down(seed,humidity,humidities,level6,level7)
    }
  }
  for(seed in level6){
    level7[seed] = seed
    delete level6[seed]
  }
  for(location in locations){
    for(seed in level7){
      move_down(seed,location,locations,level7,level8)
    }
  }
  for(seed in level7){
    level8[seed] = seed
    delete level7[seed]
  }
  # WHY IS THERE NO INT_MAX CONSTANT IN AWK????!?!?
  smallest = 10000000000000000000000
  for(seed in level8){
    split(seed,level8_r,SUBSEP)
    range_start = level8_r[1]
    if(range_start < smallest)smallest = range_start
  }
  print smallest

}
