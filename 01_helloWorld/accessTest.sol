pragma ton-solidity >= 0.6;
pragma AbiHeader expire;
pragma AbiHeader pubkey;

contract accessTest {

    uint public c;

    constructor() public {
        tvm.accept();
    } 

    function foo(uint a) public returns(uint) { 
        tvm.accept();
        c = a*2;
        return c;   
    } 
 
}

