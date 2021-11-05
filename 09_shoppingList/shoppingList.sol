pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;
pragma AbiHeader pubkey;
import "AshoppingList.sol";
import "IshoppingList.sol";
import "shoppingStructs.sol";

contract shoppingList is AshoppingList {

    mapping(int32 => ShopItem) shopList;
    ShopListSummary shoppingStat;
    int32 IDcnt;

    constructor(uint _ownerPubkey) AshoppingList(_ownerPubkey) public {    
    }
    
    modifier onlyOwner() {
        require(msg.pubkey() == ownerPubkey, 101);
        _;
    }

    function addItemToList(string _itemName, int32 _itemNum) public onlyOwner {
        tvm.accept();
        IDcnt++;
        shopList[IDcnt] = ShopItem(IDcnt, _itemName, _itemNum, now, false, 0);
        shoppingStat.numItemsNotPaid += _itemNum;       
    }

    function deleteItemFromList(int32 _itemID) public onlyOwner {
        require(shopList.exists(_itemID), 102);
        tvm.accept();
        if (shopList[_itemID].itemIsPurchased) {
            shoppingStat.numItemsPaid -= shopList[_itemID].itemNum;
            shoppingStat.totalPricePaid -= shopList[_itemID].itemTotalPrice;
        }
        else {
            shoppingStat.numItemsNotPaid -= shopList[_itemID].itemNum;
        }
        delete shopList[_itemID];
    }

    function setItemIsPurchased(int32 _itemID, int32 _itemTotalPrice) public onlyOwner {
        require(shopList.exists(_itemID), 102);
        tvm.accept();
        shopList[_itemID].itemIsPurchased = true;
        shopList[_itemID].itemTotalPrice = _itemTotalPrice;
        shoppingStat.numItemsPaid += shopList[_itemID].itemNum;
        shoppingStat.numItemsNotPaid -= shopList[_itemID].itemNum;
        shoppingStat.totalPricePaid += _itemTotalPrice;
    }

    function getShoppingList() public view onlyOwner returns(ShopItem[] showShopList) {
        for((int32 itemID, ShopItem shopItemExample) : shopList) {
            showShopList.push(shopItemExample);
        }
    }

    function getShoppinngSummary() public view onlyOwner returns(ShopListSummary) {
        return shoppingStat;
    }


}