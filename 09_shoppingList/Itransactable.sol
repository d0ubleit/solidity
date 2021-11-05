pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

interface Transactable {
    function sendTransaction() external;   
}