pragma ton-solidity >=0.35.0;
pragma AbiHeader expire;
pragma AbiHeader time;
pragma AbiHeader pubkey;

import "DeBotSL_BaseMethods.sol";

// SL = Shopping List
contract DeBotSL_Manager is DeBotSL_BaseMethods {

    int32 _itemID;
    
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

    function markItemPurchased_Price(string value) public {
        (uint256 itemID_,) = stoi(value);    
        _itemID = int32(itemID_);
        Terminal.input(tvm.functionId(requestMarkItemPurchased), "Enter price you paid:", false);
    }

    function requestMarkItemPurchased(string value) public view {
        optional(uint256) pubkey = 0;
        (uint256 _itemTotalPrice,) = stoi(value);
        IshoppingList(SL_address).setItemIsPurchased{
                abiVer: 2,
                extMsg: true,
                sign: true,
                pubkey: pubkey,
                time: uint64(now),
                expire: 0,
                callbackId: tvm.functionId(onSuccess),
                onErrorId: tvm.functionId(onError)
            }(_itemID, int32(_itemTotalPrice));
    }
    
    function getDebotInfo() public functionID(0xDEB) override view returns(
        string name, string version, string publisher, string key, string author,
        address support, string hello, string language, string dabi, bytes icon
    ) {
        name = "Shopping List At Shop DeBot";
        version = "0.1";
        publisher = "d0ubleit";
        key = "Shopping List At Shop";
        author = "d0ubleit";
        support = address.makeAddrStd(0, 0x81b6312da6eaed183f9976622b5a39a90d5cff47e4d2a541bd97ee216e8300b1);
        hello = "This is Shopping List At Shop DeBot. Here you can see your list, mark item as paid, delete item";
        language = "en";
        dabi = m_debotAbi.get(); //Not changed to left base files untouched
        icon = Icon; 
    }

}
