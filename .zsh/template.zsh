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
            printf "Can't write to $(dirname $outpath), does direcotry exist?\n"; return; fi

        filepath="$(find $template_root -name $name)"

        case "$(filecount $name $template_root)" in
            "1") cp $filepath $outpath; echo "copied";
                return;;
            "0") echo "$name was not found in templates"; 
                return;;
            *) echo "$name was matched to too many files\n$filepath"; 
                return;;
        esac
    fi
}

template_read() {
    filepath="$(find "$template_root" -name $1)"
    case "$(filecount $1 $template_root)" in
        "1") cat $filepath; 
            return;;
        "0") echo "$name was not found within $template_root";
            return;;
        *) echo "$name was matched to too many files\n$filepath";
            return;;
    esac
}

template_list() {
    tree "$template_root"
    printf "
    ~ ${Purple}Handlers${NC}

    $(template_note_help)"
    return
}

template_add() {
}

template_note_preamble="$drtemplate/note_preamble.tex"
template_note_template="$dtemplate/note_template.tex"
template_note() {
    if ! exists $template_note_preamble; then
        printf "Can't find preamble at $template_note_preamble";  return; fi
    if ! exists $template_note_template; then
        printf "Can't find template at $template_note_template";  return; fi

    if ! one $# || arg $1 "--help" "-h"; then
        template_note_help; return; fi

    local out=$1
    local dir=$(dirname $out)
    if ! writable "$dir"; then
        echo "Can't write to $dir, does directory exist?";  return; fi

    cp "$template_note_template" "$out.tex"
    ln -sfn "$template_note_preamble" "$dir/note_preamble.tex"
    exists "$dir/build" || mkdir "$dir/build"
    exists "$dir/figures" || mkdir "$dir/figures"
    return
}

template_help() {
    printf "
    =============
    ~ ${BBlue}template${NC}
    =============

    ~ ${BGreen}Usage${NC}

        ${Green}$ template <name> <path>
        .........................${NC}
        Copies template <name> to <path>

        ${Green}$ template list
        ......................${NC}
        List all templates

        ${Green}$ template read <name>
        .......................${NC}
        Print out template

        ${Green}$ template edit
        ................${NC}
        Opens \$EDITOR in \$template_root

        $(template_note_help)

    ~ ${BYellow}Settings${NC}

        ${Yellow}template_root${NC}
        =$template_root

        ${Yellow}EDITOR${NC}
        =$EDITOR\n"
    return
}

template_note_help() {
    printf "${Green}$ template note <path>
        ................${NC}
        Creates folders, links tex preamble and copies tex template"
    return
}

