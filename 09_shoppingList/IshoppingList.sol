pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;
import "shoppingStructs.sol";

interface IshoppingList {
    function addItemToList(string _itemName, int32 _itemNum) external;
    function deleteItemFromList(int32 _itemID) external;
    function setItemIsPurchased(int32 _itemID, int32 _itemTotalPrice) external;
    function getShoppingList() external returns(ShopItem[] showShopList);
    function getShoppinngSummary() external returns(ShopListSummary);
}

