function gacp --argument-names MESSAGE --wraps git --description 'git add . && git commit -m .. && git push'
  git add .
  git commit -m $MESSAGE
  git push
end
