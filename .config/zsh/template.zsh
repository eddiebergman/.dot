#!/bin/bash
# Creates templates by copying from a preconfigured template folder
# or by calling a template handler that performs extra steps
# See template_help for more
# TODO: Implement add and edit

template_root="$drtemplate"
template_dirs=($template_root/*/)

template_note_preamble="$drtemplate/note/note_preamble.tex"
template_note_template="$drtemplate/note/note_template.tex"
template_note_class_singlepage="$drtemplate/note/singlepage.cls"
template_note_class_twocol="$drtemplate/note/twocol.cls"
template_note_bib="$drlib/bibs/mybib.bib"
template_help() {
    printf "
=============
~ ${BBlue}template${NC}
=============

~ ${BGreen}Commands${NC}

    $(template_cdoc)
    $(template_list_cdoc)
    $(template_read_cdoc)
    $(template_edit_cdoc)
    $(template_add_cdoc)
    $(template_note_cdoc)
    $(template_link_cdoc)

~ ${BGreen}File management${NC}

    For more removing or performing more complex operations, please do so manually
    at ${UYellow}\$template_root${NC}.

~ ${BYellow}Settings${NC}

    ${Cyan}main-settings${NC}
    ${UYellow}template_root${NC}
    =$template_root

    ${UYellow}EDITOR${NC}
    =$EDITOR

    ${Cyan}note-settings${NC}
    ${UYellow}template_note_preamble${NC}
    =$template_note_preamble

    ${UYellow}template_note_template${NC}
    =$template_note_template"
    return
}

template() {
    arg $1 "list" && shift && template_list "$@" && return
    arg $1 "read" && shift && template_read "$@" && return
    arg $1 "note" && shift && template_note "$@" && return
    arg $1 "link" && shift && template_link "$@" && return
    arg $1 "add" && shift && template_add "$@" && return
    arg $1 "edit" && $EDITOR $template_root && return
    arg $1 "--help" "-h" || lt $# 2 && template_help && return
    ! two $# && template_help && return

    local name=$1
    local outpath=$2
    if ! writable "$(dirname $outpath)"; then
        printf "Can't write to $(dirname $outpath), does direcotry exist?\n"; return; fi

    local fpath="$(find $template_root -name $name)"
    if emptyvar "$fpath"; then
        print "$name was not found"
        return
    elif uniquefile $fpath; then
        cp $fpath $outpath && echo "copied"
        return
    else
       printf "$name was matched to too many files\n $fname \n"
       return
    fi
}
template_cdoc() {
    printf "
    ${Green}$ template ${Yellow}<name>${NC} ${Yellow}<path>${NC}${NC}
    ${Green}--------------------------------------------------${NC}
    Copies template ${Yellow}<name>${NC} to ${Yellow}<path>${NC}."
    return
}

template_link() {
    ! two $# && template_link_cdoc && return

    local name=$1
    local outpath=$2
    if ! writable "$(dirname $outpath)"; then
        printf "Can't write to $(dirname $outpath), does direcotry exist?\n"; return; fi

    local fpath="$(find $template_root -name $name)"
    if emptyvar "$fpath"; then
        print "$name was not found"
        return
    elif uniquefile $fpath; then
        ln -sfn $fpath $outpath && echo "linked"
        return
    else
       printf "$name was matched to too many files\n $fname \n"
       return
    fi
}
template_link_cdoc() {
    printf "
    ${Green}$ template link ${Yellow}<name>${NC} ${Yellow}<path>${NC}${NC}
    ${Green}--------------------------------------------------${NC}
    Links the template ${Yellow}<name>${NC} to ${Yellow}<path>${NC}"
    return
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
template_read_cdoc() {
    printf "
    ${Green}$ template read ${Yellow}<name>${NC}${NC}
    ${Green}--------------------------------------------------${NC}
    Read out the template with ${Yellow}<name>${NC}".
    return
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
template_list_cdoc() {
    printf "
    ${Green}$ template list [ ${Yellow}<folder>${NC}${Green} | folders ]${NC}
    ${Green}--------------------------------------------------${NC}
    List all templates, optionally specifying which ${Yellow}<folder>${NC}
    Specifiy ${Green}folders${NC} instead to list all folders in ${UYellow}\$template${NC}."
    return
}

template_note() {
    if ! exists $template_note_preamble; then
        printf "Can't find preamble at $template_note_preamble";  return; fi
    if ! exists $template_note_class_singlepage; then
        printf "Can't find singlepage.cls at $template_note_class_singlepage";  return; fi
    if ! exists $template_note_class_twocol; then
        printf "Can't find twocol.cls at $template_note_class_twocol";  return; fi
        #
    #if ! exists $template_note_bib; then
    #    printf "Can't find bib at $template_note_bib"; return; fi

    if ! one $# || arg $1 "help" "--help" "-h"; then
        template_note_cdoc; return; fi

    local out=$1
    local dir=$(dirname $out)
    if ! writable "$dir"; then
        echo "Can't write to $dir, does directory exist?";  return; fi

    cp "$template_note_template" "$out.tex"
    ln -sfn "$template_note_preamble" "$dir/note_preamble.tex"
    ln -sfn "$template_note_class_singlepage" "$dir/singlepage.cls"
    ln -sfn "$template_note_class_twocol" "$dir/twocol.cls"
    #ln -sfn "$template_note_bib" "$dir/biblio.bib"
    exists "$dir/build" || mkdir "$dir/build"
    exists "$dir/figures" || mkdir "$dir/figures"
    printf "Created note $1"
    return
}
template_note_cdoc() {
    printf "
    ${Green}$ template note ${Yellow}<path>${NC}${NC}
    ${Green}--------------------------------------------------${NC}
    Creates folders, link tex preamble and copies tex template to ${Yellow}<path>${NC}."
    return
}

template_add() {
    echo "hello from add"
    return
}
template_add_cdoc() {
    printf "
    ${Green}$ template add [${Yellow}<folder>${NC}${Green}] ${Yellow}<file>${NC}
    ${Green}--------------------------------------------------${NC}
    Creates a copy of ${Yellow}<file>${NC} and stores it under ${UYellow}\$template_root${NC}.
    Optionally, pass a ${Yellow}<folder>${NC} to store it in, creating one if it does not exists."
    return
}

template_edit() {
    echo "hello from add"
    return
}
template_edit_cdoc() {
    printf "
    ${Green}$ template edit [${Yellow}<name>${NC}${Green}]${NC}
    ${Green}--------------------------------------------------${NC}
    Opens ${UYellow}\$EDITOR${NC} in ${UYellow}\$template_root${NC}."
    return
}
