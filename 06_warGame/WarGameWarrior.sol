pragma ton-solidity >= 0.6;
pragma AbiHeader expire;
//import "WarGameUnit.sol";

contract WarGameWarrior{// is WarGameUnit {

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    
    } 
/* 
function setAttackVal(uint _objAttackVal) public virtual {
    } 

function setDefenceVal(uint _objDefenceVal) public virtual {
    }
*/
function foo(uint key) public returns(uint) {
    return (key+2);
    }
}

