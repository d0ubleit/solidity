pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Multiply {

	// State variable storing the result of multiplication with arguments that were passed to function 'mult',
	uint public result = 0;

	constructor() public {
		// check that contract's public key is set
		require(tvm.pubkey() != 0, 101);
		// Check that message has signature (msg.pubkey() is not zero) and message is signed with the owner's private key
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		// Initialize result with 1
		result = 1;
	}

	// Modifier that allows to accept some external messages
	modifier checkOwnerAndAccept {
		// Check that message was signed with contracts key.
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		_;
	}

	// Function that multiply its argument to the state variable.
	function Mult(uint value) public checkOwnerAndAccept {
		require(value >= 1 && value <= 10, 196, "Wrong value: 1 <= value <= 10");
		result *= value;
	}
}