bash
cat DeBotSL_Manager.abi.json | xxd -p -c 20000 > dabi.json

tonos-cli decode stateinit shoppingList.tvc --tvc > shoppingList.decode.json
exit