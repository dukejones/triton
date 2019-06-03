
function triton
    [ -z "$TRITON_PATH" ]; and set -l do_init true

    set -q XDG_CONFIG_HOME
    and set -gx TRITON_PATH "$XDG_CONFIG_HOME/fish/triton"
    or set -gx TRITON_PATH "$HOME/.config/fish/triton"

    test -d $TRITON_PATH; or mkdir -p $TRITON_PATH

    if [ -n "$do_init" -a "$argv[1]" != "init" ]
        triton init
    end

    switch "$argv[1]"
        case ""
            [ -n "$do_init" ]; and return # if first initialization, don't show usage.
            # TODO: all this as completions
            echo "Usage: find some libraries.  Load 'em up"
            echo "triton init"
            echo "triton list"
            echo "triton update"
            echo "triton fishfile <path/to/fishfile>"
            echo "triton bootstrap"
        case "init"
            __triton_load_fishfile $TRITON_PATH/../fishfile
        case "list"
            __triton_list $argv
        case "update"
            __triton_update $argv
        case "fishfile"
            __triton_load_fishfile $argv
        case "bootstrap"
            __triton_bootstrap_template $argv
        case "*"
            __triton_main $argv
    end
end

function __triton_main -a library
    contains $library $__triton_libs
        and return
    
    set lib_path (realpath $TRITON_PATH/github.com/$library 2> /dev/null )
    # TODO: if it includes a domain, use it. [non-github are people too]

    if [ ! -d "$lib_path" ]
        __triton_run_cmd \
            "git clone -q https://github.com/$library $TRITON_PATH/github.com/$library" \
            "Triton: Installing '$library'. 💾"
        if [ -f "$lib_path/.gitmodules" ]
            set -l prev_dir $PWD
            cd $lib_path
            git rev-parse --show-toplevel
            __triton_run_cmd \
                "git submodule update --init" \
                "Installing git submodules."
            cd $prev_dir
        end
        # test -f $lib_path/hooks/install.fish ; and source $lib_path/hooks/install.fish
    end

    if [ -f "$lib_path/fishfile" ]
        __triton_load_fishfile $lib_path/fishfile
    end
    [ -f "$lib_path/before.init.fish" ]; and source $lib_path/before.init.fish
    [ -d "$lib_path/functions" ]
        and not contains "$lib_path/functions" $fish_function_path
        and set fish_function_path $fish_function_path[1] \
                                $lib_path/functions \
                                $fish_function_path[2..-1]
    [ -d "$lib_path/completions" ]
        and not contains "$lib_path/completions" $fish_complete_path
        and set fish_complete_path $fish_complete_path[1] \
                               $lib_path/completions \
                               $fish_complete_path[2..-1]
    if [ (count $lib_path/conf.d/*.fish) -gt 0 ]
        for file in $lib_path/conf.d/*.fish
            source $file
        end
    end
    if [ (count $lib_path/*.fish) -gt 0 ]
        source $lib_path/*.fish

        contains $lib_path $fish_function_path
            or set fish_function_path $fish_function_path[1] \
                                    $lib_path \
                                    $fish_function_path[2..-1]
    end
    contains $library $__triton_libs
        or set -g __triton_libs $__triton_libs $library
end

function __triton_load_fishfile -a fishfile
    [ -f "$fishfile" ] ; or return
    for lib in (cat $fishfile)
        triton $lib
    end
end

function __triton_update
    set -l triton_lib_path $TRITON_PATH/github.com/dukejones/triton
    echo (set_color green)"Updating triton lib in path $triton_lib_path"(set_color normal)
    pushd .
    cd $triton_lib_path
    
    git fetch
    if git status | grep "is up to date" > /dev/null
        echo (set_color green)Your Triton install is already up to date!(set_color normal)
        return
    end

    
    if not git status | grep "working tree clean" > /dev/null
        echo (set_color yellow)"Stashing changes, merging latest, and applying stashed changes."(set_color normal)
        git stash
        git merge origin/master
        git stash apply
    else
        echo (set_color yellow)"Merging the latest code."(set_color normal)
        git merge origin/master
    end
    popd
    echo (set_color green)Done!(set_color normal)
end

function __triton_list
    echo (set_color yellow)Installed Fish Plugins(set_color green) 💾
    for l in $__triton_libs
        echo "    $l"
    end
    echo (set_color yellow)A few places to look for more(set_color blue) 🛒
    echo "    https://github.com/topics/fish-plugin"
    echo "    https://github.com/topics/fish-plugins"
    echo "    https://github.com/oh-my-fish/oh-my-fish/blob/master/docs/Themes.md"
    set_color normal
end

function __triton_run_cmd -a cmd msg -d "Display the message & run the cmd, displaying it in nice colors."
    [ -n "$msg" ]; and echo (set_color yellow)$msg
    echo (set_color blue)"> $cmd"
    eval $cmd
end

function __triton_bootstrap_template
    echo (set_color -r -o green)"Bootstrapping fish config files."(set_color normal)
    triton dukejones/triton # so meta
    set FISH_PATH (realpath "$TRITON_PATH/..")
    for file in {config.fish,fishfile,conf.d/aliases.fish}
        if not test -f $FISH_PATH/$file
            echo (set_color green)"[adding]"(set_color normal) "$FISH_PATH/$file"
            mkdir -p (dirname "$FISH_PATH/$file")
            cp $TRITON_PATH/github.com/dukejones/triton/template/$file $FISH_PATH/$file
        else
            echo (set_color yellow)"[exists]"(set_color normal) "$FISH_PATH/$file"
        end
    end
    exec fish
    echo (set_color -o green)Complete!(set_color normal)
    # source $FISH_PATH/config.fish
end
