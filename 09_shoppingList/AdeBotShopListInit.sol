pragma ton-solidity >=0.35.0;
pragma AbiHeader expire;
pragma AbiHeader time;
pragma AbiHeader pubkey;

import "../debotBase/Debot.sol";
import "../debotBase/Terminal.sol";
import "../debotBase/Menu.sol";
import "../debotBase/AddressInput.sol";
import "../debotBase/ConfirmInput.sol";
import "../debotBase/Upgradable.sol";
import "../debotBase/Sdk.sol";

import "AshoppingList.sol";
import "IshoppingList.sol";
import "Itransactable.sol";

// SL = ShoppingList
abstract contract AdeBotShopListInit is Debot, Upgradable {
    bytes Icon;

    TvmCell SL_Code; 
    address SL_address;  
    ShopListSummary SL_Summary;        
    int32 SL_itemID;    
    uint256 ownerPubkey; 
    address ownerWalletAddr; 

    uint32 INITIAL_BALANCE =  200000000;


    function setShoppingListCode(TvmCell code) public {
        require(msg.pubkey() == tvm.pubkey(), 101);
        tvm.accept();
        SL_Code = code;
    }


    function onError(uint32 sdkError, uint32 exitCode) public {
        Terminal.print(0, format("Operation failed. sdkError {}, exitCode {}", sdkError, exitCode));
        openMenu();
    }
     
    function onSuccess() public view {
        requestGetSummary(tvm.functionId(setSummary));
    }

    function start() public override {
        Terminal.input(tvm.functionId(savePublicKey),"Please enter your public key",false);
    }

    ///////////////////////////////////----------------------////////////////////////////////
    
    ///////////////////////////////////инфо можно вынести в каждый контракт разное.//////////
                                        
    ///////////////////////////////////----------------------////////////////////////////////
    function getDebotInfo() public functionID(0xDEB) override view returns(
        string name, string version, string publisher, string key, string author,
        address support, string hello, string language, string dabi, bytes icon
    ) {
        name = "Shopping List DeBot";
        version = "0.1";
        publisher = "d0ubleit";
        key = "Shopping List manager";
        author = "d0ubleit";
        //////////////////////////////!!!!!!!!!!!!!!!!!!!!!!///////////////////////////////////////////////
        support = address.makeAddrStd(0, 0x66e01d6df5a8d7677d9ab2daf7f258f1e2a7fe73da5320300395f99e01dc3b5f);
        hello = "This is Shopping List DeBot. With me you won't miss any purchase!";
        language = "en";
        dabi = m_debotAbi.get(); //Not changed to left base files untouched
        icon = Icon; 
    }

    function getRequiredInterfaces() public view override returns (uint256[] interfaces) {
        return [ Terminal.ID, Menu.ID, AddressInput.ID, ConfirmInput.ID ];
    }

    function savePublicKey(string _ownpubkey) public {
        (uint res, bool status) = stoi("0x"+_ownpubkey);
        if (status) {
            ownerPubkey = res;
            Terminal.print(0, "Checking if you already have a Shopping list ...");
            TvmCell deployState = tvm.insertPubkey(SL_Code, ownerPubkey);
            SL_address = address.makeAddrStd(0, tvm.hash(deployState));
            Terminal.print(0, format( "Info: your Shopping List contract address is {}", SL_address));
            Sdk.getAccountType(tvm.functionId(checkAccountStatus), SL_address);

        } else {
            Terminal.input(tvm.functionId(savePublicKey),"Wrong public key. Try again!\nPlease enter your public key",false);
        }
    }


    function checkAccountStatus(int8 acc_type) public {
        if (acc_type == 1) { // acc is active and  contract is already deployed
            requestGetSummary(tvm.functionId(setSummary));  

        } else if (acc_type == -1)  { // acc is inactive
            Terminal.print(0, "You don't have a Shopping list yet, so a new contract with an initial balance of 0.2 tokens will be deployed");
            AddressInput.get(tvm.functionId(creditAccount),"Select a wallet for payment. We will ask you to sign two transactions");

        } else  if (acc_type == 0) { // acc is uninitialized
            Terminal.print(0, format(
                "Deploying new contract. If an error occurs, check if your Shopping List contract has enough tokens on its balance"
            ));
            deploy();

        } else if (acc_type == 2) {  // acc is frozen
            Terminal.print(0, format("Can not continue: account {} is frozen", SL_address)); 
        }
    }


    function creditAccount(address value) public {
        ownerWalletAddr = value;
        optional(uint256) pubkey = 0;
        TvmCell empty;
        Itransactable(ownerWalletAddr).sendTransaction{
            abiVer: 2,
            extMsg: true,
            sign: true,
            pubkey: pubkey,
            time: uint64(now),
            expire: 0,
            callbackId: tvm.functionId(waitBeforeDeploy),
            onErrorId: tvm.functionId(onErrorRepeatCredit)  // Just repeat if something went wrong
        }(SL_address, INITIAL_BALANCE, false, 3, empty);
    }

    function onErrorRepeatCredit(uint32 sdkError, uint32 exitCode) public {
        //check errors if needed.
        sdkError;
        exitCode;
        creditAccount(ownerWalletAddr);
    }


    function waitBeforeDeploy() public  {
        Sdk.getAccountType(tvm.functionId(checkContractDeployed), SL_address);
    }

    function checkContractDeployed(int8 acc_type) public {
        if (acc_type ==  0) {
            deploy();
        } else {
            waitBeforeDeploy();
        }
    }


    function deploy() private view {
            TvmCell image = tvm.insertPubkey(SL_Code, ownerPubkey);
            optional(uint256) none;
            TvmCell deployMsg = tvm.buildExtMsg({
                abiVer: 2,
                dest: SL_address,
                callbackId: tvm.functionId(onSuccess),
                onErrorId:  tvm.functionId(onErrorRepeatDeploy),    // Just repeat if something went wrong
                time: 0,
                expire: 0,
                sign: true,
                pubkey: none,
                stateInit: image,
                call: {AshoppingList, ownerPubkey}
            });
            tvm.sendrawmsg(deployMsg, 1);
    }


    function onErrorRepeatDeploy(uint32 sdkError, uint32 exitCode) public view {
        // check errors if needed.
        sdkError;
        exitCode;
        deploy();
    }

    function onCodeUpgrade() internal override {
        tvm.resetStorage();
    }

    function requestGetSummary(uint32 answerId) private view {
        optional(uint256) none;
        IshoppingList(SL_address).getShoppinngSummary{
            abiVer: 2,
            extMsg: true,
            sign: true,
            pubkey: none,
            time: uint64(now),
            expire: 0,
            callbackId: answerId,
            onErrorId: 0
        }();
    }

    function setSummary(ShopListSummary summary) public {
        SL_Summary = summary;
        openMenu();
    }

    ///////////////////////////////Try to do with interface and make func private
    function openMenu() public virtual {   
    }
             
}
