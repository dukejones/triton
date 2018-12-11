# Install #
Installation Script:

`curl -L https://git.io/fp7xA | fish`

Manual Installation:

`curl -L "https://git.io/triton!" > ~/.config/fish/functions/

`triton bootstrap`

## Usage ##
`triton init` : Initialize by loading/installing all of the libraries listed in your fishfile.

`triton bootstrap` : Copy the included configuration file templates into the config directory.

`triton [repo/lib]` : Load/install the library. i.e. dukejones/triton is at https://github.com/dukejones/triton

`triton fishfile [file]` : Load/install all of the libraries in the given fishfile.

## What Does It Do? ##

You give triton just about any repo that is meant to be a fish plugin, and it will try to install it, or just load it if it's already installed.

You get a nice list of all of your libraries in your config.fish and fishfile, not a confusing array of symlinks and nested calls in various directories.  Everything is in `~/.config/fish/`.

## Where did this come from? ##

One day I had to find some setting in some Fish plugin that was causing a problem, but when I looked at my Fish config and I was dissatisfied and discouraged.  I couldn't find where the library lived.  Was it symlinked from fisherman?  Was it in one of oh-my-fish's special directories?  How was it even being loaded?!  Not in functions, or conf.d.... I had to read through the source code of the package managers to figure out what the heck was going on.  It was almost enough to send me back to Zsh, again.

But then I remembered that Fish has an actual scripting language that makes sense, unlike some shells (bash).  So I set about copying the best-in-breed: discoverable, explicit (if you're mucking about with Fish you probably understand editing text files like config.fish), and yet magical enough to bring surprise and delight.  And thus Triton was born.

Inspirations include: antigen.zsh, Vim+Pathogen.

# Triton #
![Triton](https://greekgodsandgoddesses.net/wp-content/uploads/2017/02/triton-1024x885.jpg "Triton")
