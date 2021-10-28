pragma ton-solidity >= 0.6;
pragma AbiHeader expire;
import "WarGameObj.sol";

contract WarGameBase is WarGameObj {
    
    address[] public UnitsArr;
    address[] public testArr;

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        ownerPubKey = msg.pubkey();
    } 

    function addWarUnit() external {
        tvm.accept();
        UnitsArr.push(msg.sender);
    }

    function removeWarUnit() external{
        for (uint ind = 0; ind < UnitsArr.length; ind++) {
            testArr.push(msg.sender);
        
        /*    if (UnitsArr[ind] == msg.sender) {
                UnitsArr[ind] = UnitsArr[UnitsArr.length - 1];
                UnitsArr.pop();
            }
        */    
        }
    }

    function deathProcessing(address _enemyAddr) public override { //checkOwnerAndAccept{
        tvm.accept();
        address[] tempArr = UnitsArr;
        for (address unitAddr : tempArr) {
            WarGameObj(unitAddr).deathProcessing(_enemyAddr);
        }
        address lamp = address(0xb5e9240fc2d2f1ff8cbb1d1dee7fb7cae155e5f6320e585fcc685698994a19a5);
        lamp.transfer(777777777, true, 0);
        destroyAndTransfer(_enemyAddr);  
    }  

    
}
