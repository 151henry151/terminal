#!/bin/bash
# Coinmarketcap ticker modified from example code written by Cole Tierney found at https://stackoverflow.com/a/47250418

clear
btcglobalprice="https://api.coinmarketcap.com/v1/ticker/bitcoin/"
tput bold
tput civis
red=$(tput setaf 1)
green=$(tput setaf 2)
cyan=$(tput setaf 6)

getdata_fromcoinmarket() {
    { test -r "$btcglobalprice" && cat "$btcglobalprice" || curl -s "$btcglobalprice"; } | \
      jq --raw-output \
          '.[] | "\(.price_usd)"'
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
    printf "   Global\n   Average:\n   \$$price"
sleep 240
previous_value=$comparison_value
done


