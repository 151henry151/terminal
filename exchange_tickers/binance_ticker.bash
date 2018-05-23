#!/bin/bash
clear
gprice="https://api.binance.com/api/v1/ticker/price?symbol=BTCUSDT"
tput bold
tput civis
red=$(tput setaf 1)
green=$(tput setaf 2)
cyan=$(tput setaf 6)
while true; do
    tput cup 0 0	
    read price < <(curl "$gprice" 2> /dev/null | jshon -e price) 
    cmp=${price//[\".]} 
        if (( prev == cmp ))  
        then printf %s "$cyan"  
        elif (( prev < cmp ))  
        then printf %s "$green"
        else printf %s "$red"; 
        fi 	
    printf "Binance BTCUSDT:\\n"
    printf "\$""${price//\"/}"
    printf "\n"
    prev=$cmp	
done
