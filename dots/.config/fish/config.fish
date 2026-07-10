function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

if status is-interactive # Commands to run in interactive sessions can go here

    # No greeting
    set fish_greeting

    if status is-interactive
        if not set -q SSH_AUTH_SOCK; or not test -S "$SSH_AUTH_SOCK"; or not kill -0 $SSH_AGENT_PID 2>/dev/null
            set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
        end
    end

    # Use starship
    starship init fish | source
    if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    end

    # Aliases
    alias pamcan pacman
    alias ls 'eza --icons'
    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    alias q 'qs -c ii'

end

# function fish_preexec --on-event fish_preexec
#     if string match -q "nvim*" $argv
#         kitty @ set-spacing margin=0 2>/dev/null
#     end
# end
#
# function fish_postexec --on-event fish_postexec
#     if string match -q "nvim*" $argv
#         kitty @ set-spacing margin=21.75 2>/dev/null
#     end
# end
