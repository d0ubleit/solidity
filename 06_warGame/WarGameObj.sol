pragma ton-solidity >= 0.6;
pragma AbiHeader expire;
import "IWarGameObj.sol";

contract WarGameObj is IWarGameObj {

    int public objHealth = 10;
    uint objDefenceVal = 0;
    uint public ownerPubKey;
    address[] public attackersArr;

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        ownerPubKey = msg.pubkey();
    } 

    modifier checkOwnerAndAccept {
        require(msg.pubkey() == ownerPubKey, 102);
        tvm.accept();
        _;
    }

    function acceptAttack(address aimAddr, uint enemyAttackVal) external override {
        tvm.accept();
        address enemyAddr = msg.sender;
        attackersArr.push(msg.sender);
        if (enemyAttackVal > objDefenceVal) {
            objHealth -= int(enemyAttackVal) - int(objDefenceVal);
        }
        if (checkObjIsDead()) {
            deathProcessing(enemyAddr);
        }
    }

    function setDefenceVal(uint _objDefenceVal) public checkOwnerAndAccept {
        objDefenceVal = _objDefenceVal;
    }

    function checkObjIsDead() private returns(bool) {
        tvm.accept();
        if (objHealth <= 0) {
            return true;
        }
        else {
            return false;
        }
    }

    function deathProcessing(address _enemyAddr) public virtual checkOwnerAndAccept {
        //tvm.accept();
        address lamp = address(0xb5e9240fc2d2f1ff8cbb1d1dee7fb7cae155e5f6320e585fcc685698994a19a5);
        lamp.transfer(555555555, true, 0);
        destroyAndTransfer(_enemyAddr);  
    }

    function destroyAndTransfer(address _enemyAddr) internal {
        tvm.accept();
        _enemyAddr.transfer(1, true, 160); 
    }


} 

