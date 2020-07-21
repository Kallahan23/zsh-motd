# Bash / Ubuntu MOTD for Zsh, but cooler

trap 'rm -f "$temp_file"' EXIT

# Make sure perl is installed. It usually is, but just in case
PERL_INSTALLED=0
if hash perl; then
    PERL_INSTALLED=1
fi

rainbow_dino() {
    ( hash cowsay 2>/dev/null && cowsay -n -f stegosaurus || cat ) |
    ( hash lolcat 2>/dev/null && lolcat || cat )
}

fortune_text() {
    ( hash fortune 2>/dev/null && fortune || printf "Hey $USER" )
}

message() {
    # Custom message
    if [ ! -z ${ZSH_MOTD_CUSTOM+x} ]; then
        echo $ZSH_MOTD_CUSTOM |
        ( hash figlet 2>/dev/null && figlet || cat ) |
        rainbow_dino

    # Word of the day
    elif [ ! -z ${ZSH_MOTD_WOTD+x} ] && [ $PERL_INSTALLED -eq 1 ]; then
        perl -e 'open IN, "</usr/share/dict/words";rand($.) < 1 && ($n=$_) while <IN>;print $n' |
        ( hash figlet 2>/dev/null && figlet || cat ) |
        rainbow_dino

    # Default
    else
        fortune_text | rainbow_dino
    fi
}

if [ -f /etc/profile.d/update-motd.sh ]; then
    temp_file=$(mktemp)
    ./update-motd.sh > $temp_file
    
    # Linux MOTD
    if [ -s "$temp_file" ]; then
        cat $temp_file | rainbow_dino
    else
        message
    fi
else
    message
fi
