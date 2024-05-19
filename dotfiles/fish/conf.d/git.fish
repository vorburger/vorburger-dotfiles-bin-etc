function gacp --argument-names MESSAGE --wraps git --description 'git add . && git commit -m .. && git push'
  git add .
  git commit -m $MESSAGE
  git push
end

function gac --argument-names MESSAGE --wraps git --description 'git add . && git commit -m'
  git add .
  git commit -m $MESSAGE
end

function gsts --description 'git status on repos in all sub-directories'
  find . -name .git -type d -exec sh -c 'echo -e "\n\n{}" && git --git-dir={} --work-tree={}/.. status' \;
end
