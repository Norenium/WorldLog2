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

        // Mapping from LandId to owner address
        mapping(string => address) private _landsOwners;

        // Mapping owner address to landIds
        mapping(address => string[]) private _addressLands;

        // Mapping from landId to lnadType eg: 0 = Forest
        mapping(string => uint256) private _landType;
        
        // Mapping from LandId to its building
        mapping(string => string) private _landsBuilding;

    //

        



    // ==================== METHODS Get Add Remove ====================

        string[]  Tlands = ["AQ21","AR21","AQ22","AR22","AS22","AS23","AT23","AR27","AS27","AT27","AS21","AT22","AU23","AT26","AU26","AU27","AT28","AU28","AN27","AM28","AN29","AM30","AN30"];
        uint256[]  Ttypes = [3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,4,0,0,0,0,0];

        function testInit () public {
            for(uint i; i<23; i++){
                testMintLand(Tlands[i], Ttypes[i]);
            }
        }

        function testMintLand(string memory landId, uint256 landType) public {
            addToAllLands(landId,landType);
            address to = 0x87B64804e36f20acA9052D3b4Cd7188D41b59f97;
            setlandOwner(to,  landId );
            setLandType(landId, landType);
            addToAddressLands(to,  landId);
            // check if needed to set something for _landsBuilding
        }
        // ========== Lands
            
            // Mappiings

            function getlandOwner(string calldata landId) public view returns(address){
                return _landsOwners[landId];
            }

            function setlandOwner(address adr, string memory landId) public {
                _landsOwners[landId] = adr;
            }

            function addToAddressLands(address adr, string memory landId) public {
                _addressLands[adr].push(landId);
            }
            
            function removeLandFromAddress(address adr, string memory landId) public {
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

            function getAddressLands(address adr) public view returns(string[] memory){
                return _addressLands[adr];
            }
            
            function getNumberOfAddressLands(address adr) public view returns(uint256){
                return _addressLands[adr].length;
            }

            function setAddressLands(address adr, string[] memory lands) public {
                _addressLands[adr] = lands;
            }

            function getLandType(string calldata landId) public view returns(uint256){
                return _landType[landId];
            }

            function setLandType(string memory landId, uint256 landType) public {
                _landType[landId] = landType;
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

            function setLandsBuilding(string calldata landId, string memory building) public {
                _landsBuilding[landId] = building;
            }

            // Arrays

            function getAllLands() public view returns(string[] memory){
                return allLands;
            }

            function addToAllLands(string memory land, uint256 landType) public {
                allLands.push(land);
                allLandsTypes.push(landType);
            }

            function removeFromAllLands(string memory land) public {
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


            function getAllLandsTypes() public view returns(uint256[] memory){
                return allLandsTypes;
            }

            function getNumberOfAllLands() public view returns(uint256){
                return allLands.length;
            }

            function isLandExist(string memory landId) public view returns(bool){
                for(uint i; i<allLands.length; i++){
                    if(compareStrings(allLands[i],landId)){
                        return true;
                    }
                }
                return false;
            }


            /*
            function getLandsToSellId() public view returns(string[] memory){
                return landsToSellId;
            }
            
            function getLandsToSellPrice() public view returns(uint256[] memory){
                return landsToSellPrice;
            }

            function getNumberOfAllSellLandsList() public view returns(uint256){
                return numberOfAllSellLandsList;
            }

            function addLandToSellList(string memory lands, uint256 price) public {
                landsToSellId.push(lands);
                landsToSellPrice.push(price);
                numberOfAllSellLandsList++;
            }

            function removeLandFromSellList(string memory land) public {

                uint256 num = numberOfAllSellLandsList;
                string[] memory temp = landsToSellId;
                uint256[] memory tempPr = landsToSellPrice;
                delete landsToSellId;
                delete landsToSellPrice;
                //landsToSellId = new string[](num-1);
                //landsToSellPrice = new uint256[](num-1);

                
                for(uint i=0; i<num; i++){
                    if(!compareStrings(temp[i],land)){
                        landsToSellId.push(temp[i]);
                        landsToSellPrice.push(tempPr[i]);
                    }
                }

                numberOfAllSellLandsList--;
            }
            */

  

        //


    //

    // ==================== LATHERAL ====================
        function compareStrings(string memory a, string memory b) public pure returns (bool) {
            return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
        }
    //
}

/*
interface ILandsStorage{

    // ========== Lands

        function getlandOwner(string calldata landId) external view returns(address);

        function setlandOwner(string calldata landId, address adr) external;

        function getNumberOfLands(address adr) external view returns(uint256);

        function setNumberOfLands(address adr, uint256 number) external;

        function getAddressLands(address adr) external view returns(string[] memory);

        function setAddressLands(address adr, string[] calldata lands) external ;

        function getLandType(string calldata landId) external view returns(uint256);

        function setLandType(string calldata landId, uint256 landType) external;

        function getLandHasBuilding(string calldata landId) external view returns(bool);
        
        function setLandHasBuilding(string calldata landId, bool state) external;

        function getLandsBuilding(string calldata landId) external view returns(string memory);

        function setLandsBuilding(string calldata landId, string memory building) external;

        function getAllLands() external view returns(string[] memory);

        function setAllLands(string[] memory lands) external;
        
        function getAllLandsTypes() external view returns(uint256[] memory);

        function setAllLandsTypes(uint256[] memory landsTypes) external ;

        function getNumberOfAllLands() external view returns(uint256);

        function setNumberOfAllLands(uint256 number) external;

        function getLandsToSellId() external view returns(string[] memory);

        function setLandsToSellId(string[] memory lands) external;

        function getLandsToSellPrice() external view returns(uint256[] memory);

        function setLandsToSellPrice(uint256[] memory lands) external;

        function removeLandFromSellList(string memory land) external;

    //


    // ========== Permits

        function getPermitOwner(string calldata PermitId) external view returns(address);

        function setPermitOwner(string calldata PermitId, address adr) external;
        
        function getPermitType(string calldata PermitId) external view returns(uint256);

        function setPermitType(string calldata PermitId, uint256 permitType) external ;

        function getPermitsLandType(string calldata PermitId) external view returns(uint256);

        function setPermitsLandType(string calldata PermitId, uint256 landType) external ;

        function getNumberOfPermits(address adr) external view returns(uint256);

        function setNumberOfPermits(address adr, uint256 number) external;

        function getAddressPermits(address adr) external view returns(string[] memory);

        function setAddressPermits(address adr, string[] calldata Permits) external ;

        function getPermitUsed(string calldata landId) external view returns(bool);

        function setPermitUsed(string calldata landId, bool state) external;

        function getAllPermits() external view returns(string[] memory);

        function setAllPermits(string[] memory Permits) external ;

        function getAllPermitsTypes() external view returns(uint256[] memory);

        function setAllPermitsTypes(uint256[] memory PermitsTypes) external;

        function getNumberOfAllPermits() external view returns(uint256);

        function setNumberOfAllPermits(uint256 number) external;

        function getPermitsToSellId() external view returns(string[] memory);

        function setPermitsToSellId(string[] memory Permits) external;

        function getPermitsToSellPrice() external view returns(string[] memory);

        function setPermitsToSellPrice(string[] memory Permits) external;
    //

    // ========== Buildings

        function getAllBuildings() external view returns(string[] memory);

        function setAllBuildings(string[] memory Buildings) external;

        function getAllBuildingsTypes() external view returns(uint256[] memory);

        function setAllBuildingsTypes(uint256[] memory BuildingsTypes) external;

        function getNumberOfAllBuildings() external view returns(uint256);

        function setNumberOfAllBuildings(uint256 number) external;

        function getBuildingOwner(string calldata BuildingId) external view returns(address);

        function setBuildingOwner(string calldata BuildingId, address adr) external;

        function getAddressBuildings(address adr) external view returns(string[] memory);

        function setAddressBuildings(address adr, string[] memory Buildings) external;

        function getNumberOfBuildings(address adr) external view returns(uint256);

        function setNumberOfBuildings(address adr, uint256 number) external;        
            
        function getBuildingType(string calldata BuildingId) external view returns(uint256);

        function setBuildingType(string calldata BuildingId, uint256 BuildingType) external;
    //
}
*/

