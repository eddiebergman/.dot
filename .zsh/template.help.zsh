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

template_cdoc() {
    printf "
    ${Green}$ template ${Yellow}<name>${NC} ${Yellow}<path>${NC}${NC}
    ${Green}--------------------------------------------------${NC}
    Copies template ${Yellow}<name>${NC} to ${Yellow}<path>${NC}."
    return
}

template_list_cdoc() {
    printf "
    ${Green}$ template list [ ${Yellow}<folder>${NC}${Green} | folders ]${NC}
    ${Green}--------------------------------------------------${NC}
    List all templates, optionally specifying which ${Yellow}<folder>${NC}
    Specifiy ${Green}folders${NC} instead to list all folders in ${UYellow}\$template${NC}."
    return
}

template_read_cdoc() {
    printf "
    ${Green}$ template read ${Yellow}<name>${NC}${NC}
    ${Green}--------------------------------------------------${NC}
    Read out the template with ${Yellow}<name>${NC}".
    return
}

template_edit_cdoc() {
    printf "
    ${Green}$ template edit [${Yellow}<name>${NC}${Green}]${NC}
    ${Green}--------------------------------------------------${NC}
    Opens ${UYellow}\$EDITOR${NC} in ${UYellow}\$template_root${NC}."
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

template_note_cdoc() {
    printf "
    ${Green}$ template note ${Yellow}<path>${NC}${NC}
    ${Green}--------------------------------------------------${NC}
    Creates folders, link tex preamble and copies tex template to ${Yellow}<path>${NC}."
    return
}

template_link_cdoc() {
    printf "
    ${Green}$ template link ${Yellow}<name>${NC} ${Yellow}<path>${NC}${NC}
    ${Green}--------------------------------------------------${NC}
    Links the template ${Yellow}<name>${NC} to ${Yellow}<path>${NC}"
    return
}
