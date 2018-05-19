#!/bin/bash
clear
gprice="https://api.gemini.com/v1/pubticker/btcusd"
gethprice="https://api.gemini.com/v1/pubticker/ethusd"
gethbtcprice="https://api.gemini.com/v1/pubticker/ethbtc"
tput bold
tput civis
red=$(tput setaf 1)
green=$(tput setaf 2)
cyan=$(tput setaf 6)
while true; do

	tput cup 0 0	
	read last < <(curl "$gprice" 2> /dev/null | jshon -e last) 
	cmp=${last//[\".]} 
	if (( prev == cmp ))  
	then printf %s "$cyan"  
	elif (( prev < cmp ))  
	then printf %s "$green"
	else printf %s "$red"; 
	fi 	
	printf "Gemini BTCUSD:\\n"
	printf "\$""${last//\"/}"
	printf "\n"
	read last < <(curl "$gethprice" 2> /dev/null | jshon -e last)
	cmp2=${last//[\".]}
	if (( prev2 == cmp2 ))
	then printf %s "$cyan"
	elif (( prev2 < cmp2 ))
	then printf %s "$green"
	else printf %s "$red";
	fi
	printf "Gemini ETHUSD:\\n"
	printf "\$""${last//\"/}"	
	printf "\n"
	read last < <(curl "$gethbtcprice" 2> /dev/null | jshon -e last)
	cmp3=${last//[\".]}
	if (( prev3 == cmp3 ))
	then printf %s "$cyan"
	elif (( prev3 < cmp3 ))
	then printf %s "$green"
	else printf %s "$red";
	fi
	printf "Gemini ETHBTC:\\n"
	printf "\฿""${last//\"/}"	


	sleep 3  	
	prev2=$cmp2
    prev=$cmp	
	prev3=$cmp3
done
