#!/usr/bin/env bash

# YOU CAN CHANGE
TO_HOME_FOLDER=(.zshrc)
TO_XDG_CONFIG_FOLDER=(alacritty autostart dunst icons nvim picom ranger redshift scripts wallpaper zsh)

# DO NOT CHANGE
BACKUP_FOLDER="${HOME}/.local/.dotfiles.backup"
DEFAULT_BACKUP_FOLDER="${BACKUP_FOLDER}/.backup.default"
SCRIPT_FOLDER="$( cd "$(dirname "${0}")" >/dev/null 2>&1 ; pwd -P )"


function anti_root () {
    if [[ ${EUID} -eq 0 ]]; then
        local RED='\033[0;31m'; local BOLD='\033[1m'; local RESET='\033[0m'
        printf "${RED}${BOLD}!! Please do not run this script as root !! ${RESET}\n" 1>&2; exit 1
    fi
}


function install_dotfiles () {
    backup

    for dots_home in "${TO_HOME_FOLDER[@]}"; do
        rm -rf "${HOME}/${dots_home}" &> /dev/null
        cp -rf "${SCRIPT_FOLDER}/${dots_home}" "${HOME}/" &> /dev/null
    done

    mkdir -p "${HOME}/.config"
    for dots_xdg_conf in "${TO_XDG_CONFIG_FOLDER[@]}"; do
        rm -rf "${HOME}/.config/${dots_xdg_conf[*]//./}" &> /dev/null
        cp -rf "${SCRIPT_FOLDER}/.config/${dots_xdg_conf}" "${HOME}/.config/${dots_xdg_conf}" &> /dev/null
    done

    echo -e "Your config is backed up in ${BACKUP_FOLDER}\nPlease do not delete check-backup.txt in your backup folder.\nIt's used to backup and restore your old config." >&2
}


function uninstall_dotfiles () {
    [[ ! -f "${BACKUP_FOLDER}/check-backup.txt" ]] && echo "You have not installed this dotfiles yet." >&2 && exit 1

    for dots_home in "${TO_HOME_FOLDER[@]}"; do
        rm -rf "${HOME}/${dots_home}" &> /dev/null
        cp -rf "${DEFAULT_BACKUP_FOLDER}/${dots_home}" "${HOME}/" &> /dev/null
        rm -rf "${DEFAULT_BACKUP_FOLDER}/${dots_home}" &> /dev/null
    done

    for dots_xdg_conf in "${TO_XDG_CONFIG_FOLDER[@]//./}"; do
        rm -rf "${HOME}/.config/${dots_xdg_conf}" &> /dev/null
        cp -rf "${DEFAULT_BACKUP_FOLDER}/.config/${dots_xdg_conf}" "${HOME}/.config" &> /dev/null
        rm -rf "${DEFAULT_BACKUP_FOLDER}/.config/${dots_xdg_conf}" &> /dev/null
    done

    _update_git_backup
    rm -rf "${BACKUP_FOLDER}/check-backup.txt" &> /dev/null
    rm -rf "${DEFAULT_BACKUP_FOLDER}" &> /dev/null

    echo -e "Your old config has been restored!\nAll your dotfiles are saved in ${BACKUP_FOLDER}" >&2
}


function backup () {
    local has_backup=true
    [[ ! -f "${BACKUP_FOLDER}/check-backup.txt" ]] && has_backup=false

    if [[ "${has_backup}" = false ]]; then 
        mkdir -p "${BACKUP_FOLDER}/.config" &> /dev/null; mkdir -p "${DEFAULT_BACKUP_FOLDER}/.config" &> /dev/null
        cd "${BACKUP_FOLDER}" || exit
        touch check-backup.txt &> /dev/null
    fi

    for dots_home in "${TO_HOME_FOLDER[@]}"; do
        [[ "${has_backup}" = true ]] && rm -rf "${BACKUP_FOLDER}/${dots_home}" &> /dev/null || cp -rf "${HOME}/${dots_home}" "${DEFAULT_BACKUP_FOLDER}" &> /dev/null
        cp -rf "${HOME}/${dots_home}" "${BACKUP_FOLDER}" &> /dev/null
    done

    for dots_xdg_conf in "${TO_XDG_CONFIG_FOLDER[@]//./}"; do
        [[ "${has_backup}" = true ]] && rm -rf "${BACKUP_FOLDER}/${dots_xdg_conf}" &> /dev/null || cp -rf "${HOME}/.config/${dots_xdg_conf}" "${DEFAULT_BACKUP_FOLDER}/.config" &> /dev/null
        cp -rf "${HOME}/.config/${dots_xdg_conf}" "${BACKUP_FOLDER}/.config" &> /dev/null
    done

    [[ "${has_backup}" = false ]] && _create_git_backup || _update_git_backup
}

function _create_git_backup () {
    if [ -x "$(command -v git)" ]; then
        cd "${BACKUP_FOLDER}" || exit
        git init &> /dev/null
        _update_git_backup
    fi
}
function _update_git_backup () {
    if [ -x "$(command -v git)" ]; then
        cd "${BACKUP_FOLDER}" || exit
        git add -u &> /dev/null
        git add . &> /dev/null
        git commit -m "Update config on $(date '+%Y-%m-%d %H:%M')" &> /dev/null
    fi
}


function usage () {
    local program_name
    program_name=${0##*/}
    cat <<EOF
Usage: $program_name [-option]
Options:
    --help    Print this message
    -i        Install this dotfiles
    -r        Restore your old config
EOF
}


function main () {

    anti_root

    case "${1}" in
        ''|-h|--help)
            usage; exit 0
            ;;
        -i)
            install_dotfiles
            ;;
        -r)
            uninstall_dotfiles
            ;;
        *)
            echo "Invalids arguments (${@})"; usage; exit 1
    esac
}


main "${@}"