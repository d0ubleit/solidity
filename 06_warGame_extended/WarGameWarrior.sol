pragma ton-solidity >= 0.6;
pragma AbiHeader expire;
import "WarGameUnit.sol";

contract WarGameWarrior is WarGameUnit {

    uint static warriorID;
    string UnitName = "Warrior";
    
    constructor(address yourBaseAddr) WarGameUnit(yourBaseAddr) public {
        //require(tvm.pubkey() != 0, 101);
        //require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }
    
    function produceWarrior() external returns(address newWarrior) {
        tvm.accept();
        TvmCell code = tvm.code();
        newWarrior = new WarGameWarrior{
            value: 10 ton,
            code: code,
            pubkey: tvm.pubkey(),
            bounce: false,
            varInit: {
                warriorID: warriorID + 1
            }
        }(msg.sender);
       // warriorCnt++;
     } 


  
}

