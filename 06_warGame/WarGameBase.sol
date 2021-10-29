pragma ton-solidity >= 0.6;
pragma AbiHeader expire;
import "WarGameObj.sol";
import "WarGameUnit.sol" as WGUnit;

contract WarGameBase is WarGameObj {
    
    mapping(address => bool) public UnitsMap;

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    } 

    function addWarUnit() external {
        tvm.accept();
        UnitsMap.add(msg.sender, true); 
    }

    function removeWarUnit() external {
        require(UnitsMap.exists(msg.sender), 102, "Error: This unit not associated with this base");
        tvm.accept();
        delete UnitsMap[msg.sender];
        
    } 

    function deathProcessing(address _enemyAddr) internal override { 
        tvm.accept(); 
        mapping(address => bool) TempMap = UnitsMap;
        for ((address UnitAddr, ) : TempMap) {
            WGUnit.WarGameUnit(UnitAddr).deathOfBase(_enemyAddr);
        }
        destroyAndTransfer(_enemyAddr);   
    }  

    
}
