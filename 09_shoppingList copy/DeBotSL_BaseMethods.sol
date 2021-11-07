pragma ton-solidity >=0.35.0;
pragma AbiHeader expire;
pragma AbiHeader time;
pragma AbiHeader pubkey;
    
import "ADeBotSL_Init.sol";
 
// SL = Shopping List
contract DeBotSL_BaseMethods is ADeBotSL_Init {
    
    function requestShowShoppingList(uint32 index) public view {
        index = index;
        optional(uint256) none;
        IshoppingList(SL_address).getShoppingList{
            abiVer: 2,
            extMsg: true,
            sign: true,
            pubkey: none,
            time: uint64(now),
            expire: 0,
            callbackId: tvm.functionId(showShoppingList),
            onErrorId: 0
        }();
    }

    function showShoppingList(ShopItem[] _shoppingList ) public {
        uint32 i;
        if (_shoppingList.length > 0 ) {
            Terminal.print(0, "Here is your shopping list:");
            for (i = 0; i < _shoppingList.length; i++) { 
                ShopItem SLexample = _shoppingList[i];
                string checkBox;
                if (SLexample.itemIsPurchased) {
                    checkBox = '✓';
                    Terminal.print(0, format("{} {}: \"{}\" - Amount:{} - Cost for all:{} - Created at {}", 
                        checkBox,
                        SLexample.itemID,
                        SLexample.itemName,
                        SLexample.itemNum,
                        SLexample.itemCreationTime,
                        SLexample.itemTotalPrice));
                } else {
                    checkBox = '-';
                    Terminal.print(0, format("{} {}: \"{}\" - Amount:{} - Created at {}", 
                        checkBox,
                        SLexample.itemID,
                        SLexample.itemName,
                        SLexample.itemNum,
                        SLexample.itemCreationTime
                        )); 
                } 
            }
        } else {
            Terminal.print(0, "Your shopping list is empty. Add something ;)");
        }
        openMenu();
    }

    function deleteListItem(uint32 index) public {
        index = index;
        if (SL_Summary.numItemsPaid + SL_Summary.numItemsNotPaid > 0) {
            Terminal.input(tvm.functionId(requestDeleteListItem), "Enter ID of item you want to delete:", false);
        } else {
            Terminal.print(0, "Sorry, you have no items in shopping list.");
            openMenu();
        }
    }

    function requestDeleteListItem(string _itemID) public view { 
        (uint256 itemID,) = stoi(_itemID); 
        optional(uint256) pubkey = 0;
        IshoppingList(SL_address).deleteItemFromList{ 
                abiVer: 2,
                extMsg: true,
                sign: true,
                pubkey: pubkey,
                time: uint64(now),
                expire: 0,
                callbackId: tvm.functionId(onSuccess),
                onErrorId: tvm.functionId(onError)
            }(int32(itemID)); 
    }

    function openMenu() public virtual override {   
    }
    
}
