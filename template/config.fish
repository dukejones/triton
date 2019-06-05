### INIT ###
triton init
# fish_vi_key_bindings

### THEMES ###

triton oh-my-fish/theme-bobthefish
set -g theme_powerline_fonts no # Go ahead and turn this on when you get a powerline font!
set -g theme_nerd_fonts no # And nerd fonts for the ultimate in nerdy goodness.

# Powerline Themes #
# triton oh-my-fish/theme-agnoster
# triton oh-my-fish/theme-es
# triton jorgebucaran/fish-sol
# triton jorgebucaran/fish-sektor

### PACKAGES ###
triton joehillen/to-fish # Fish shell directory bookmarks

triton oh-my-fish/plugin-node-binpath
triton kennethreitz/fish-pipenv
set -gx VIRTUAL_ENV_DISABLE_PROMPT yes


### CUSTOMIZATION ###
# function fish_greeting
# 	figlet -w 250 Fortune Favors the Bold
# end

### ENVIRONMENT ###
set -g EDITOR vim
