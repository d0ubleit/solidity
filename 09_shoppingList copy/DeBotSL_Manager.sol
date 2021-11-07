pragma ton-solidity >=0.35.0;
pragma AbiHeader expire;
pragma AbiHeader time;
pragma AbiHeader pubkey;

import "DeBotSL_BaseMethods.sol";

// SL = Shopping List
contract DeBotSL_Manager is DeBotSL_BaseMethods {

    string itemName;
    
    function openMenu() public override {
        string sep = '----------------------------------------';
        Menu.select(
            format(
                "Shopping list: Not paid: {} | Paid: {} | Total: {}",
                    SL_Summary.numItemsNotPaid,
                    SL_Summary.numItemsPaid,
                    SL_Summary.numItemsNotPaid + SL_Summary.numItemsPaid
            ),
            sep,
            [
                MenuItem("Add to shopping list","",tvm.functionId(addToList_name)),
                MenuItem("Show shopping list","",tvm.functionId(requestShowShoppingList)),
                MenuItem("Delete from shopping list","",tvm.functionId(deleteListItem))
            ]
        );
    }

    function addToList_name(uint32 index) public {
        index = index;
        Terminal.input(tvm.functionId(addToList_num), "Name of item you want to buy:", false);
    }

    function addToList_num(string _itemName) public {
        itemName = _itemName;
        Terminal.input(tvm.functionId(requestAddToList), "How many items you need:", false);
    }

    function requestAddToList(string _itemNum) public view {
        (uint256 itemNum,) = stoi(_itemNum);
        optional(uint256) pubkey = 0;
        IshoppingList(SL_address).addItemToList{
                abiVer: 2,
                extMsg: true,
                sign: true,
                pubkey: pubkey,
                time: uint64(now), 
                expire: 0,
                callbackId: tvm.functionId(onSuccess),
                onErrorId: tvm.functionId(onError)
            }(itemName, int32(itemNum)); 
    }  
}
