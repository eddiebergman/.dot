# template
# Creates templates by copying from a preconfigured template folder
# or by calling a template handler that performs extra steps
# See template_help for more
source "$drzsh/template.help.zsh"

template_root="$drtemplate"
template_dirs=($template_root/*/)

template_note_preamble="$drtemplate/note/note_preamble.tex"
template_note_template="$drtemplate/note/note_template.tex"

template() {
    arg $1 "list" && shift && template_list "$@" && return
    arg $1 "read" && shift && template_read "$@" && return
    arg $1 "note" && shift && template_note "$@" && return
    arg $1 "edit" && $EDITOR $template_root && return
    arg $1 "--help" "-h" || lt $# 2 && template_help && return

    local name=$1
    local outpath=$2
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

template_link() {

}

template_read() {
    if helparg $1; then
        template_read_cdoc; return; fi

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
    if arg $1 "help" "-h" "--help"; then
        template_list_cdoc; return; fi
    if zero $#; then
        tree "$template_root"
        printf "\n~ ${Purple}Handlers${NC}\n$(template_note_cdoc)"
        return

    elif arg $1 "folders"; then
        foreach dir ("${template_dirs[@]}")
            printf "${Cyan}$(basename $dir)${NC}\n" 
        end
        return
    else
        local folder=$1
        for dir in "${template_dirs[@]}"; do
            if equal $folder $(basename $dir); then
                if emptydir $dir; then
                    printf "${Cyan}<Empty>${NC}\n"
                    return
                else
                    foreach file ($template_root/$folder/*)
                        printf "${Cyan}$(basename $file)${NC}\n"; end
                    return
                fi
            fi
        done

        # No folder matches
        printf "Sorry, could not find ${Cyan}$folder${NC}\nHere are known folders $(template list folders)"
        return
    fi
}

template_note() {
    if ! exists $template_note_preamble; then
        printf "Can't find preamble at $template_note_preamble";  return; fi
    if ! exists $template_note_template; then
        printf "Can't find template at $template_note_template";  return; fi

    if ! one $# || arg $1 "help" "--help" "-h"; then
        template_note_cdoc; return; fi

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

template_add() {
    echo "hello from "
    return
}
