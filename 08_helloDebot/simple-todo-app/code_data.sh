#!/bin/bash
set -e

if [[ $1 != *".tvc"  ]] ; then 
    echo "ERROR: contract file name .tvc required!"
    echo ""
    echo "USAGE:"
    echo "  ${0} FILENAME NETWORK"
    echo "    where:"
    echo "      FILENAME - required, debot tvc file name"
    echo "      NETWORK  - optional, network endpoint, default is http://127.0.0.1"
    echo ""
    echo "PRIMER:"
    echo "  ${0} mydebot.tvc https://net.ton.dev"
    exit 1
fi
echo "1"
DEBOT_NAME=${1%.*} # filename without extension
NETWORK="${2:-http://127.0.0.1}"
GIVER_ADDRESS=0:b5e9240fc2d2f1ff8cbb1d1dee7fb7cae155e5f6320e585fcc685698994a19a5
echo "2"

tos=./tonos-cli
if $tos --version > /dev/null 2>&1; then
    echo "OK $tos installed locally."
else 
    tos=tonos-cli
    if $tos --version > /dev/null 2>&1; then
        echo "OK $tos installed globally."
    else 
        echo "$tos not found globally or in the current directory. Please install it and rerun script."
    fi
fi
#cat $DEBOT_NAME.decode.json
#grep 'data' $DEBOT_NAME.decode.json --text
#iconv -t UTF-8 $DEBOT_NAME.decode.txt > $DEBOT_NAME.decodeNEW.txt
#TEXTGO=$(grep -a '' $DEBOT_NAME.decode.json)
#echo $TEXTGO
#echo $(cat $DEBOT_NAME.decode.json) #| grep 'data' )
echo "3"
#grep '' $DEBOT_NAME.decode.txt
#strings $DEBOT_NAME.decode.txt | grep 'data' 
#| cut -d ' ' -f 3)

$tos decode stateinit todo.tvc --tvc > $DEBOT_NAME.decodetxt.json
tail -12 $DEBOT_NAME.decodetxt.json > $DEBOT_NAME.decode.json


#echo $(wc -l $DEBOT_NAME.decode.json)
#n=10
#tail +$((n + 1))

echo "4"


