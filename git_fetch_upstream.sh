#!/bin/bash
#git fetch upstream
update_branchs="master nightly r2.9 r2.8 r2.7 r2.6 r2.5"

#Black        0;30     Dark Gray     1;30
#Red          0;31     Light Red     1;31
#Green        0;32     Light Green   1;32
#Brown/Orange 0;33     Yellow        1;33
#Blue         0;34     Light Blue    1;34
#Purple       0;35     Light Purple  1;35
#Cyan         0;36     Light Cyan    1;36
#Light Gray   0;37     White         1;37
R='\033[0;31m'
LR='\033[1;31m'
G='\033[0;32m'
LG='\033[1;32m'
OG='\033[0;33m'
LC='\033[1;36m'
NC='\033[0m' # No Color

fetch_upstream_to_origin(){
  git checkout $1
  git pull $1
  git merge upstream/$1
  git push origin $1
}

origin_branchs=`git branch -a | grep origin | grep -v HEAD`
upstream_branchs=`git branch -a | grep upstream`
#echo $origin_branchs
#echo $upstream_branchs

for bn in $origin_branchs
do
  bn_name=`echo $bn | awk -F'/' '{print $3}'`
  if [[ $upstream_branchs =~ $bn_name ]]
  then
    up_bn=remotes/upstream/$bn_name
    #origin_commit=`git log $bn --oneline -n 1 | awk '{print $1}'`
    origin_commit=`git log $bn --pretty=format:"%h" -n 1 `
    upstream_commit=`git log $up_bn --pretty=format:"%h" -n 1 `
    if [[ $origin_commit == $upstream_commit ]]
    then
      echo -e "${LR}$bn${NC} ${LC}passed(up-to-date)${NC}"
    else
      echo -e "${LR}$bn${NC}${OG}:$origin_commit${NC} -> ${LR}$up_bn${NC}${OG}:$upstream_commit${NC} ${LG}update${NC}"
      # do update
    fi
  else
    echo -e "${LR}$bn${NC} ${R}not exist in upstream${NC}"
  fi
done
