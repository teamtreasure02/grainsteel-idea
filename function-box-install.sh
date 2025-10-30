#!/usr/bin/env bash
# function-box-install.sh - installation utilities for grainsteel
# hey! this box contains all the "installing" functions!
# like: add aliases, install grain, setup grainzsh

# source detection functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/function-box-detect.sh"

# ┌────────────────────────────────────────────────────────────────────────┐
# │ ALIAS INSTALLATION - add grain → grainsteel alias                      │
# └────────────────────────────────────────────────────────────────────────┘

install_grain_alias() {
    # add 'grain' alias to shell config
    # returns: 0 if success, 1 if error
    
    local shell_config
    shell_config="$(get_shell_config)"
    
    # check if alias already exists
    if grep -q "alias grain='grainsteel'" "$shell_config" 2>/dev/null; then
        printf '%s\n' '✅ grain alias already installed!'
        return 0
    fi
    
    # add alias
    printf '%s\n' '' >> "$shell_config"
    printf '%s\n' '# grainsteel alias (added by grainsteel-setup)' >> "$shell_config"
    printf '%s\n' "alias grain='grainsteel'" >> "$shell_config"
    
    printf '%s\n' "✅ added 'grain' alias to $shell_config"
    return 0
}

remove_grain_alias() {
    # remove 'grain' alias from shell config
    # returns: 0 if success, 1 if error
    
    local shell_config
    shell_config="$(get_shell_config)"
    
    if [ -f "$shell_config" ]; then
        # remove alias and comment
        sed -i.bak '/# grainsteel alias/d' "$shell_config"
        sed -i.bak "/alias grain='grainsteel'/d" "$shell_config"
        rm -f "$shell_config.bak"
        
        printf '%s\n' "✅ removed 'grain' alias from $shell_config"
        return 0
    fi
    
    return 1
}

# ┌────────────────────────────────────────────────────────────────────────┐
# │ GRAIN INSTALLATION - install grain via cargo                           │
# └────────────────────────────────────────────────────────────────────────┘

install_grain_cargo() {
    # install grain package manager via cargo
    # returns: 0 if success, 1 if error
    
    if ! detect_cargo; then
        printf '%s\n' '⚠️  cargo not found! install rust first:'
        printf '%s\n' '   curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh'
        return 1
    fi
    
    printf '%s\n' '📦 installing grain via cargo...'
    
    if cargo install grain; then
        printf '%s\n' '✅ grain installed successfully!'
        return 0
    else
        printf '%s\n' '⚠️  grain installation failed!'
        return 1
    fi
}

# ┌────────────────────────────────────────────────────────────────────────┐
# │ GRAINZSH INSTALLATION - clone and setup grainzsh                       │
# └────────────────────────────────────────────────────────────────────────┘

install_grainzsh() {
    # clone grainzsh repo and setup
    # returns: 0 if success, 1 if error
    
    local grainzsh_dir="$HOME/github/teamprecision06/grainzsh"
    
    if detect_grainzsh; then
        printf '%s\n' '✅ grainzsh already installed!'
        return 0
    fi
    
    printf '%s\n' '📦 cloning grainzsh...'
    
    # create directory
    mkdir -p "$HOME/github/teamprecision06"
    
    # clone repo
    if git clone https://github.com/teamprecision06/grainzsh.git "$grainzsh_dir"; then
        printf '%s\n' '✅ grainzsh cloned!'
        printf '%s\n' ''
        printf '%s\n' 'next steps:'
        printf '%s\n' "  cd $grainzsh_dir"
        printf '%s\n' '  ./install.sh'
        return 0
    else
        printf '%s\n' '⚠️  grainzsh clone failed!'
        return 1
    fi
}

# ┌────────────────────────────────────────────────────────────────────────┐
# │ ENVIRONMENT VARIABLE - set GRAIN_COMMAND for compatibility             │
# └────────────────────────────────────────────────────────────────────────┘

install_grain_env() {
    # add GRAIN_COMMAND=grainsteel to shell config
    # this helps scripts that check for grain vs grainsteel
    # returns: 0 if success, 1 if error
    
    local shell_config
    shell_config="$(get_shell_config)"
    
    # check if already exists
    if grep -q "export GRAIN_COMMAND=" "$shell_config" 2>/dev/null; then
        printf '%s\n' '✅ GRAIN_COMMAND already set!'
        return 0
    fi
    
    # add env var
    printf '%s\n' '' >> "$shell_config"
    printf '%s\n' '# grain command compatibility (added by grainsteel-setup)' >> "$shell_config"
    printf '%s\n' 'export GRAIN_COMMAND=grainsteel' >> "$shell_config"
    
    printf '%s\n' "✅ added GRAIN_COMMAND to $shell_config"
    return 0
}

# now == next + 1 🌾

