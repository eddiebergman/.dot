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
    if arg $1 "folders"; then
        foreach dir ("${template_dirs[@]}") printf "${Cyan}$(basename $dir)${NC}\n"; end
        return
    fi

    tree "$template_root"
    printf "
    ~ ${Purple}Handlers${NC}

    $(template_note_help)"
    return
}

template_note_preamble="$drtemplate/note/note_preamble.tex"
template_note_template="$drtemplate/note/note_template.tex"
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

    ${Green}$ template ${Yellow}<name>${NC} ${Yellow}<path>${NC}${NC}
    ${Green}--------------------------------------------------${NC}
    Copies template ${Yellow}<name>${NC} to ${Yellow}<path>${NC}.

    ${Green}$ template list [ ${Yellow}<folder>${NC}${Green} | folders ]${NC}
    ${Green}--------------------------------------------------${NC}
    List all templates, optionally specifying which ${Yellow}<folder>${NC}
    Add ${Green}folders${NC} to list all folders under ${UYellow}\$template${NC}.

    ${Green}$ template read ${Yellow}<name>${NC}${NC}
    ${Green}--------------------------------------------------${NC}
    Read out template with ${Yellow}<name>${NC}.

    ${Green}$ template edit [${Yellow}<name>${NC}${Green}]
    ${Green}--------------------------------------------------${NC}
    Opens ${UYellow}\$EDITOR${NC} in ${UYellow}\$template_root${NC}.

    ${Green}$ template add [${Yellow}<folder>${NC}${Green}] ${Yellow}<file>${NC}
    ${Green}--------------------------------------------------${NC}
    Creates a copy of ${Yellow}<file>${NC} and stores it under ${UYellow}\$template_root${NC}.
    Optionally, pass a ${Yellow}<folder>${NC} to store it in, creating one if it does not exists.

    $(template_note_help)

~ ${BYellow}Settings${NC}

    ${Cyan}main-settings${NC}
    ${UYellow}template_root${NC}
    =$template_root

    ${UYellow}EDITOR${NC}
    =$EDITOR

    $(template_note_settings)"
    return
}

template_note_help() {
    printf "${Green}$ template note ${Yellow}<path>${NC}
    ${Green}--------------------------------------------------${NC}
    Creates folders, links tex preamble and copies tex template to ${Yellow}<path>${NC}."
    return
}

template_note_settings() {
    printf "${Cyan}note-settings${NC}
    ${UYellow}template_note_preamble${NC}
    =$template_note_preamble

    ${UYellow}template_note_template${NC}
    =$template_note_template"
    return

}

