# You can do from your ~/.bash_profile:
# source terraform-util.sh

# Bash colors that work in regex (they don't seem to work with echo)
# https://gist.github.com/JBlond/2fea43a3049b38287e5e9cefc87b2124
reset=$(printf '\33\\[0m')
black=$(printf '\33\\[30m')
white=$(printf '\33\\[1m')
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
    if [[ "$1" = "changes" ]]; then
        # --- show only changes in plan (colored with fg color) ---
        # remove color reset
        # put color reset at the end
        # grep colored lines
        # flag -u is used to see the output as it is written, otherwise it's buffered
        sed -u \
          -e "s/$reset//g" \
          -e "s/$/$reset/" \
        | grep -e $green -e $red -e $yellow
    elif [[ "$1" = "short" ]]; then
        # --- show only changes in plan (colored with fg color), and all lines outside of plan ---
        # remove color reset
        # add dummy $green outside of plan (to later include those lines with grep)
        # put color reset at the end
        # grep colored lines of plan (and also lines outside of plan, thanks to the dummy $green)
        sed -u \
          -e "s/$reset//g" \
          -e "1,/^Terraform will/ s/$/$green/" \
          -e "/^${white}Plan: /,$ s/$/$green/" \
          -e "s/$/$reset/" \
        | grep -e $green -e $red -e $yellow
    elif [[ "$1" = "" ]]; then
        # --- color changes in plan with bg color ---
        # remove reset
        # put reset at the end
        # replace fg color with bg color in update lines, that start with [+-~]
        sed -E -u \
          -e "/^ +($yellow~|$green+|$red-)/s/$reset//g" \
          -e "/^ +($yellow~|$green+|$red-)/s/$/$reset/" \
          -e "/^ +$green+/s/$green/$greenbg$black/g" \
          -e "/^ +$red-/s/$red/$redbg$black/g" \
          -e "/^ +$yellow~/s/$yellow/$yellowbg$black/g"
    else
      print "${red}Wrong option:${reset} $1\n" 1>&2
    fi
}

