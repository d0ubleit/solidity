pragma ton-solidity >=0.35.0;
pragma AbiHeader expire;
pragma AbiHeader time;
pragma AbiHeader pubkey;
import "shoppingStructs.sol";

interface IDeBotSL_Manager {
    function callbackFromAtShopDebot() external;
}

interface IDeBotSL_AtShop {
    function invokeFromManager(uint _ownerPubkey, address _SL_address) external;
}

