#!/bin/bash
# Coinmarketcap ticker modified from example code written by Cole Tierney found at https://stackoverflow.com/a/47250418

clear
btcglobalprice="https://api.coinmarketcap.com/v2/ticker/1/"
tput bold
tput civis
red=$(tput setaf 1)
green=$(tput setaf 2)
cyan=$(tput setaf 6)

getdata_fromcoinmarket() {
    { test -r "$btcglobalprice" && cat "$btcglobalprice" || curl -s "$btcglobalprice"; } | \
      jq -r '.data.quotes.USD.price'
}

while true; do
    tput cup 0 0
    read -r price <<< $(getdata_fromcoinmarket "$btcglobalprice")
    comparison_value=${price}
    if (( $(echo "previous_value == comparison_value" | bc -l) )); then 
    printf %s "$cyan"
    elif (( $(echo "previous_value < comparison_value" | bc -l) )); then 
    printf %s "$green"
    else printf %s "$red";
    fi
    printf "   Global Average BTCUSD:   \$$price"
sleep 2
previous_value=$comparison_value
done


