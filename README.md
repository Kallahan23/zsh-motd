# Zsh Message of the Day

This plugin prints a message every time you open your terminal.

## Prerequisites

It's ok if you don't have a certain package installed. You just won't get the pretty output.

- Cowsay
- Fortune
- Figlet
- Lolcat

## Options

- Default is a fortune or a standard greeting if fortune is not installed
- Add `export ZSH_MOTD_CUSTOM=<A static message>` to your .zshrc to set the message to a static message
- Add `export ZSH_MOTD_WOTD` to your .zshrc to set the message to a random word
- Add `export ZSH_MOTD_ALWAYS` to your .zshrc so that the full header is shown every time, instead of the default every 3 hours
- Add `export ZSH_MOTD_DATABASE` to your .zshrc to specify the fortune database from which messages are picked
- Add `export ZSH_MOTD_COW` to your .zshrc to specify the animal display, default to stegosaurus. `cowsay -l` to list them.

## Installation

### Oh My Zsh

- Clone the repository:

```zsh
git clone https://github.com/Kallahan23/zsh-motd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-motd
```

- Enable this plugin by adding `zsh-motd` to the plugins array in your zshrc file:

```zsh
plugins=(... zsh-motd)
```
