pragma ton-solidity >= 0.6;
pragma AbiHeader expire;

interface IWarGameObj {
    function acceptAttack(address aimAddr, uint _objAttackVal) external;
}
