pragma ton-solidity >= 0.6;
pragma AbiHeader expire;
import "WarGameObj.sol";
import "WarGameUnit.sol" as WGUnit;
import "WarGameWarrior.sol" as WGW;
import "WarGameLobby.sol" as Lobby;

contract WarGameBase is WarGameObj {
    
    uint static baseID;
    uint public warriorCnt = 0;

    mapping(address => bool) public UnitsMap;

    constructor() public {
        //require(tvm.pubkey() != 0, 101);
        //require(msg.pubkey() == tvm.pubkey(), 102);
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

    function produceUnit(address mainWarAddr) public checkOwnerAndAccept {
        tvm.accept();
        WGW.WarGameWarrior(mainWarAddr).produceWarrior();
    }
    
    function selfProduceBase(uint _baseID) external {
        tvm.accept();
        TvmCell code = tvm.code();
        address newBase = new WarGameBase{
            value: 2 ton,
            code: code,
            pubkey: tvm.pubkey(),
            bounce: false,
            varInit: {
                baseID: _baseID
            }
        }();
        Lobby.WarGameLobby(msg.sender).addBase(newBase);
    } 

    
}
