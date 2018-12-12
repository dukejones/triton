
function triton
    set -q XDG_CONFIG_HOME
    and set -gx TRITON_PATH "$XDG_CONFIG_HOME/fish/triton"
    or set -gx TRITON_PATH "$HOME/.config/fish/triton"

    test -d $TRITON_PATH; or mkdir -p $TRITON_PATH

    switch "$argv[1]"
        case ""
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
    
    set lib_path (realpath $TRITON_PATH/github.com/$library)
    
    # TODO: if it includes a domain, use it. [non-github are people too]

    if test ! -d "$lib_path"
        echo (set_color yellow)"Library '$library' is not installed.  Installing..."
        set -l cmd "git clone -q https://github.com/$library $TRITON_PATH/github.com/$library"
        echo (set_color blue)"> $cmd"
        eval $cmd
        test -f $lib_path/hooks/install.fish ; and source $lib_path/hooks/install.fish
    end

    if test -f $lib_path/fishfile
        __triton_load_fishfile $lib_path/fishfile
    end

    test -f $lib_path/before.init.fish; and source $lib_path/before.init.fish

    test -d "$lib_path/functions"
        and not contains "$lib_path/functions" $fish_function_path
        and set fish_function_path $fish_function_path[1] \
                                $lib_path/functions \
                                $fish_function_path[2..-1]

    test -d "$lib_path/completions"
        and not contains "$lib_path/completions" $fish_complete_path
        and set fish_complete_path $fish_complete_path[1] \
                               $lib_path/completions \
                               $fish_complete_path[2..-1]


    test (count $lib_path/conf.d/*.fish) -gt 0
        and source $lib_path/conf.d/*.fish

    if test (count $lib_path/*.fish) -gt 0
        source $lib_path/*.fish

        contains $lib_path $fish_function_path
            or set fish_function_path $fish_function_path[1] \
                                    $lib_path \
                                    $fish_function_path[2..-1]
    end
    # test -f $lib_path/init.fish; and source $lib_path/init.fish

    contains $library $__triton_libs
        or set -g __triton_libs $__triton_libs $library
end

function __triton_load_fishfile -a fishfile
    test -f $fishfile ; or return
    for lib in (cat $fishfile)
        triton $lib
    end
end

function __triton_update
    echo Updating everything... not yet implemented.
end

function __triton_list
    echo (set_color yellow)💾 Installed Fish Plugins(set_color green)
    for l in $__triton_libs
        echo $l
    end
    echo (set_color yellow)🛒 A few places to look for more(set_color blue)
    echo https://github.com/topics/fish-plugin
    echo https://github.com/topics/fish-plugins
    echo https://github.com/oh-my-fish/oh-my-fish/blob/master/docs/Themes.md
end

function __triton_bootstrap_template
    echo "Bootstrapping fish config files..."
    triton dukejones/triton
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
    echo (set_color green)Complete.(set_color normal)
    source $FISH_PATH/config.fish
end
