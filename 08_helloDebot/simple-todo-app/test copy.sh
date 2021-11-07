tondev sol compile todoDebot.sol

tonos-cli genaddr todoDebot.tvc todoDebot.abi.json --genkey todoDebot.keys.json > log.log
create params.json with addr from log.log
params.json
0:9f0adf7631457807aa9560f9653d63f001391a818fda5e84c53508c7766d296e
tonos-cli --url http://127.0.0.1 call --abi ../Local_giver.abi.json 0:841288ed3b55d9cdafa806807f02a0ae0c169aa5edfe88a789a6482429756a94 sendGrams params.json
tonos-cli --url http://127.0.0.1 deploy todoDebot.tvc "{}" --sign todoDebot.keys.json --abi todoDebot.abi.json


./test.sh
//tonos-cli --url http://127.0.0.1 call <address> setABI dabi.json --sign HelloDebot.keys.json --abi HelloDebot.abi.json

tonos-cli --url http://127.0.0.1 call 0:9f0adf7631457807aa9560f9653d63f001391a818fda5e84c53508c7766d296e  setABI dabi.json --sign todoDebot.keys.json --abi todoDebot.abi.json

tonos-cli --url http://127.0.0.1 run --abi todoDebot.abi.json 0:9f0adf7631457807aa9560f9653d63f001391a818fda5e84c53508c7766d296e getDebotInfo "{}"

tonos-cli --url http://127.0.0.1 call --abi todoDebot.abi.json --sign todoDebot.keys.json 0:9f0adf7631457807aa9560f9653d63f001391a818fda5e84c53508c7766d296e setTodoCode todoDebot.decode.json



tonos-cli --url http://127.0.0.1 debot fetch 0:9f0adf7631457807aa9560f9653d63f001391a818fda5e84c53508c7766d296e

tonos-cli call 0:9f0adf7631457807aa9560f9653d63f001391a818fda5e84c53508c7766d296e savePublicKey '{"ownpubkey":"0b9c0a08ae349c6dbd99ecf9c9da8262c4c105281f99f2e07f2877729c6f52d7"}' --abi todoDebot.abi.json --sign keys_01.json

0b9c0a08ae349c6dbd99ecf9c9da8262c4c105281f99f2e07f2877729c6f52d7

0:0f8e1204bc931d4fa443ee826d8faa5f157371b78d6d7ae8961dc32f3c7f3ae5



