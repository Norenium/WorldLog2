// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 

    
    // TYPES CODE CONVENTION 
        /*
        enum LandType{
            Forest,             // 0
            Empty,              // 1
            Mountain,           // 2
            Agricultural,       // 3
            Urban,              // 4
            Coast               // 5
        }


        enum BuildingType{
            HuntingCamp,    // 0 HC 
            WheatFarm,      // 1 WF 
            Grinder,        // 2 GD 
            Bakeshop,       // 3 BS 
            WindMill,       // 4 WM 
            House           // 5 HS 
            
        //}
        
    //*/
contract BuildingsStorage{

    // ================ STORAGE

        // buildingId is a string unique identifier like: AS21-HC01 which is a combination of the lnadId
        // and the permitId. (eg: AS21-HC01 is a hunting camp which builded on the AS21 land)

        // All buildings (by id)
        string[] allBuildings;

        // All buildings (by type) in the same order of the allBuildings;
        uint256[] allBuildingsTypes;
        
        // Mapping from buildingId to owner address
        mapping(string => address) private _buildingOwner;

        // Mapping owner address to buildings by id
        mapping(address => string[]) private _addressBuildings;

        // Mapping buildingId to buildingType
        mapping(string => uint256) private _buildingType;

    //

    // ================ Remove Methods ONLY FOR DEVELOPMENT PHASE

        function removeBuildingFromAllBuildingsAndTypes(string calldata bId) public {

            require(isBuildingIdExist(bId),"not existed");
            uint num = allBuildings.length;
            require(num>0,"No buildings");
            require(num==allBuildingsTypes.length,"Not Match indexes");
        
            string[] memory tempAllBuildingsIds = allBuildings;
            uint256[] memory tempAllBuildingsTypes = allBuildingsTypes;
            delete allBuildings;
            delete allBuildingsTypes;
            allBuildings = new string[](0);
            allBuildingsTypes = new uint256[](0);

            for(uint i=0; i<num; i++){
                if(!compareStrings(tempAllBuildingsIds[i],bId)){
                    allBuildings.push(tempAllBuildingsIds[i]);
                    allBuildingsTypes.push(tempAllBuildingsTypes[i]);
                }
            }

        }

        function removeFromAllBuildingsByIndex(uint256 index)public{
            uint num = allBuildings.length;
            require(index <= num,"invalid index");

            string[] memory tempAllBuildingsIds = allBuildings;
            delete allBuildings;
            allBuildings = new string[](0);

            for(uint i=0; i<num; i++){
                if(i!=index){
                    allBuildings.push(tempAllBuildingsIds[i]);
                }
            }

        }

        function removeFromAllBuildingsTypeByIndex(uint256 index)public{
            uint num = allBuildingsTypes.length;
            require(index <= num,"invalid index");

            uint256[] memory tempAllBuildingsTypes = allBuildingsTypes;
            delete allBuildingsTypes;
            allBuildingsTypes = new uint256[](0);

            for(uint i=0; i<num; i++){
                if(i!=index){
                    allBuildingsTypes.push(tempAllBuildingsTypes[i]);
                }
            }

        }

        function isBuildingIdExist(string calldata bId) public view returns(bool){

            for(uint i=0; i<allBuildings.length; i++){

                if(compareStrings(allBuildings[i],bId)){
                    return true;
                }

            }
            return false;
        }


    //

    // ================ Mixed Methods

        // ONLY FOR DEVELOPMENT PHASE
        // ["B0","B1","B2","B3","B4","B5","B6","B7","B8","B9"]
        // [0,0,0,1,1,2,1,1,0,0]
        string[] tbIds = ["B0","B1","B2","B3","B4","B5","B6","B7","B8","B9"];
        uint256[] tbTypes = [0,0,0,1,1,2,1,1,0,0];
        function batchBuildTest() public  {

            address to = 0x87B64804e36f20acA9052D3b4Cd7188D41b59f97;
            for(uint i=0; i<10; i++){
                addBuilding(to, tbIds[i],tbTypes[i]);
            }
        }

        function addBuilding(address adr, string memory buildingId, uint256 buildingType) public {
            require(allBuildings.length == allBuildingsTypes.length, "Number of all buildings != number of allBuildingsTypes");
            allBuildings.push(buildingId);
            allBuildingsTypes.push(buildingType);
            _buildingOwner[buildingId] = adr;
            _addressBuildings[adr].push(buildingId);
            _buildingType[buildingId] = buildingType;
        }

        function transferBuildingOwnership(address to, string calldata buildingId) public {
            require(isBuildingIdExist(buildingId),"not existed");

            address formerOwner = _buildingOwner[buildingId];
            require(to != formerOwner,"Destination is owner");
            removeBuildingFromAddress(formerOwner, buildingId);

            _buildingOwner[buildingId] = to;
            _addressBuildings[to].push(buildingId);
        }

        function removeBuildingFromAddress(address adr, string memory buildingId) public {
            uint num = _addressBuildings[adr].length;
            string[] memory tempB = _addressBuildings[adr];
            delete  _addressBuildings[adr];
            _addressBuildings[adr] = new string[](0);
            
            if(num>1){
                                //_addressBuildings[adr] = new string[](0);

                for(uint i=0; i < num; i++){

                    if(!compareStrings(tempB[i],buildingId)){
                        _addressBuildings[adr].push(tempB[i]);
                    }
                }
            }
        }




    //

    // ================ Get Methods
        
        function getAllBuildings() public view returns(string[] memory){
            return allBuildings;
        }

        function getNumberOfAllBuildings() public view returns(uint256){
            return allBuildings.length;
        }

        function getAddressBuildings(address adr) public view returns(string[] memory){
            return _addressBuildings[adr];
        }

        function getNumberOfAddressBuildings(address adr) public view returns(uint256){
            return _addressBuildings[adr].length;
        }

        function getAllBuildingsTypes() public view returns(uint256[] memory){
            return allBuildingsTypes;
        }

        function getBuildingOwner(string calldata buildingId) public view returns(address){
            return _buildingOwner[buildingId];
        }

        function getBuildingType(string calldata buildingId) public view returns(uint256){
            return _buildingType[buildingId];
        }

    //

    // ================ Set Methods ONLY FOR DEVELOPMENT PHASE

        function pushToAllBuildings(string memory bId) public {
            allBuildings.push(bId);
        }

        function pushToAllBuildingsTypes(uint256 bType) public {
            allBuildingsTypes.push(bType);
        }

        function setAllBuildings(string[] memory bIds) public {
            allBuildings = bIds;
        }

        function setAllBuildingsTypes(uint256[] memory bTypes) public {
            allBuildingsTypes = bTypes;
        }

        function setBuildingOwner(address adr, string calldata bId) public {
            require(isBuildingIdExist(bId),"not existed");
            _buildingOwner[bId] = adr;
        }

        function setAddressBuildings(address adr, string[] memory bIds ) public {
            _addressBuildings[adr] = bIds;
        }

        function addToAddressBuildings(address adr, string memory bId) public {
            _addressBuildings[adr].push(bId);
        }

        function setBuildingType(string calldata bId, uint256  bType) public {
            _buildingType[bId] = bType;
        }



    //

    // ==================== LATHERAL ====================
        function compareStrings(string memory a, string memory b) public pure returns (bool) {
            return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
        }
    //
}
