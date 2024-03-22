# Bash / Ubuntu MOTD for Zsh, but cooler
# This script is partly based on the default /etc/profile.d/update-motd.sh found in Ubuntu 20.04.

stamp="$HOME/.motd_shown"

# Make sure perl is installed. It usually is, but just in case
PERL_INSTALLED=0
if hash perl; then
    PERL_INSTALLED=1
fi

random_word() {
    perl -e 'open IN, "</usr/share/dict/words";rand($.) < 1 && ($n=$_) while <IN>;print $n'
}

random_cow() {
    local cow_list=("beavis.zen" "blowfish" "bud-frogs" "bunny" "cheese" "cower" "daemon" "default" "dragon" "dragon-and-cow" "elephant" "elephant-in-snake" "eyes" "flaming-sheep" "ghostbusters" "hellokitty" "kiss" "kitty" "koala" "kosh" "luke-koala" "mech-and-cow" "meow" "milk" "moofasa" "moose" "mutilated" "ren" "satanic" "sheep" "skeleton" "small" "stegosaurus" "stimpy" "supermilker" "surgery" "three-eyes" "turkey" "turtle" "tux" "udder" "vader" "vader-koala" "www")
    local the_random_cow=${cow_list[$RANDOM % ${#cow_list[@]}]}
    echo $the_random_cow
}

rainbow_dino() {
    ( hash cowsay 2>/dev/null && cowsay -n -f ${ZSH_MOTD_COW-stegosaurus} || cat ) |
    ( hash lolcat 2>/dev/null && lolcat || cat )
}

fortune_text() {
    ( hash fortune 2>/dev/null && fortune "$ZSH_MOTD_DATABASE" || printf "Hey $USER\n" )
}

print_header() {
    # Custom message
    if [[ -v ZSH_MOTD_RANDOM_COW ]]; then
        ZSH_MOTD_COW=$(random_cow)
    fi

    if [ ! -z ${ZSH_MOTD_CUSTOM+x} ]; then
        echo $ZSH_MOTD_CUSTOM |
        ( hash figlet 2>/dev/null && figlet || cat ) |
        rainbow_dino

    # Word of the day
    elif [ ! -z ${ZSH_MOTD_WOTD+x} ] && [ $PERL_INSTALLED -eq 1 ]; then
        random_word |
        ( hash figlet 2>/dev/null && figlet || cat ) |
        rainbow_dino

    # Default
    else
        fortune_text | rainbow_dino
    fi
}

# Linux MOTD - once a day
if [ -d /etc/update-motd.d ] && [ ! -e "$HOME/.hushlogin" ] && [ -z "$MOTD_SHOWN" ] && ! find $stamp -newermt 'today 0:00' 2> /dev/null | grep -q -m 1 '.'; then
    [ $(id -u) -eq 0 ] || SHOW="--show-only"
    update-motd $SHOW | rainbow_dino
    touch $stamp
    export MOTD_SHOWN=update-motd
# ZSH MOTD - once every 3 hours
elif [ ! -z ${ZSH_MOTD_ALWAYS+x} ] || ! find $stamp -mmin -179 2> /dev/null | grep -q -m 1 '.'; then
    print_header
    touch $stamp
elif [ -z "${ZSH_MOTD_NO_WORD_OF_THE_DAY}" ]; then
    echo
    random_word | ( hash lolcat 2>/dev/null && lolcat || cat )
fi
