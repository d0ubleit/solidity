pragma ton-solidity >= 0.6;
pragma AbiHeader expire;
import "WarGameObj.sol";
import "WarGameBase.sol";

contract WarGameUnit is WarGameObj {

    address public BaseAddr; 
    uint objAttackVal;

    constructor(address yourBaseAddr) public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        BaseAddr = yourBaseAddr;
        ownerPubKey = msg.pubkey();
        WarGameBase(BaseAddr).addWarUnit();
    } 

    function setAttackVal(uint _objAttackVal) public checkOwnerAndAccept {
        objAttackVal = _objAttackVal;
    }

    function attackEnemy(address _enemyAddr, uint _objAttackVal) public {
        tvm.accept();
        IWarGameObj(_enemyAddr).acceptAttack(_enemyAddr, _objAttackVal); 
    }

    function deathProcessing(address _enemyAddr) public override {
        //require(msg.pubkey() == tvm.pubkey() || msg.sender == BaseAddr, 102);
        tvm.accept();
        WarGameBase(BaseAddr).removeWarUnit();
        address lamp = address(0xb5e9240fc2d2f1ff8cbb1d1dee7fb7cae155e5f6320e585fcc685698994a19a5);
        lamp.transfer(999999999, true, 0);
        destroyAndTransfer(_enemyAddr);  
    }  



}
