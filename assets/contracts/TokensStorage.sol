// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 

contract TokenStorage{

    // ==================== STORAGE

        mapping(address => uint256) private _OpousMoneyBalances;
        mapping(address => uint256) private _ElectricityBalances;
        mapping(address => uint256) private _WheatBalances;
        mapping(address => uint256) private _BreadBalances;
        mapping(address => uint256) private _FlourBalances;
        mapping(address => uint256) private _MeatBalances;
        mapping(address => uint256) private _BodyFatBalances;
        mapping(address => uint256) private _BodyEnergyBalances;
        mapping(address => uint256) private _BodyHealthBalances;
        mapping(address => uint256) private _Birthday;
        mapping(address => uint256) private _PersonId;
        mapping(uint256 => address) private _PersonIdToAddress;
        mapping(address =>  string) private _PersonName;
        uint256 PersonIdNumerator = 100;

        // Gets the last time the building's owner used it to generate output
        mapping(string => uint256) private _HuntingCamp;
        mapping(string => uint256) private _Farm;
        mapping(string => uint256) private _Grindr;
        mapping(string => uint256) private _Bakery;
        mapping(string => uint256) private _Windmill;

        // sell data
        // meat
        uint256[] sellTicketIds;
        uint256[] sellMeatSellerId;
        uint256[] sellMeatAmont;
        uint256[] sellMeatPrice;
        uint256 smtNum = 0;
        uint256 smtIndex = 0;

    //


    // ==================== Methods - Special

        function getInventory(address to) public view returns(uint256[] memory) {
            uint256[] memory results = new uint256[](10);
            results[0] = _OpousMoneyBalances[to];
            results[1] = _ElectricityBalances[to];
            results[2] = _WheatBalances[to];
            results[3] = _BreadBalances[to];
            results[4] = _FlourBalances[to];
            results[5] = _MeatBalances[to];
            results[6] = _BodyHealthBalances[to];
            results[7] = _BodyFatBalances[to];
            results[8] = _BodyEnergyBalances[to];
            results[9] = _Birthday[to];
            return  results;
        }

        function setInventory(address to, uint256[] calldata data) public  {
            _OpousMoneyBalances[to] = data[0];
            _ElectricityBalances[to] = data[1];
            _WheatBalances[to] = data[2];
            _BreadBalances[to] = data[3];
            _FlourBalances[to] = data[4];
            _MeatBalances[to] = data[5];
            _BodyHealthBalances[to] = data[6];
            _BodyFatBalances[to] = data[7];
            _BodyEnergyBalances[to] = data[8];
            _Birthday[to] = data[9];
        }

    //

    // ==================== Methods - Sell

        function addSellMeat( uint256 amount, uint256 price) public{

            address to = tx.origin;
            require(_MeatBalances[to] > amount,"Not enugh meat");
            uint256 seller = _PersonId[to];
            _MeatBalances[to] -= amount;
            sellTicketIds.push(smtNum);
            sellMeatSellerId.push(seller);
            sellMeatAmont.push(amount);
            sellMeatPrice.push(price);
            smtNum++;
            smtIndex++;

        }
        

        function removeSellMeat( uint256 sellTicketId) public{

            uint256[] memory tempTickets = new uint256[](smtIndex-1);
            uint256[] memory tempSellers = new uint256[](smtIndex-1);
            uint256[] memory tempAmounts = new uint256[](smtIndex-1);
            uint256[] memory tempPrices = new uint256[](smtIndex-1);
            uint256 counter = 0;

            for(uint i=0; i < smtIndex; i++){
                if(i != sellTicketId){
                    tempTickets[counter] = sellTicketIds[counter];
                    tempSellers[counter] = sellMeatSellerId[counter];
                    tempAmounts[counter] = sellMeatAmont[counter];
                    tempPrices[counter] = sellMeatPrice[counter];
                    counter++;
                }
            }

            delete sellTicketIds;
            delete sellMeatSellerId;
            delete sellMeatAmont;
            delete sellMeatPrice;

            sellTicketIds = tempTickets;
            sellMeatSellerId = sellMeatSellerId;
            sellMeatAmont = sellMeatAmont;
            sellMeatPrice = sellMeatPrice;

            smtIndex--;
        }

        function getSellMeat(uint256 ticketId) public view returns(uint256[] memory){
            require(ticketId <= smtNum, "Ticket not valid");
            uint256[] memory res = new uint256[](4);

            for(uint i; i < smtIndex; i++){
                if( sellTicketIds[i] == ticketId ){
                    require(sellMeatAmont[i] > 0, "Ticket not valid 2");
                    res[0] = ticketId;
                    res[1] = sellMeatSellerId[i];
                    res[2] = sellMeatAmont[i];
                    res[3] = sellMeatPrice[i];
                }
            }
            return res;

        }

        function getAllSellMeat() public view returns(string[] memory){
            string[] memory res = new string[](smtIndex);
            for(uint i; i < smtIndex; i++){
                string memory r0 = append(u2s(sellTicketIds[i]),u2s(sellMeatSellerId[i]));
                string memory r1 = append(r0,u2s(sellMeatAmont[i]));
                string memory r2 = append(r1,u2s(sellMeatPrice[i]));
                res[i]=r2;
            }
            return res;
        }
    //

    
    
    // ==================== Methods - Standard


        function getOpousMoneyBalances(address adr) public view returns(uint256) {
            return _OpousMoneyBalances[adr];
        }

        function setOpousMoneyBalances(address adr, uint256 value) public {
            _OpousMoneyBalances[adr] = value;
        }

        function getElectricityBalances(address adr) public view returns(uint256) {
            return _ElectricityBalances[adr];
        }

        function setElectricityBalances(address adr, uint256 value) public {
            _ElectricityBalances[adr] = value;
        }

        function getWheatBalances(address adr) public view returns(uint256) {
            return _WheatBalances[adr];
        }

        function setWheatBalances(address adr, uint256 value) public {
            _WheatBalances[adr] = value;
        }

        function getBreadBalances(address adr) public view returns(uint256) {
            return _BreadBalances[adr];
        }

        function setBreadBalances(address adr, uint256 value) public {
            _BreadBalances[adr] = value;
        }

        function getFlourBalances(address adr) public view returns(uint256) {
            return _FlourBalances[adr];
        }

        function setFlourBalances(address adr, uint256 value) public {
            _FlourBalances[adr] = value;
        }

        function getMeatBalances(address adr) public view returns(uint256) {
            return _MeatBalances[adr];
        }

        function setMeatBalances(address adr, uint256 value) public {
            _MeatBalances[adr] = value;
        }

        function getBodyFatBalances(address adr) public view returns(uint256) {
            return _BodyFatBalances[adr];
        }

        function setBodyFatBalances(address adr, uint256 value) public {
            _BodyFatBalances[adr] = value;
        }

        function getBodyEnergyBalances(address adr) public view returns(uint256) {
            return _BodyEnergyBalances[adr];
        }

        function setBodyEnergyBalances(address adr, uint256 value) public {
            _BodyEnergyBalances[adr] = value;
        }

        function getBodyHealthBalances(address adr) public view returns(uint256) {
            return _BodyHealthBalances[adr];
        }

        function setBodyHealthBalances(address adr, uint256 value) public {
            _BodyHealthBalances[adr] = value;
        }

        function getPersonId(address adr) public view returns(uint256) {
            return _PersonId[adr];
        }

        function setPersonId(address adr, uint256 value) public {
            _PersonId[adr] = value;
        }

        function getBirthday(address adr) public view returns(uint256) {
            return _Birthday[adr];
        }

        function setBirthday(address adr, uint256 value) public {
            _Birthday[adr] = value;
        }

        function getPersonIdToAddress(uint id) public view returns(address) {
            return _PersonIdToAddress[id];
        }

        function setPersonIdToAddress(uint id, address value) public {
            _PersonIdToAddress[id] = value;
        }

        function getPersonName(address adr) public view returns(string memory) {
            return _PersonName[adr];
        }

        function setPersonName(address adr, string memory value) public {
            _PersonName[adr] = value;
        }
        
        function getPersonIdNumerator() public view returns(uint256) {
            return PersonIdNumerator;
        }

        function setPersonIdNumerator(uint256 value) public {
            PersonIdNumerator = value;
        }

        
        function getLastTimeHC(string calldata buildingId) public view returns(uint256){
            return _HuntingCamp[buildingId];
        }

        function setLastTimeHC(string calldata buildingId) public  {
            _HuntingCamp[buildingId] = block.timestamp;
        }
        
        function getLastTimeFarm(string calldata buildingId) public view returns(uint256){
            return _Farm[buildingId];
        }

        function setLastTimeFarm(string calldata buildingId) public  {
            _Farm[buildingId] = block.timestamp;
        }
        
        function getLastTimeGrindr(string calldata buildingId) public view returns(uint256){
            return _Grindr[buildingId];
        }

        function setLastTimeGrindr(string calldata buildingId) public  {
            _Grindr[buildingId] = block.timestamp;
        }
        
        function getLastTimeBakery(string calldata buildingId) public view returns(uint256){
            return _Bakery[buildingId];
        }

        function setLastTimeBakery(string calldata buildingId) public  {
            _Bakery[buildingId] = block.timestamp;
        }
        
        function getLastTimeWindmill(string calldata buildingId) public view returns(uint256){
            return _Windmill[buildingId];
        }

        function setLastTimeWindmill(string calldata buildingId) public  {
            _Windmill[buildingId] = block.timestamp;
        }
        


    //

    // ==================== Latheral
        function u2s(uint _i) internal pure returns (string memory _uintAsString) {
            if (_i == 0) {
                return "0";
            }
            uint j = _i;
            uint len;
            while (j != 0) {
                len++;
                j /= 10;
            }
            bytes memory bstr = new bytes(len);
            uint k = len;
            while (_i != 0) {
                k = k-1;
                uint8 temp = (48 + uint8(_i - _i / 10 * 10));
                bytes1 b1 = bytes1(temp);
                bstr[k] = b1;
                _i /= 10;
            }
            return string(bstr);
        }

        function append(string memory a, string memory b) internal pure returns (string memory) {
            return string(abi.encodePacked( a, "-", b));
        }
    //

}

interface ITokensStorage{
    
    // ==================== Methods

        function getInventory(address to) external view returns(uint256[] memory);
    
        function setInventory(address to, uint256[] memory data) external;
    
        function getOpousMoneyBalances(address adr) external view returns(uint256);

        function setOpousMoneyBalances(address adr, uint256 value) external;

        function getElectricityBalances(address adr) external view returns(uint256);

        function setElectricityBalances(address adr, uint256 value) external;

        function getWheatBalances(address adr) external view returns(uint256);

        function setWheatBalances(address adr, uint256 value) external;

        function getBreadBalances(address adr) external view returns(uint256);

        function setBreadBalances(address adr, uint256 value) external;

        function getFlourBalances(address adr) external view returns(uint256);

        function setFlourBalances(address adr, uint256 value) external;

        function getMeatBalances(address adr) external view returns(uint256);

        function setMeatBalances(address adr, uint256 value) external;

        function getBodyFatBalances(address adr) external view returns(uint256);

        function setBodyFatBalances(address adr, uint256 value) external;

        function getBodyEnergyBalances(address adr) external view returns(uint256);

        function setBodyEnergyBalances(address adr, uint256 value) external;

        function getBodyHealthBalances(address adr) external view returns(uint256);

        function setBodyHealthBalances(address adr, uint256 value) external;

        function getPersonId(address adr) external view returns(uint256);

        function setPersonId(address adr, uint256 value) external;
        
        function getBirthday(address adr) external view returns(uint256);

        function setBirthday(address adr, uint256 value) external ;

        function getPersonIdToAddress(uint id) external view returns(address);

        function setPersonIdToAddress(uint id, address value) external;

        function getPersonName(address adr) external view returns(string memory);

        function setPersonName(address adr, string memory value) external;
        
        function getPersonIdNumerator() external view returns(uint256);

        function setPersonIdNumerator(uint256 value) external;
        
        function getLastTimeHC(string calldata buildingId) external view returns(uint256);

        function setLastTimeHC(string calldata buildingId) external ;
        
        function getLastTimeFarm(string calldata buildingId) external view returns(uint256);

        function setLastTimeFarm(string calldata buildingId) external  ;
        
        function getLastTime_Grindr(string calldata buildingId) external view returns(uint256);

        function setLastTime_Grindr(string calldata buildingId) external  ;
        
        function getLastTimeBakery(string calldata buildingId) external view returns(uint256);

        function setLastTimeBakery(string calldata buildingId) external ;
        
        function getLastTimeWindmill(string calldata buildingId) external view returns(uint256);

        function setLastTimeWindmill(string calldata buildingId) external;
        

    //

}