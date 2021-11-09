tondev sol compile wallet.sol
tonos-cli genaddr wallet.tvc wallet.abi.json --genkey wallet.keys.json > logWallet.log
#topup address
tonos-cli --url https://net.ton.dev deploy wallet.tvc "{}" --sign wallet.keys.json --abi wallet.abi.json

