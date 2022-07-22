// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 


contract LandsStorage{
    
    // TYPES CODE CONVENTION 
        /*
        enum LandType{
            Forest,             // 0
            Empty,              // 1
            Mountain,           // 2
            Agricultural,       // 3
            Urban,              // 4
            Coast               // 5
        }*/
       
    //



    // ==================== STORAGE ====================

        // LandId is a string unique identifier like: AS21 which also is coordinates

        // All lnadIds eg:[AS21,AS22,AW32,...]
        string[] allLands;

        // Types of the All all lands in the same order eg: [0,1,4,...] - each index of the array
        // indicates the type pf the same index landId in the allLands array;
        uint256[] allLandsTypes;

        // sell offers. each string is LandId+Price
        string[] sellTickets;
        
        // Mapping from LandId to owner address
        mapping(string => address) private _landsOwners;

        // Mapping owner address to landIds
        mapping(address => string[]) private _addressLands;

        // Mapping from landId to lnadType eg: 0 = Forest
        mapping(string => uint256) private _landType;
        
        // Mapping from LandId to its building
        mapping(string => string) private _landsBuilding;

    //

    // Sell Offers

        function addToSellTickets(string memory sellTicket) public {
            sellTickets.push(sellTicket);
        }

        function getAllSellTickets() public view returns (string[] memory){
            return sellTickets;
        }

        function removeSellTicket(string memory ticket) public{
            uint num = sellTickets.length;
            string[] memory temp = sellTickets;
            delete sellTickets;
            sellTickets = new string[](0);

            for(uint i=0; i<num; i++){
                if(!compareStrings(temp[i],ticket)){
                    sellTickets.push(temp[i]);
                }
            }
        }

    //



    // ==================== METHODS Get Add Remove ====================

        //========== GEt


            function getAllLands() public view returns(string[] memory){
                return allLands;
            }

            function getAllLandsTypes() public view returns(uint256[] memory){
                return allLandsTypes;
            }

            function getNumberOfAllLands() public view returns(uint256){
                return allLands.length;
            }

            function getLandOwner(string calldata landId) public view returns(address){
                return _landsOwners[landId];
            }

            function getAddressLands(address adr) public view returns(string[] memory){
                return _addressLands[adr];
            }
            
            function getNumberOfAddressLands(address adr) public view returns(uint256){
                return _addressLands[adr].length;
            }

            function getLandType(string calldata landId) public view returns(uint256){
                return _landType[landId];
            }

            function getLandHasBuilding(string calldata landId) public view returns(bool){
                if(compareStrings(_landsBuilding[landId],"")){
                    return false;
                }
                return true;
            }

            function getLandsBuilding(string calldata landId) public view returns(string memory){
                return _landsBuilding[landId];
            }

        //

        string[]  Tlands = ["AQ21","AR21","AQ22","AR22","AS22","AS23","AT23","AR27","AS27","AT27","AS21","AT22","AU23","AT26","AU26","AU27","AT28","AU28","AN27","AM28","AN29","AM30","AN30"];
        uint256[]  Ttypes = [3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,4,0,0,0,0,0];

        function testInit () public {
            for(uint i; i<23; i++){
                mintLand(tx.origin, Tlands[i], Ttypes[i]);
            }
        }

        function mintLand(address to, string memory landId, uint256 landType) public {
            addToAllLands(landId,landType);
            setLandOwner(to,  landId );
            setLandType(landId, landType);
            addToAddressLands(to,  landId);
        }

        function transferLandOwnership(address to, string calldata lId) public {
            require(isLandExist(lId),"not existed");
            address formerOwner = _landsOwners[lId];
            require(to != formerOwner,"Destination is owner");
            require(to != address(0),"Destination is Zero");

            removeLandFromAddress(formerOwner, lId);

            _landsOwners[lId] = to;
            _addressLands[to].push(lId);
        }


        
        // ========== Lands
            
            // Mappiings


            function setLandOwner(address adr, string memory landId) public {
                _landsOwners[landId] = adr;
            }

            function addToAddressLands(address adr, string memory landId) public {
                _addressLands[adr].push(landId);
            }
            
            function removeLandFromAddress(address adr, string calldata landId) public {
                require(isLandExist(landId),"Not exist");
                uint256 num = _addressLands[adr].length;
                require( num>0 , "No Lands" );
                string[] memory tempLands = _addressLands[adr];
                delete _addressLands[adr];
                for(uint i=0; i<num; i++){
                    if(!compareStrings(tempLands[i] , landId)){
                        _addressLands[adr].push(tempLands[i]);
                    }
                }
            }

            function setAddressLands(address adr, string[] memory lands) public {
                _addressLands[adr] = lands;
            }

            function setLandType(string memory landId, uint256 landType) public {
                _landType[landId] = landType;
            }

            function setLandsBuilding(string calldata landId, string memory building) public {
                _landsBuilding[landId] = building;
            }

            // Arrays


            function addToAllLands(string memory land, uint256 landType) public {
                allLands.push(land);
                allLandsTypes.push(landType);
            }

            function removeFromAllLands(string calldata land) public {
                require(isLandExist(land),"Not exist");
                uint256 num = allLands.length;
                string[] memory temp = allLands;
                uint256[] memory tempTy = allLandsTypes;
                delete allLands;
                delete allLandsTypes;
                allLands = new string[](0);
                allLandsTypes = new uint256[](0);


                for(uint i=0; i<num; i++){
                    if(!compareStrings(temp[i] , land)){
                        allLands.push(temp[i]);
                        allLandsTypes.push(tempTy[i]);
                    }
                }
                
            }


            function isLandExist(string calldata landId) public view returns(bool){
                for(uint i; i<allLands.length; i++){
                    if(compareStrings(allLands[i],landId)){
                        return true;
                    }
                }
                return false;
            }

            function isTicketExist(string calldata ticket) public view returns(bool){
                for(uint i; i<sellTickets.length; i++){
                    if(compareStrings(sellTickets[i],ticket)){
                        return true;
                    }
                }
                return false;
            }


        //


    //

    // ==================== LATHERAL ====================
        function compareStrings(string memory a, string memory b) public pure returns (bool) {
            return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
        }

         //temporarily hold the string part until a space is recieved

        function splitStr(string memory str, string memory delimiter) public pure returns (string memory){ //delimiter can be any character that separates the integers 
            
            bytes memory b = bytes(str); //cast the string to bytes to iterate
            bytes memory delm = bytes(delimiter); 
            
            
            bytes memory tempNum; 
            uint tempInd = 0;
            uint pos =0;

            for(uint i; i<b.length ; i++){          
                if(b[i] == delm[0]) { //check if a not space
                    pos =i;           
                }
                else { 
                    if(pos>0){
                        tempNum[tempInd] = b[i];
                        tempInd++;
                    }
                    //numbers.push(strToUint(string(tempNum))); //push the int value converted from string to numbers array
                    //tempNum = "";   //reset the tempNum to catch the net number                 
                }                
            }
            return string(tempNum);

            //string memory result = (tempNum);
            //return result;
        }   

        function bytesToString(bytes memory _bytes32) public pure returns (string memory) {
            uint8 i = 0;
            while(i < 32 && _bytes32[i] != 0) {
                i++;
            }
            bytes memory bytesArray = new bytes(i);
            for (i = 0; i < 32 && _bytes32[i] != 0; i++) {
                bytesArray[i] = _bytes32[i];
            }
            return string(bytesArray);
        }

        function strToUint(string memory _str) public pure returns(uint256) {
            uint256 res =0;
            for (uint256 i = 0; i < bytes(_str).length; i++) {
                if ((uint8(bytes(_str)[i]) - 48) < 0 || (uint8(bytes(_str)[i]) - 48) > 9) {
                    return res;
                }
                res += (uint8(bytes(_str)[i]) - 48) * 10**(bytes(_str).length - i - 1);
            }
            
            return res;
        }
    //
}
