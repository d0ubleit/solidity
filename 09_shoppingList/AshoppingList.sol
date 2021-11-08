pragma ton-solidity >=0.35.0;
pragma AbiHeader expire;
pragma AbiHeader time;
pragma AbiHeader pubkey;

abstract contract AshoppingList {
    constructor(uint256 _ownerPubkey) public {
    }
}