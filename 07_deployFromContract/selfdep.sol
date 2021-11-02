pragma ton-solidity >=0.32.0;
pragma AbiHeader expire;
import "WarGameObj.sol";
 
// This sample shows how the contract can deploy another contract of the same type

contract SelfDeployer {

   // uint static m_value;
  //  address static m_parent;

    uint public tvmpub;
    uint cnt = 0;

    uint public m_depth;
    mapping(address => bool) m_chilred;

    constructor(uint _depth) public {
        require(
            (tvm.pubkey() != 0 && tvm.pubkey() == msg.pubkey()) //||
     //       (msg.sender == m_parent)
        );
        tvm.accept();
        m_depth = _depth;
        tvmpub = tvm.pubkey();
         
        
    }

    modifier onlyOwner {
        require(tvm.pubkey() != 0 && tvm.pubkey() == msg.pubkey());
        tvm.accept();
        _;
    }

    function deploy(uint _value) onlyOwner public returns (address addr) {
        TvmCell code = tvm.code();
        addr = new WarGameObj{
            value: 2 ton,
            code: code,
            pubkey: tvm.pubkey(),
            varInit: {ID:cnt}
                // m_value: _value,
                // m_parent: address(this)
           // }
        }();  
        m_chilred[addr] = true;
        cnt++; 
    }
}