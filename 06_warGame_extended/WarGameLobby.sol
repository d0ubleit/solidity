pragma ton-solidity >= 0.6;
pragma AbiHeader expire;
import "WarGameBase.sol";

contract WarGameLobby {

    address adminAddr;
    mapping (address => uint) public usersBaseAddrMap;
    uint baseID = 1;

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        adminAddr = msg.sender;
    }

    modifier checkOwnerAndAccept {
        require(msg.sender == adminAddr, 102);
        tvm.accept();
        _;
    }
    

    function startGame(address rootBaseAddr) public {
        tvm.accept();
        address newBaseA;
        //address newBaseA = WarGameBase(rootBaseAddr).selfProduceBase(baseID);
        WarGameBase(rootBaseAddr).selfProduceBase(baseID);
        
    }

    function addBase(address newBase) external returns(address) {
        tvm.accept();
        usersBaseAddrMap[newBase] = baseID;
        baseID++;
    }



}  