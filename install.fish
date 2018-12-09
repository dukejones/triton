

set -q XDG_CONFIG_HOME
    and set FISH_PATH "$XDG_CONFIG_HOME/fish"
    or set FISH_PATH "$HOME/.config/fish"

git clone https://github.com/dukejones/triton.git $FISH_PATH/triton/github.com/dukejones/
mkdir -p $FISH_PATH/functions
ln -s $FISH_PATH/triton/github.com/dukejones/triton/functions/triton.fish $FISH_PATH/functions/

echo "Welcome to Triton!  You may with to run:
echo "triton bootstrap"
echo "To bootstrap a new level of fish configuration bliss.
