
function help() {
    echo "Usage:"
    echo "Tool:"
    echo "      f       lf          -- find."
    echo "      g       lg          -- grep."
    echo "      viml    lviml       -- edit tools"
    echo "      re      lre         -- reinit tools"
    echo "      vim     lvim        -- vim file:num"

    echo "Code:"
    echo "      work    lwork       -- cd path"

    echo "      m       lm|m        -- do make"
    echo "      gotags  gotags      -- make go tags"
    echo "      ctags   ctags       -- make c tags"

    echo "      sy      lsy         -- addr2line"
}

function init() {
    #default
    alias ll="ls -al"
    alias lls="ls"
    alias sl="ls"
    alias sls="ls"
    alias mvim="/usr/local/Cellar/macvim/8.1-157/bin/mvim"

    alias l=". l"

    alias lf="l f"
    alias lg="l g"
    alias lviml="l viml"
    alias lwork="l work"
    alias lre="l re"

    alias ldo="l do"
    alias lo="l o"

    alias lvimn="l vimn"
    alias lm="l m"
    alias lvim="l vim"
    alias lgotags="l gotags"
    alias lctags="l ctags"
    alias ltmux="l tmux"

    #short
    alias m="lm"
    alias n="l n"

    export C_INCLUDE_PATH=/opt/local/include/:$C_INCLUDE_PATH
    export CPLUS_INCLUDE_PATH=/opt/local/include/:$CPLUS_INCLUDE_PATH
	export https_proxy=http://192.168.0.23:3457 http_proxy=http://192.168.0.23:3457 all_proxy=socks5://192.168.0.23:3457

	export GOPATH=$HOME/work/go

    export EDITOR='vim'
    export AUTOSSH_PORT=0
    export DOCKER_HOST=tcp://127.0.0.1:4243
    PATH="/usr/local/sbin:$PATH:$HOME/work/bin:$HOME/work/go/bin"
}

#begin

if [ $# = 1 ] ; then
	if [ $1 = "zle_bracketed_paste" ] ; then
		help
		return
	fi
fi

if [ $1 = "re" ] ; then
    init
    return
fi

#args

args=""

for var in $@; do
    args="$args $var"
done
echo $args

#mycommadn

if [ $1 = "f" ] ; then
    find . -name "*$2*"
    return
fi

if [ $1 = "g" ] ; then 
    grep $2 -rn * | grep -v '^tags' | grep -v test |grep $2
    return
fi

if [ $1 = "viml" ] ; then 
    vim ~/work/bin/l
    return
fi

if [ $1 = "work" ] ; then 

       case "$2" in
            h)
                cd '/Users/lifeibo/work/src'
            ;;
            c)
                cd ~/work/src
            ;;
            *)
            echo -e "usage: lwork "
        esac


    pwd
    return
fi

if [ $1 = "tmux" ] ; then 
	tmux attach
    return
fi

if [ $1 = "do" ] ; then 
    curl localhost:8088/ -i
    return
fi


if [ $1 = "m" ] ; then 
    pwd
    make
    return
fi

if [ $1 = "vim" ] ; then 
    if [ $2 ] ; then 
        line=`echo $2 | awk -F ':' '{print $2}'`
        file=`echo $2 | awk -F ':' '{print $1}'`
        echo $line
    vim $file +$line
    else
        vim
    fi
    return
fi

if [ $1 = "o" ] ; then 

    while true; do
    bash -c "$2"
    sleep 1;
    done
    return
fi

if [ $1 = "gotags" ] ; then 
    find `pwd`  -name "*.go" | grep -v 'auto/libs' | grep -v 'work/src/heka/heka-0.6.0/build' | xargs gotags > tags
    return
fi

if [ $1 = "ctags" ] ; then 
    find `pwd`  \( -name '*.[c|h]' -or -name '*.cc' -or -name '*.cpp' -or -name '*.rs' \) | xargs ctags
    return
fi

#end
echo "Command '$1' not found."
