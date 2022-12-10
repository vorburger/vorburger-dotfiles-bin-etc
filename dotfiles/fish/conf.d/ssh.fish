function s --argument-names HOST --wraps ssh --description 'ssh -At .. fish'
  ssh -At $HOST fish
end
