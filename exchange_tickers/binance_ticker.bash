#!/bin/bash
clear
gprice="https://api.binance.com/api/v1/ticker/price?symbol=BTCUSDT"
gethprice="https://api.binance.com/api/v1/ticker/price?symbol=DASHETH"
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
	read last < <(curl "$gethprice" 2> /dev/null | jshon -e price)
	cmp2=${price//[\".]}
	if (( prev2 == cmp2 ))
	then printf %s "$cyan"
	elif (( prev2 < cmp2 ))
	then printf %s "$green"
	else printf %s "$red";
	fi
	printf "Binance DASHETH:\\n"
	printf "Ξ""${price//\"/}"	
	printf "\n"

	sleep 3  	
	prev2=$cmp2
    prev=$cmp	
done
