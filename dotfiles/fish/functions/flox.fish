# https://flox.dev
# https://flox.dev/docs/tutorials/default-environment/#initial-setup

function check_path_prefix
  set -l prefix $argv[1]
  set -l found false

  for path_element in $PATH
    if string match -q -r "^$prefix" "$path_element"
      set found true
      break
    end
  end

  if $found
    return 0
  else
    return 1
  end
end

function on_fish_prompt_flux --on-event fish_prompt
  if status is-interactive
    # TODO Scan upwards...
    if [ -d "$PWD/.flox/" ]
      if ! check_path_prefix "$PWD/.flox/"
        if command -q flox
          echo "✨ Activating 🕰️  Flux ⚛️  capacitor... 💫"
          flox activate -m run | source
        else
          echo ".flow/ directory presence requires https://flox.dev to be installed..."
        end
      end
    else
      # TODO De-activate! How?!
    end
  end
end
