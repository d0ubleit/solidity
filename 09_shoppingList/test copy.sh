tondev sol compile DeBotSL_Manager.sol

tonos-cli genaddr DeBotSL_Manager.tvc DeBotSL_Manager.abi.json --genkey DeBotSL_Manager.keys.json > log.log
create params.json with addr from log.log
params.json
0:18c3f7ff4c976731cf13affd6501f895b3d1c6333364c064cbd9976692b642df
tonos-cli --url http://127.0.0.1 call --abi ../debotBase/Local_giver.abi.json 0:841288ed3b55d9cdafa806807f02a0ae0c169aa5edfe88a789a6482429756a94 sendGrams params.json
tonos-cli --url http://127.0.0.1 deploy DeBotSL_Manager.tvc "{}" --sign DeBotSL_Manager.keys.json --abi DeBotSL_Manager.abi.json


./test.sh
//tonos-cli --url http://127.0.0.1 call <address> setABI dabi.json --sign HelloDebot.keys.json --abi HelloDebot.abi.json

tonos-cli --url http://127.0.0.1 call 0:18c3f7ff4c976731cf13affd6501f895b3d1c6333364c064cbd9976692b642df  setABI dabi.json --sign DeBotSL_Manager.keys.json --abi DeBotSL_Manager.abi.json

tonos-cli --url http://127.0.0.1 run --abi DeBotSL_Manager.abi.json 0:18c3f7ff4c976731cf13affd6501f895b3d1c6333364c064cbd9976692b642df getDebotInfo "{}"

tonos-cli --url http://127.0.0.1 call --abi DeBotSL_Manager.abi.json --sign DeBotSL_Manager.keys.json 0:18c3f7ff4c976731cf13affd6501f895b3d1c6333364c064cbd9976692b642df setShoppingListCode shoppingList.decode.json



tonos-cli --url http://127.0.0.1 debot fetch 0:18c3f7ff4c976731cf13affd6501f895b3d1c6333364c064cbd9976692b642df

tonos-cli call 0:18c3f7ff4c976731cf13affd6501f895b3d1c6333364c064cbd9976692b642df savePublicKey '{"ownpubkey":"0b9c0a08ae349c6dbd99ecf9c9da8262c4c105281f99f2e07f2877729c6f52d7"}' --abi DeBotSL_Manager.abi.json --sign keys_01.json





