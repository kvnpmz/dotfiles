#!/bin/sh

choice=$(zenity --list \
  --title="e1s-language-picker" \
  --text="Copy phrase:" \
  --column="Language" \
  "English" \
  "Castellano" \
  "Português" \
  "Català" \
  "Français" \
  "Italiano" \
  "Latin" \
  "Ἑλληνικά" \
  "עברית")

case "$choice" in
    English)
        phrase="in one sentence"
        ;;
    Castellano)
        phrase="en una oración"
        ;;
    Português)
        phrase="em uma frase"
        ;;
    Català)
        phrase="en una oració"
        ;;
    Français)
        phrase="en une phrase"
        ;;
    Italiano)
        phrase="in una frase"
        ;;
    Latin)
        phrase="in una sententia"
        ;;
    Ἑλληνικά)
        phrase="σε μία πρόταση"
        ;;
    עברית)
        phrase="במשפט אחד"
        ;;
    *)
        exit 0
        ;;
esac

printf '%s' "$phrase" | wl-copy
