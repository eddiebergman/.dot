# template
# Creates templates by copying from a preconfigured template folder
# or by calling a template handler that performs extra steps
# See template_help for more

template_root="$drtemplate"
template_dirs=($template_root/*/)

template() {
    arg $1 "list" && shift && template_list "$@" && return
    arg $1 "read" && shift && template_read "$@" && return
    arg $1 "note" && shift && template_note "$@" && return
    arg $1 "edit" && $EDITOR $template_root && return
    arg $1 "--help" "-h" || lt $# 2 && template_help && return

    name=$1
    outpath=$2
    if two $#; then
        if ! writable "$(dirname $outpath)"; then
            echo "Can't write to $(dirname $outpath), does direcotry exist?" && return; fi

        filepath="$(find $template_root -name $name)"
        case "$(filecount $name $template_root)" in
            "1") cp $filepath $outpath && echo "copied"; return;;
            "0") echo "$name was not found in templates"; return;;
            *) echo "$name was matched to too many files\n$filepath"; return;;
        esac
    fi
}

template_read() {
    filepath="$(find "$template_root" -name $1)"
    case "$(filecount $1 $template_root)" in
        "1") cat $filepath; return;;
        "0") echo "$name was not found in templates"; return;;
        *) echo "$name was matched to too many files\n$filepath"; return;;
    esac
}

template_list() {
    arg $1 "paths" && map echo "${template_dirs[@]}" && return
    zero $# || arg $1 "all" && tree "$template_root"  && return
    return
}

template_note_dir="$drtemplate/tex/note"

template_note() {
    ! one $# || arg $1 "--help" "-h" && template_note_help && return

    local out=$1
    local dir=$(dirname $out)
    if ! writable "$dir"; then
        echo "Can't write to $dir, does directory exist?" && return; fi

    cp "$template_note_dir/note_template.tex" "$out.tex"
    ln -sfn "$template_note_dir/note_preamble.tex" "$dir/note_preamble.tex"
    exists "$dir/build" || mkdir "$dir/build"
    exists "$dir/figures" || mkdir "$dir/figures"
    return
}

template_help() {
    echo "
    $ template <name> <path>

        Copies a template called <name> located beneath \$template_root to <path>.

    $ template list [all]

        List all templates under \$template_root

    $ template list paths

        List all paths under \$template_root

    $ template read <name>

        Cats out the template for reading into another file or looking at

    $ template edit

        Opens \$EDITOR in \$template_root

    ---------------
    Available template handlers:

    $ template note --help
    "
    return
}

template_note_help() {
    echo "
        template note <path>
        -----
        Sets up a directory with the following:
            - A template tex note at path
            - Symlink my preamble to the directory
            - Create 'build' and 'figures' folders (integrates with other tools)
    "
    return
}
