# venv is (must be) a function instead of a bash or fish script,
# because it has to source the venv activate script which sets
# environment variables that need to be kept visible.

function venv -a DIR -d "Create or Enter Python Virtual Environment"

  if not set -q argv[1]
    echo "USAGE: venv <Python-Virtual-Env-Directory>"
    return
  end

  if [ ! -d "$DIR" ]
    python3 -m venv "$DIR"
  end

  source "$DIR/bin/activate.fish"

end
