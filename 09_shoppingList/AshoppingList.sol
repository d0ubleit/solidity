pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

abstract contract AshoppingList {
    
    uint ownerPubkey;

    constructor(uint256 _ownerPubkey) public {
        require(_ownerPubkey != 0, 120);
        tvm.accept();
        ownerPubkey = _ownerPubkey;
    }

}