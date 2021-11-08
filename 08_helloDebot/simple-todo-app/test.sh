bash
cat todoDebot.abi.json | xxd -p -c 20000 > dabi.json

tonos-cli decode stateinit todo.tvc --tvc > todo.decode.json
exit