#!/usr/bin/env bash
printf "\n \nEnter the TXID: "
read txid
until curl -sf "https://blockexplorer.com/api/tx/$txid" >/dev/null 
do sleep 3; printf "\nThe transaction is not yet found!\n"
done 
printf "\n\n\nWe see transaction $txid"
read confirmations < <(curl -s "https://blockexplorer.com/api/tx/$txid" 2> /dev/null | jshon -e confirmations)
waiting_for=0
until (( confirmations > 0 )) 
do
waiting_for=$((waiting_for+1))
sleep 3;
printf "\n\nWaiting for $waiting_for ... It looks like the transaction has $confirmations confirmations.\n"
done
dialog --title "TX CONFIRMED" \
       --begin 3 10 --msgbox "Confirmed." 5 30
