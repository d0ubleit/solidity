pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

// This is class that describes you smart contract.
contract carToken {
    
    struct CarToken {
        string carName;
        uint carPower;
        uint carMaxSpeed;
        uint carTorque;
    }

    //Creating this struct is not optimal. 
    //Used for optional function getCarTokensOnSale
    struct CarTokenSaleCard{
        CarToken carTokenExample;
        uint carTokenPrice;
    }
    
    mapping (string => uint) carTokenNameKeys;
    uint[] ownersArr;
    mapping (uint => uint) public carTokenPrices;
    uint numCarTokensOnSale;
    CarToken[] public carTokenArr;
    
 /*  
     constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }
*/
/*
    modifier checkOwnerAndAccept {
		// Check that message was signed with contracts key.
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		_;
	}
*/ 
    function createCarToken (string _carName, uint _carPower, uint _carMaxSpeed, uint _carTorque) public {      
        bool carNameExists = false;
        for (uint i = 0; i < carTokenArr.length; i++) {
            if (carTokenArr[i].carName == _carName) {
                carNameExists = true;
            }
        }
        require(carNameExists == false, 255, "Error: This car name already exists");
        tvm.accept();
        uint ind = carTokenArr.length;
        ownersArr.push(msg.pubkey());
        carTokenNameKeys[_carName] = ind;
        carTokenArr.push(CarToken(_carName, _carPower, _carMaxSpeed, _carTorque));
        carTokenPrices[ind] = 0;
        
    }

    function putCarTokenOnSale (string _carTokenName, uint _carTokenPrice) public {
        uint _carTokenID = carTokenNameKeys[_carTokenName];
        require(msg.pubkey() == ownersArr[_carTokenID], 255, "Error: You are not owner of this token");
        require(_carTokenID < carTokenArr.length, 255, "Error: Token does not exist");
        tvm.accept();
        carTokenPrices[_carTokenID] = _carTokenPrice;
        numCarTokensOnSale++;
    } 

    function getCarTokensOnSale () public view returns(CarTokenSaleCard[]) {
        require(numCarTokensOnSale > 0, 255, "There is no carTokens on sale, come back later!");
        tvm.accept();
        CarTokenSaleCard[] carTokensOnSale;
        for ((uint key, uint price) : carTokenPrices) {
            if (price > 0) {
                carTokensOnSale.push(CarTokenSaleCard(carTokenArr[key], price)); 
            }               
        }
        return carTokensOnSale; 
    } 
   
    
}    