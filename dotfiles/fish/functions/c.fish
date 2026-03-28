function c --description "Use glow for Markdown files, fallback to bat"
    set -l target $argv[1]

    # Check if the first argument ends in .md (case-insensitive)
    if string match -q -i "*.md" "$target"
        if command -sq glow
            glow -p $argv
            return
        end
    end

    # Fallbacks for non-markdown files or if glow isn't installed
    if command -sq batcat
        batcat $argv
    else if command -sq bat
        bat $argv
    else
        cat $argv
    end
end
