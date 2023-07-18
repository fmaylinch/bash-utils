# You can do from your ~/.bash_profile:
# source terraform-util.sh

# Bash colors that work in regex (they don't seem to work with echo)
# https://gist.github.com/JBlond/2fea43a3049b38287e5e9cefc87b2124
reset=$(printf '\33\\[0m')
black=$(printf '\33\\[30m')
grey=$(printf '\33\\[90m')
red=$(printf '\33\\[31m')
green=$(printf '\33\\[32m')
yellow=$(printf '\33\\[33m')
redbg=$(printf '\33\\[41m')
greenbg=$(printf '\33\\[42m')
yellowbg=$(printf '\33\\[43m')

# You can run this function e.g. like this: terraform apply | tfcolor
# If you want experiment and declare the function from shell itself, remove comments first.
tfcolor() {
    if [[ "$1" = "short" ]]; then
        # remove color reset, put color reset at the end
        # filter colored lines
        # flag -u is used to see the output as it is written, otherwise it's buffered
        sed -u "s/$reset//g" \
        | sed -u "s/$/$reset/" \
        | grep -e $green -e $red -e $yellow
    else
        # remove color reset, put color reset at the end
        # replace fg color with bg color
        # remove remaining fg colors (to see $black over bg colors)
        # TODO: join regex for fg colors (to remove them all except $black)
        sed -u "s/$reset//g" \
        | sed -u "s/$/$reset/" \
        | sed -u "s/$green/$greenbg$black/" \
        | sed -u "s/$red/$redbg$black/" \
        | sed -u "s/$yellow/$yellowbg$black/" \
        | sed -u "s/$green//g" \
        | sed -u "s/$red//g" \
        | sed -u "s/$yellow//g" \
        | sed -u "s/$grey//g"
    fi
}

