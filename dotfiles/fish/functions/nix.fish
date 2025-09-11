# TODO This works when sourced, but doesn't seem to auto-loaded... why?!
function nrp --wraps="nix run" --description="nrp trashy: Runs package 'trashy' from nixpkgs"
  nix run "nixpkgs#$argv[1]" $argv[2..-1]
end
