bash
cat DeBotSL_Manager.abi.json | xxd -p -c 20000 > dabi.json

tonos-cli decode stateinit DeBotSL_Manager.tvc --tvc > DeBotSL_Manager.decode.json
exit