tondev sol compile DeBotSL_AtShop.sol

tonos-cli genaddr DeBotSL_AtShop.tvc DeBotSL_AtShop.abi.json --genkey DeBotSL_AtShop.keys.json > logAtShop.log
create params.json with addr from logAtShop.log
params.json
dabi: http://tomeko.net/online_tools/file_to_hex.php?lang=en
0:c982199c489b7f142b65bc682397cc3ed8ef952beab595362c0cbcbe314d252a
tonos-cli --url https://net.ton.dev call --abi ../debotBase/Local_giver.abi.json 0:841288ed3b55d9cdafa806807f02a0ae0c169aa5edfe88a789a6482429756a94 sendGrams paramsAtShop.json
tonos-cli --url https://net.ton.dev deploy DeBotSL_AtShop.tvc "{}" --sign DeBotSL_AtShop.keys.json --abi DeBotSL_AtShop.abi.json


./test.sh
//tonos-cli --url https://net.ton.dev call <address> setABI dabi.json --sign HelloDebot.keys.json --abi HelloDebot.abi.json

tonos-cli --url https://net.ton.dev call 0:c982199c489b7f142b65bc682397cc3ed8ef952beab595362c0cbcbe314d252a  setABI dabiAtShop.json --sign DeBotSL_AtShop.keys.json --abi DeBotSL_AtShop.abi.json

tonos-cli --url https://net.ton.dev run --abi DeBotSL_AtShop.abi.json 0:c982199c489b7f142b65bc682397cc3ed8ef952beab595362c0cbcbe314d252a getDebotInfo "{}"

tonos-cli --url https://net.ton.dev call --abi DeBotSL_AtShop.abi.json --sign DeBotSL_AtShop.keys.json 0:c982199c489b7f142b65bc682397cc3ed8ef952beab595362c0cbcbe314d252a setShoppingListCode shoppingList.decode.json



tonos-cli --url https://net.ton.dev debot fetch 0:c982199c489b7f142b65bc682397cc3ed8ef952beab595362c0cbcbe314d252a

tonos-cli call 0:c982199c489b7f142b65bc682397cc3ed8ef952beab595362c0cbcbe314d252a savePublicKey '{"ownpubkey":"0b9c0a08ae349c6dbd99ecf9c9da8262c4c105281f99f2e07f2877729c6f52d7"}' --abi DeBotSL_AtShop.abi.json --sign keys_01.json

0:6659fa6107e3f9b781d9cf471cfa66d5e0a025e18c774ff1c601f2d034763e91
d5099d263d55ddd7848b4c9fd49f76ae5594b9c30c2df169d9b517206a6933d1

0:c9e4a4128ffb19e26425f7dac6495a16fe2aca150b20aa48e8962c6aa54bf96a
73b465fbfcf01a9d62810b7337f33ec34ec238af945c51398a4f43f5fdd647f1



