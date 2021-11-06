tondev sol compile DeBotSL_Manager.sol

tonos-cli genaddr DeBotSL_Manager.tvc DeBotSL_Manager.abi.json --genkey DeBotSL_Manager.keys.json > log.log
create params.json with addr from log.log
0:471a3bd5174e3c39bfa8d1260f99eaa4956fc08c356a2a6fc7c04b7110b50d90
tonos-cli --url http://127.0.0.1 call --abi ../debotBase/Local_giver.abi.json 0:841288ed3b55d9cdafa806807f02a0ae0c169aa5edfe88a789a6482429756a94 sendGrams params.json
tonos-cli --url http://127.0.0.1 deploy DeBotSL_Manager.tvc "{}" --sign DeBotSL_Manager.keys.json --abi DeBotSL_Manager.abi.json
0:471a3bd5174e3c39bfa8d1260f99eaa4956fc08c356a2a6fc7c04b7110b50d90
./test2.sh
//tonos-cli --url http://127.0.0.1 call <address> setABI dabi.json --sign HelloDebot.keys.json --abi HelloDebot.abi.json

tonos-cli --url http://127.0.0.1 call 0:471a3bd5174e3c39bfa8d1260f99eaa4956fc08c356a2a6fc7c04b7110b50d90  setABI dabi.json --sign DeBotSL_Manager.keys.json --abi DeBotSL_Manager.abi.json

tonos-cli --url http://127.0.0.1 run --abi DeBotSL_Manager.abi.json 0:471a3bd5174e3c39bfa8d1260f99eaa4956fc08c356a2a6fc7c04b7110b50d90 getDebotInfo "{}"

tonos-cli --url http://127.0.0.1 call --abi DeBotSL_Manager.abi.json --sign DeBotSL_Manager.keys.json 0:471a3bd5174e3c39bfa8d1260f99eaa4956fc08c356a2a6fc7c04b7110b50d90 setShoppingListCode DeBotSL_Manager.decode.json



tonos-cli --url http://127.0.0.1 debot fetch 0:471a3bd5174e3c39bfa8d1260f99eaa4956fc08c356a2a6fc7c04b7110b50d90

tonos-cli call 0:471a3bd5174e3c39bfa8d1260f99eaa4956fc08c356a2a6fc7c04b7110b50d90 savePublicKey '{"ownpubkey":"0b9c0a08ae349c6dbd99ecf9c9da8262c4c105281f99f2e07f2877729c6f52d7"}' --abi DeBotSL_Manager.abi.json --sign keys_01.json





