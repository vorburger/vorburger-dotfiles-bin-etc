function s --argument-names HOST --wraps ssh --description 'ssh -At .. fish'
  if ! test -O $SSH_AUTH_SOCK
    echo "ssh canceled because $SSH_AUTH_SOCK does not exist (or is not owned by the current user)"
    return 3
  end
  ssh -At $HOST fish
end
