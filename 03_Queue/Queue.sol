pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

// This is class that describes you smart contract.
contract Queue {
    //Create array of strings to add names
    string[] public Queue;

    
    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    modifier checkOwnerAndAccept {
		// Check that message was signed with contracts key.
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		_;
	}

    //Just add name to array of names (Queue)
    function addToQueue(string name) public checkOwnerAndAccept {
        Queue.push(name);    
    }

    //Call first name in queue
    function callFromQueue() public checkOwnerAndAccept returns(string) {
        //Check that queue is not empty
        require(Queue.length > 0, 101, "Error: Queue is empty");
        //Remember first name in queue
        string next = Queue[0];
        //Update queue by shifting names
        for (uint i = 0; i < Queue.length - 1; i++) {
            Queue[i] = Queue[i + 1];
        }
        //Delete last name, because now it doubles
        Queue.pop();
        //Return remembered first name
        return next;
    }
    
}    