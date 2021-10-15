// SPDX-License-Identifier: MIT

pragma solidity >=0.6; 

contract eth_queue {
    string[] public Queue;
    function addToQueue(string memory name) public {
        Queue.push(name);
        
    }
    
    function callFromQueue() public returns(string memory) {
        require(Queue.length > 0, "Error: Queue is empty");
        string memory next = Queue[0];
        for (uint i = 0; i < Queue.length - 1; i++) {
            Queue[i] = Queue[i + 1];
        }
        Queue.pop();
        return next;
        
    }
    
}
