#!/usr/bin/env bash
# function-box-detect.sh - detection utilities for grainsteel setup
# hey! this box contains all the "checking" functions!
# like: is steel installed? is grain command taken? which shell are we in?

# ┌────────────────────────────────────────────────────────────────────────┐
# │ STEEL DETECTION - is steel installed?                                  │
# └────────────────────────────────────────────────────────────────────────┘

detect_steel() {
    # check if steel is installed
    # returns: 0 if found, 1 if not found
    
    if command -v steel >/dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

get_steel_version() {
    # get steel version if installed
    # prints: version string or "not found"
    
    if detect_steel; then
        steel --version 2>/dev/null || printf 'unknown'
    else
        printf 'not found'
    fi
}

# ┌────────────────────────────────────────────────────────────────────────┐
# │ GRAIN COMMAND DETECTION - is 'grain' already taken?                    │
# └────────────────────────────────────────────────────────────────────────┘

detect_grain_command() {
    # check if 'grain' command exists
    # returns: 0 if exists, 1 if not
    
    if command -v grain >/dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

get_grain_location() {
    # find where 'grain' command is
    # prints: path or "not found"
    
    if detect_grain_command; then
        which grain
    else
        printf 'not found'
    fi
}

# ┌────────────────────────────────────────────────────────────────────────┐
# │ GRAINZSH DETECTION - is grainzsh installed?                            │
# └────────────────────────────────────────────────────────────────────────┘

detect_grainzsh() {
    # check if grainzsh is installed
    # returns: 0 if found, 1 if not
    
    if [ -d "$HOME/.config/grainzsh" ] || [ -d "$HOME/github/teamprecision06/grainzsh" ]; then
        return 0
    else
        return 1
    fi
}

# ┌────────────────────────────────────────────────────────────────────────┐
# │ SHELL DETECTION - what shell is the user using?                        │
# └────────────────────────────────────────────────────────────────────────┘

detect_shell() {
    # detect current shell
    # prints: zsh, bash, fish, or unknown
    
    if [ -n "$ZSH_VERSION" ]; then
        printf 'zsh'
    elif [ -n "$BASH_VERSION" ]; then
        printf 'bash'
    elif [ -n "$FISH_VERSION" ]; then
        printf 'fish'
    else
        printf 'unknown'
    fi
}

get_shell_config() {
    # get shell config file path
    # prints: path to .zshrc, .bashrc, etc
    
    case "$(detect_shell)" in
        zsh)
            printf '%s' "$HOME/.zshrc"
            ;;
        bash)
            printf '%s' "$HOME/.bashrc"
            ;;
        fish)
            printf '%s' "$HOME/.config/fish/config.fish"
            ;;
        *)
            printf '%s' "$HOME/.profile"
            ;;
    esac
}

# ┌────────────────────────────────────────────────────────────────────────┐
# │ PACKAGE MANAGER DETECTION - which package managers have 'grain'?       │
# └────────────────────────────────────────────────────────────────────────┘

detect_package_managers() {
    # check all package managers for 'grain' package
    # prints: list of package managers that have it
    
    local found=""
    
    # homebrew
    if command -v brew >/dev/null 2>&1; then
        if brew list 2>/dev/null | grep -q '^grain$'; then
            found="${found}brew "
        fi
    fi
    
    # apt
    if command -v apt >/dev/null 2>&1; then
        if apt list --installed 2>/dev/null | grep -q '^grain/'; then
            found="${found}apt "
        fi
    fi
    
    # nix
    if command -v nix-env >/dev/null 2>&1; then
        if nix-env -q 2>/dev/null | grep -q '^grain-'; then
            found="${found}nix "
        fi
    fi
    
    # apk
    if command -v apk >/dev/null 2>&1; then
        if apk info 2>/dev/null | grep -q '^grain$'; then
            found="${found}apk "
        fi
    fi
    
    # pacman
    if command -v pacman >/dev/null 2>&1; then
        if pacman -Q grain 2>/dev/null >/dev/null; then
            found="${found}pacman "
        fi
    fi
    
    printf '%s' "$found"
}

# ┌────────────────────────────────────────────────────────────────────────┐
# │ CARGO DETECTION - is cargo/rust installed?                             │
# └────────────────────────────────────────────────────────────────────────┘

detect_cargo() {
    # check if cargo is installed
    # returns: 0 if found, 1 if not
    
    if command -v cargo >/dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

detect_grain_cargo() {
    # check if grain is installed via cargo
    # returns: 0 if found, 1 if not
    
    if detect_cargo; then
        if cargo install --list 2>/dev/null | grep -q '^grain v'; then
            return 0
        fi
    fi
    return 1
}

# now == next + 1 🌾

