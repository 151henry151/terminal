#!/usr/bin/env bash
printf "\n \nThis utility will let you know when a transaction has been seen by blockexplorer.com \n \n Enter the TXID: "
read txid
until curl -sf "https://blockexplorer.com/api/tx/$txid" >/dev/null 
do sleep 3; printf "\nNot yet done!\n"
done 
printf "\n\n\nDone! We see transaction $txid"
read confirmations < <(curl -s "https://blockexplorer.com/api/tx/$txid" 2> /dev/null | jshon -e confirmations)
printf "\n\nIt looks like the transaction has $confirmations confirmations.\n"

