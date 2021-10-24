pragma ton-solidity >= 0.6;
pragma AbiHeader expire;


contract Wallet {
    //Parameter to expand functionality
    //Transaction will be declined if balance
    //becomes less than minimal limit after transaction
    uint128 minLimit = 0;
    
    /*
     Exception codes:
      100 - message sender is not a wallet owner.
      101 - invalid transfer value.
     */

    constructor() public {
        // check that contract's public key is set
        require(tvm.pubkey() != 0, 101);
        // Check that message has signature (msg.pubkey() is not zero) and message is signed with the owner's private key
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

 

    modifier checkOwnerAndAccept {
        require(msg.pubkey() == tvm.pubkey(), 100);
		tvm.accept();
		_;
	}


    /// dev Allows to transfer tons to the destination account.
    /// param dest Transfer target address.
    /// param value Nanotons value to transfer.
    /// param bounce Flag that enables bounce message in case of target contract error.

    //Bounce parameter removed from function attributes to create
    //user friendly interface
    function sendTxNoFee(address dest, uint128 value) public view checkOwnerAndAccept {
        require(address(this).balance - value >= minLimit, 101, "Minimal limit will be reached after send this value");
        dest.transfer(value, true, 0);
    }

    function sendTxPayFee(address dest, uint128 value) public view checkOwnerAndAccept {
        uint128 meanFee = 11000000;
        require(address(this).balance - value >= minLimit + meanFee, 101, "Minimal limit will be reached after send this value");
        dest.transfer(value, true, 1);
            
    }

    function sendTxAllDestroy(address dest) public pure checkOwnerAndAccept {
        dest.transfer(1, true, 160);
    }


    /////////////////////////
    //Expanding functionality
    /////////////////////////
    //Manual control transfer mode
    //No limits check
    function sendTxManualControl(address dest, uint128 value, bool bounce, uint16 flag) public pure checkOwnerAndAccept {
        dest.transfer(value, bounce, flag);
    }

    //Set minimal limit of balance
    function setMinBalance(uint128 _minLimit) public checkOwnerAndAccept {
        minLimit = _minLimit;
    }

    //Show balance of contract function
    //Allowed for all users
    function showBalance() public view returns(uint128) {
        tvm.accept();
        return address(this).balance;
    }

    //Show balance, minimal limit and available funds
    //Allowed for owner only
    function showBalance_Owner() public view checkOwnerAndAccept returns(string, uint128, string, uint128, string, uint128) {
        return (
            "Balance:", address(this).balance,
            "Minimal limit set to:", minLimit,
            "Available funds:", address(this).balance - minLimit
        );
    }


}