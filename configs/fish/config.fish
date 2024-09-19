#!/usr/bin/fish
function __printf_color
  command printf "\033]4;$argv[1];rgb:$argv[2]\007"
end

theme_gruvbox dark hard
# neofetch

zoxide init fish | source

# Generated for envman. Do not edit.
test -s "$HOME/.config/envman/load.fish"; and source "$HOME/.config/envman/load.fish"

