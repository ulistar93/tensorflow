update_branchs="master "

git fetch upstream
for bn in $update_branchs
do
  git checkout $bn
  git pull $bn
  git merge upstream/$bn
  git push origin $bn
done
