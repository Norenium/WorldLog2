// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 

contract LandsAgent{   

    // ====================  ADMINISTRATIVE


        // ================ FEES ================
            
            uint256 permitFee = 10;
            uint256 buildingFee = 30;

        // 

        //string[]  lands = ["AS21","AT20","AT21","AT22","AT24","AU23","AU24","AW20","AW21","AW22","AX21","AX22","AS22","AS23","AS24","AS26","AT23","AN27","AN29","AN31"];
        //uint8[]  types = [4,4,4,4,4,4,4,4,4,4,4,4,3,3,3,3,3,0,0,0];
        string[]  lands = ["AQ21","AR21","AQ22","AR22","AS22","AS23","AT23","AR27","AS27","AT27","AS21","AT22","AU23","AT26","AU26","AU27","AT28","AU28","AN27","AM28","AN29","AM30","AN30"];
        uint8[]  types = [3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,4,0,0,0,0,0];

        function initializer(address LandStorageAdr) public {  //#=> replace public with internal or ... &&  add secretary origin

            setLandsStorageAddress(LandStorageAdr);
            batchMint(lands , 23,types );
            listLandToSell("AR21",300);
            listLandToSell("AS21",100);
            listLandToSell("AM28",300);
            listLandToSell("AQ22",300);
            listLandToSell("AR22",300);
        }


        address LSaddress;
        ILandsStorage LS;

        function getLandsStorageAddress() public view returns (address){
            return LSaddress;
        }

        function setLandsStorageAddress(address adr) public{
            LSaddress = adr;
            LS = ILandsStorage(adr);
        }


        address TAaddress;
        ITokenAgent TA;

        function getTokenAgentAddress() public view returns (address){
            return TAaddress;
        }

        function setTokenAgentAddress(address adr) public{
            TAaddress = adr;
            TA = ITokenAgent(adr);
        }

    //


    //  ==================== GET
    

        function getAddressLands(address adr) public view returns(string[] memory ){
            return LS.getAddressLands(adr);
        }
        
        function getAllLands() public view returns(string[] memory ){
            return LS.getAllLands();
        }

        function getAllLandsTypes() public view returns(uint256[] memory ){
            return LS.getAllLandsTypes();
        }

        function getlandOwner(string calldata landId) external view returns(address){
            return LS.getlandOwner(landId);
        }

        function getSellLandListPrice() public view returns(uint256[] memory ){
            return LS.getLandsToSellPrice();
        }

        function getSellLandListId() public view returns(string[] memory ){
            return LS.getLandsToSellId();
            //        getLandsToSellId
        }

        function getLandBuilding(string calldata landId) public view returns (string memory){
            return LS.getLandsBuilding(landId);
        }

        function getMyLands() public view returns (string[] memory){
            return LS.getAddressLands(tx.origin);
        }

        function getMyPermits() public view returns (string[] memory){
            return LS.getAddressPermits(tx.origin);
        }

        function getMyBuildings() public view returns (string[] memory){
            return LS.getAddressBuildings(tx.origin);
        }

        function getAllBuildings() public view returns (string[] memory){
            return LS.getAllBuildings();
        }

        function getAllBuildingsTypes() public view returns (uint256[] memory){
            return LS.getAllBuildingsTypes();
        }


    //

    //  ==================== MINT
        
        // ========== LAND
            function batchMint( string[] memory landIds, uint count, uint8[] memory landTypes) public {
                for(uint i = 0; i < count; i++){
                    _mint(tx.origin, landIds[i],landTypes[i]);
                    //setLandType(landIds[i],landTypes[i]);
                }
            }


            string[]  adLands;
            string[]  allLandsTemp;
            uint256[]  allLandsTypeTemp;
            uint256 stage = 0;
            //Mint a land
            function _mint(address to, string memory landId, uint256 landType) internal virtual {
                require(to != address(0), "ERC721: mint to the zero address");
                require(!_landExists(landId), "ERC721: token already minted");

                LS.addToAllLands(landId, landType);

                
                uint256 n = LS.getNumberOfLands(to);
                LS.setNumberOfLands(to,n+1);

                uint256 na = LS.getNumberOfAllLands();
                LS.setNumberOfAllLands(na+1);

                LS.setlandOwner(landId,to);
                
                delete adLands;
                adLands = LS.getAddressLands(to);
                adLands.push(landId);
                LS.setAddressLands(to, adLands);


                LS.setLandHasBuilding(landId, false);
                emit Transfer(address(0), to, landId);
                


            }

            // if a land ID exist
            function _landExists(string memory landId) internal view virtual returns (bool) {
                return LS.getlandOwner(landId) != address(0);
            }    
        //


        // ========== PERMITS
         
            // string memory permitId,

            function _mintPermit(address to, uint256 permitType, uint256 landType) public {
                require(to != address(0), "ERC721: mint to the zero address");
                uint256 pt = permitType;
                uint256 lt = permitType;
                require(pt < 6 , "Permit type is not valid");
                require(lt < 6 , "Land type is not valid");
                require(TAaddress != address(0) , "Token agent not set");
                require(TA.isAvailable(),"Token agent not abaillable");

                TA.pay(0xA02B2223d1ee0584545ffc804c518693C1d76de0,permitFee);
                uint256 numbreOfAllPermits = LS.getNumberOfAllPermits();

                string memory typeStr;
                if(pt == 0){typeStr = "HC";}
                if(pt == 1){typeStr = "WF";}
                if(pt == 2){typeStr = "GD";}
                if(pt == 3){typeStr = "BS";}
                if(pt == 4){typeStr = "WM";}
                if(pt == 5){typeStr = "HS";}

                string memory permitId = append(typeStr,uint2str(numbreOfAllPermits));
                require(!_permitExists(permitId), "ERC721: token already minted");

                /*
                    The operation of checking if the choosen permit type is compatiable with the landType
                    Must be implemented here.
                */

                LS.setPermitType(permitId, permitType);
                LS.setPermitsLandType(permitId, landType);
                
                LS.addToAddressPermits(to,permitId);
                LS.addToAllPermits(permitId);
                
                uint256 n = LS.getNumberOfPermits(to);
                LS.setNumberOfPermits(to,n+1);

                LS.setNumberOfAllPermits(numbreOfAllPermits+1);

                LS.setPermitOwner(permitId, to);
 



                delete allLandsTypeTemp;
                allLandsTypeTemp = LS.getAllPermitsTypes();
                allLandsTypeTemp.push(permitType);
                LS.setAllPermitsTypes(allLandsTypeTemp);

                LS.setPermitUsed(permitId, false);

                emit TransferPermit(address(0), to, permitId);

            }

            // if a permit ID exist
            function _permitExists(string memory permitId) private view returns (bool) {
                return LS.getPermitOwner(permitId) != address(0);
            }   

            event TransferPermit( address from, address to, string permitId);                      

        //

        // ========== BUILDING

            function _buildBuilding(address to, string memory permitId, string memory landId) public {
                
                
                require(to != address(0), "Build to the zero address");
                require(_permitExists(permitId), "Permit not exist");

                require(LS.getlandOwner(landId) == to, "Land is not yours");
                require(LS.getPermitOwner(permitId) == to, "Permit is not yours");
                require(!LS.getPermitUsed(permitId), "Permit has been used before");

                require(!LS.getLandHasBuilding(landId), "Land has a building");
                require(LS.getPermitsLandType(permitId) == LS.getLandType(landId),"types not same");
                require(TA.isAvailable(),"Token agent not abaillable");
                
                TA.pay(0xA02B2223d1ee0584545ffc804c518693C1d76de0,buildingFee);

                LS.setPermitUsed(permitId, true);
                LS.setLandHasBuilding(landId, true);

                string memory buildingId = append(landId,permitId);

                                
                uint256 n = LS.getNumberOfBuildings(to);
                LS.setNumberOfBuildings(to,n+1);

                uint256 na = LS.getNumberOfAllBuildings();
                LS.setNumberOfAllBuildings(na+1);
 
                LS.setBuildingOwner(buildingId, to);
  
                
                LS.addToAddressBuildings(to, buildingId);

                
            


                
                uint256 bt = LS.getPermitType(permitId);
                
                LS.addToAllBuildings(buildingId,bt);

                LS.setBuildingType(buildingId, bt);


              
                emit TransferBuilding(address(0), to, buildingId);

            }



            event TransferBuilding( address from, address to, string buildingId);                      

            function append(string memory a, string memory b) internal pure returns (string memory) {
                return string(abi.encodePacked( a, "-", b));
            }
        //
    
    //


    //  ==================== TRANSFER

        function transferLand ( address from, address to, string memory landId) public {

            require(to != address(0), "Send to the zero address");
            require(_landExists(landId), "Not existed");
            //require(msg.sender == from, "Not your own land");
            require( LS.getNumberOfLands(from) > 0, "Not any land existed");

            removeLand(from, landId);

            uint256 n = LS.getNumberOfLands(to);
            LS.setNumberOfLands(to,n+1);
            LS.setlandOwner(landId, to);

            delete adLands;
            adLands = LS.getAddressLands(to);
            adLands.push(landId);
            LS.setAddressLands(to, adLands);

            emit Transfer(address(0), to, landId);

        }

        function removeLand( address from, string memory landId) private { // problem here?
            uint256 number = LS.getNumberOfLands(from);
            require(number>1 , "#2 has not any land");
            string[] memory temp = LS.getAddressLands(from);
            string[] memory newArray = new string[](number-1);
            if(number == 1){
                LS.setAddressLands(from,newArray);
            }else{
                uint counter =0;
                for(uint i=0; i < number; i++){
                    if( compareStrings( temp[i], landId ) ){
                        
                    }else{
                        newArray[counter]=(landId);
                        counter++;
                    }
                }
               LS.setAddressLands(from,newArray);
            }
            
           LS.setNumberOfLands(from,number-1);
        }

        function compareStrings(string memory a, string memory b) public pure returns (bool) {
            return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
        }

        event Transfer( address from, address to, string landId);                      
    //

    // ==================== BUSINESSES 

        // ===== LANDS

            // Mapping from token ID to owner address
            //mapping(string => uint256) private _landSellPrices;
            //uint256 numberOfSellList;
            //string[] sellLandIds;


            function listLandToSell(string memory landId, uint256 price) public {
                require( LS.getlandOwner(landId) == tx.origin,"Not yours");

                /*
                delete adLands;
                adLands = LS.getLandsToSellId();
                adLands.push(landId);
                LS.setLandsToSellId( adLands );

                delete allLandsTypeTemp;
                allLandsTypeTemp = LS.getLandsToSellPrice();
                allLandsTypeTemp.push(price);
                LS.setLandsToSellPrice(allLandsTypeTemp);
                */
                LS.addLandToSellList(landId,price);
            }



            function removeMyLandFromSellList (string memory landId) public {
                require( LS.getlandOwner(landId) == tx.origin,"Not yours");
                LS.removeLandFromSellList(landId);
            }
            /*
            function removeLandFromSellList (string memory landId) private  {
              
                //   remove the id
                string[] memory temp = LS.getLandsToSellId();
                uint counter = 0;
                uint index = 0;

                delete adLands;
                adLands = new string[](temp.length-1);

                for(uint i=0; i < temp.length; i++){
                        if( compareStrings( temp[i], landId ) ){
                            index = i;
                        }else{
                            adLands[counter]=temp[i];     
                            counter++;
                        }
                }

                //LS.setLandsToSellId(adLands);


                //   remove the price
                uint256[] memory tempPrices = LS.getLandsToSellPrice();
                counter = 0;

                delete allLandsTypeTemp;
                allLandsTypeTemp = new uint256[](tempPrices.length-1);

                for(uint i=0; i < tempPrices.length; i++){
                        if( index == i ){
                            
                        }else{
                            allLandsTypeTemp[counter]=tempPrices[i];     
                            counter++;
                        }
                }

                //LS.setLandsToSellPrice(tempPrices);
            }*/
            
            function getLandPrice (string memory landId) private returns(uint256) {
              
                //   Finding the id index
                string[] memory temp = LS.getLandsToSellId();
                uint counter = 0;
                uint index = 0;
                uint256 result = 0;

                delete adLands;
                adLands = new string[](temp.length-1);

                for(uint i=0; i < temp.length; i++){
                        if( compareStrings( temp[i], landId ) ){
                            index = i;
                        }else{
                            adLands[counter]=temp[i];     
                            counter++;
                        }
                }

                
                //finding id price
                uint256[] memory tempPrices = LS.getLandsToSellPrice();
                counter = 0;

                delete allLandsTypeTemp;
                allLandsTypeTemp = new uint256[](tempPrices.length-1);

                for(uint i=0; i < tempPrices.length; i++){
                        if( index == i ){
                            result = tempPrices[i];
                        }else{
                            allLandsTypeTemp[counter]=tempPrices[i];     
                            counter++;
                        }
                }

                return result;
            }

            function buyLand(string memory landId, uint256 buyPrice) public {
                uint256 price = getLandPrice(landId);
                require(price > 0); // listed ad sell
                require(price == buyPrice); // check correctness
                require(TA.isAvailable(),"Token agent not abaillable");

                // Payment
                address seller = LS.getlandOwner(landId);
                TA.pay(seller, price);



                //

                //require(_balance > price)  // check for enught balance

                // Transfer the fee

                address to = tx.origin;
                transferLand(seller,to,landId);
                LS.removeLandFromSellList(landId);

            }
        //

        // ===== Permits


            // Should implement later
            function listPermitToSell(string memory landId, uint256 price) public {
                
                /*
                require( LS.getlandOwner(landId) == tx.origin,"Not yours");
                
                delete adLands;
                adLands = LS.getLandsToSellId();
                adLands.push(landId);
                LS.setLandsToSellId( adLands );

                delete allLandsTypeTemp;
                allLandsTypeTemp = LS.getLandsToSellPrice();
                allLandsTypeTemp.push(price);
                LS.setLandsToSellPrice(allLandsTypeTemp);
                */
            }


        //
    //

    // ==================== LATHERAL 
        function Tro() private view returns (address){
            return tx.origin;
        }

        
        /// convert uint to string 
        function uint2str(uint _i) internal pure returns (string memory _uintAsString) {
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

    //
}


interface ITokenAgent{

    function pay(address to, uint256 amount) external;
    function isAvailable() external pure returns (bool);
}


interface ILandsStorage{
 
    // ==================== METHODS Get Add Remove ====================

        // ========== Lands
            
            // Mappiings

            function getlandOwner(string calldata landId) external view returns(address);
            
            function setlandOwner(string calldata landId, address adr) external ;

            function getNumberOfLands(address adr) external view returns(uint256);

            function setNumberOfLands(address adr, uint256 number) external ;

            function getAddressLands(address adr) external view returns(string[] memory);

            function setAddressLands(address adr, string[] memory lands) external ;

            function getLandType(string calldata landId) external view returns(uint256);

            function setLandType(string calldata landId, uint256 landType) external ;

            function getLandHasBuilding(string calldata landId) external view returns(bool);

            function setLandHasBuilding(string calldata landId, bool state) external ;

            function getLandsBuilding(string calldata landId) external view returns(string memory);

            function setLandsBuilding(string calldata landId, string memory building) external ;

            // Arrays

            function getAllLands() external view returns(string[] memory);

            function addToAllLands(string memory land, uint256 landType) external ;

            function removeFromAllLands(string memory land) external ;


            function getAllLandsTypes() external view returns(uint256[] memory);

            function getNumberOfAllLands() external view returns(uint256);

            function setNumberOfAllLands(uint256 number) external ;

            function getLandsToSellId() external view returns(string[] memory);
            
            function getLandsToSellPrice() external view returns(uint256[] memory);

            function addLandToSellList(string memory lands, uint256 price) external ;

            function removeLandFromSellList(string memory land) external ;


  

        //


        // ========== Permits

            // mappings
            function getPermitOwner(string calldata PermitId) external view returns(address);

            function setPermitOwner(string calldata PermitId, address adr) external ;

            function getPermitType(string calldata PermitId) external view returns(uint256);

            function setPermitType(string calldata PermitId, uint256 permitType) external ;

            function getPermitsLandType(string calldata PermitId) external view returns(uint256);

            function setPermitsLandType(string calldata PermitId, uint256 landType) external ;

            function getPermitUsed(string calldata permitId) external view returns(bool);

            function setPermitUsed(string calldata permitId, bool state) external ;

            function getNumberOfPermits(address adr) external view returns(uint256);

            function setNumberOfPermits(address adr, uint256 number) external ;

            function getAddressPermits(address adr) external view returns(string[] memory);

            function addToAddressPermits(address adr, string memory Permit) external ;

            // Arrays
            function addToAllPermits(string memory Permits) external ;

            function getAllPermits() external view returns(string[] memory);

            function getAllPermitsTypes() external view returns(uint256[] memory);

            function setAllPermitsTypes(uint256[] memory PermitsTypes) external ;

            function getNumberOfAllPermits() external view returns(uint256);

            function setNumberOfAllPermits(uint256 number) external ;

            function getPermitsToSellId() external view returns(string[] memory);

            function setPermitsToSellId(string[] memory Permits) external ;

            function getPermitsToSellPrice() external view returns(string[] memory);

            function setPermitsToSellPrice(string[] memory Permits) external ;
            
        //


         // ========== Buildings

            function getAllBuildings() external view returns(string[] memory);

            function addToAllBuildings(string memory buildingId, uint256 buildingType) external;

            function removeFromAllBuildings(string[] memory Buildings) external ;

            function getAllBuildingsTypes() external view returns(uint256[] memory);

            function getNumberOfAllBuildings() external view returns(uint256);

            function setNumberOfAllBuildings(uint256 number) external ;

            function getBuildingOwner(string calldata BuildingId) external view returns(address);

            function setBuildingOwner(string calldata BuildingId, address adr) external ;

            function getAddressBuildings(address adr) external view returns(string[] memory);

            function addToAddressBuildings(address adr, string memory buildingId) external ;

            function removeFromAddressBuildings(address adr, string memory buildingId) external ;

            function getNumberOfBuildings(address adr) external view returns(uint256);

            function setNumberOfBuildings(address adr, uint256 number) external ;
            
            function getBuildingType(string calldata BuildingId) external view returns(uint256);

            function setBuildingType(string calldata BuildingId, uint256 BuildingType) external ;

        //
    //

}