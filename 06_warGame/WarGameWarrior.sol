pragma ton-solidity >= 0.6;
pragma AbiHeader expire;
import "WarGameUnit.sol";

contract WarGameWarrior is WarGameUnit {

    string UnitName = "Warrior";
    
    constructor(address yourBaseAddr) WarGameUnit(yourBaseAddr) public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }
    
  
}

