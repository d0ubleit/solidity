pragma ton-solidity >=0.35.0;
pragma AbiHeader expire;
pragma AbiHeader time;
pragma AbiHeader pubkey;

import "DeBotSL_BaseMethods.sol";

// SL = Shopping List
contract DeBotSL_Manager is DeBotSL_BaseMethods {

    int32 itemID;
    
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
                MenuItem("Show shopping list","",tvm.functionId(requestShowShoppingList)),
                MenuItem("Delete from shopping list","",tvm.functionId(deleteListItem)),
                MenuItem("Mark item as purchased","",tvm.functionId(markItemPurchased_ID))
            ] 
        ); 
    }

    
    function markItemPurchased_ID(uint32 index) public {
        index = index;
        if (SL_Summary.numItemsPaid + SL_Summary.numItemsNotPaid > 0) {
            Terminal.input(tvm.functionId(markItemPurchased_Price), "Enter ID of purchased item:", false);
        } else {
            Terminal.print(0, "Sorry, you have no items in shopping list");
            openMenu();
        }
    }

    function markItemPurchased_Price(string _itemID) public {
        (uint256 itemID_,) = stoi(_itemID);    
        itemID = int32(itemID_);
        Terminal.input(tvm.functionId(requestMarkItemPurchased), "Enter price you paid:", false);
    }

    function requestMarkItemPurchased(string _itemTotalPrice) public view {
        optional(uint256) pubkey = 0;
        (uint256 itemTotalPrice,) = stoi(_itemTotalPrice);
        IshoppingList(SL_address).setItemIsPurchased{
                abiVer: 2,
                extMsg: true,
                sign: true,
                pubkey: pubkey,
                time: uint64(now),
                expire: 0,
                callbackId: tvm.functionId(onSuccess),
                onErrorId: tvm.functionId(onError)
            }(itemID, int32(itemTotalPrice));
    }
    
}
