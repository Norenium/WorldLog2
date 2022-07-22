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


        enum PermitType{
            HuntingCamp,    // 0 HC 
            WheatFarm,      // 1 WF 
            Grinder,        // 2 GD 
            Bakeshop,       // 3 BS 
            WindMill,       // 4 WM 
            House           // 5 HS 
            
        //}
        
    //*/
contract PermitsStorage{

    // ================ STORAGE

        // permitId is a string unique identifier like: AS21-HC01 which is a combination of the lnadId
        // and the permitId. (eg: AS21-HC01 is a hunting camp which builded on the AS21 land)

        // All permits (by id)
        string[] allPermits;        uint256 permitNumerator=101;

        // All permits (by type) in the same order of the allPermits;
        uint256[] allPermitsTypes;
        
        // Mapping from permitId to owner address
        mapping(string => address) private _permitOwner;

        // Mapping owner address to permits by id
        mapping(address => string[]) private _addressPermits;

        // Mapping permitId to permitType
        mapping(string => uint256) private _permitType;

        // Mapping permitId to a land Type which permit can be used in
        mapping(string => uint256) private _permitLandType;
                                
        // Mapping from permitId to its use state
        mapping(string => bool) private _permitUsed;

                // sell data
        // spt => Sell Permit Ticket
        uint256[][] sptAll;
        uint256 sptIdIndex = 0;             // Unique

    //

    // ================ Remove Methods ONLY FOR DEVELOPMENT PHASE

        function removePermitFromAllPermitsAndTypes(string calldata pId) public {

            require(isPermitIdExist(pId),"not existed");
            uint num = allPermits.length;
            require(num>0,"No permits");
            require(num==allPermitsTypes.length,"Not Match indexes");
        
            string[] memory tempAllPermitsIds = allPermits;
            uint256[] memory tempAllPermitsTypes = allPermitsTypes;
            delete allPermits;
            delete allPermitsTypes;
            allPermits = new string[](0);
            allPermitsTypes = new uint256[](0);

            for(uint i=0; i<num; i++){
                if(!compareStrings(tempAllPermitsIds[i],pId)){
                    allPermits.push(tempAllPermitsIds[i]);
                    allPermitsTypes.push(tempAllPermitsTypes[i]);
                }
            }

        }

        function removeFromAllPermitsByIndex(uint256 index)public{
            uint num = allPermits.length;
            require(index <= num,"invalid index");

            string[] memory tempAllPermitsIds = allPermits;
            delete allPermits;
            allPermits = new string[](0);

            for(uint i=0; i<num; i++){
                if(i!=index){
                    allPermits.push(tempAllPermitsIds[i]);
                }
            }

        }

        function removeFromAllPermitsTypeByIndex(uint256 index)public{
            uint num = allPermitsTypes.length;
            require(index <= num,"invalid index");

            uint256[] memory tempAllPermitsTypes = allPermitsTypes;
            delete allPermitsTypes;
            allPermitsTypes = new uint256[](0);

            for(uint i=0; i<num; i++){
                if(i!=index){
                    allPermitsTypes.push(tempAllPermitsTypes[i]);
                }
            }

        }

        function isPermitIdExist(string calldata pId) public view returns(bool){

            for(uint i=0; i<allPermits.length; i++){

                if(compareStrings(allPermits[i],pId)){
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
        string[] tpIds = ["Pr0","Pr1","Pr2","Pr3","Pr4","Pr5","Pr6","Pr7","Pr8","Pr9"];
        uint256[] tpTypes = [0,0,0,1,1,2,1,1,0,0];
        uint256[] tpLandTypes = [10,10,10,11,11,12,11,11,10,10];
        function batchBuildTest() public  {

            address to = 0x87B64804e36f20acA9052D3b4Cd7188D41b59f97;
            for(uint i=0; i<10; i++){
                addPermit(to, tpIds[i],tpTypes[i],tpLandTypes[i]);
            }
        }

        function issueNewPermit(address adr, uint256 permitType, uint256 landType) public {
            
            string memory typeStr;
            if(permitType == 0){typeStr = "HC";}
            if(permitType == 1){typeStr = "WF";}
            if(permitType == 2){typeStr = "GD";}
            if(permitType == 3){typeStr = "BS";}
            if(permitType == 4){typeStr = "WM";}
            if(permitType == 5){typeStr = "HS";}

            string memory permitId = append(typeStr,uint2str(permitNumerator));
            permitNumerator++;
            addPermit(adr, permitId, permitType, landType);

        }

        function addPermit(address adr, string memory permitId, uint256 permitType, uint256 landType) public {
            require(allPermits.length == allPermitsTypes.length, "Number of all permits != number of allPermitsTypes");
            allPermits.push(permitId);
            allPermitsTypes.push(permitType);
            _permitOwner[permitId] = adr;
            _addressPermits[adr].push(permitId);
            _permitType[permitId] = permitType;
            _permitLandType[permitId] = landType;
            _permitUsed[permitId] = false;
        }

        /*
        function transferPermitOwnership(address to, string calldata permitId) public {
            require(isPermitIdExist(permitId),"not existed");

            address formerOwner = _permitOwner[permitId];
            require(to != formerOwner,"Destination is owner");
            removePermitFromAddress(formerOwner, permitId);

            _permitOwner[permitId] = to;
            _addressPermits[to].push(permitId);
        }

        function removePermitFromAddress(address adr, string memory permitId) public {
            uint num = _addressPermits[adr].length;
            string[] memory tempB = _addressPermits[adr];
            delete  _addressPermits[adr];
            _addressPermits[adr] = new string[](0);
            
            if(num>1){
                                //_addressPermits[adr] = new string[](0);

                for(uint i=0; i < num; i++){

                    if(!compareStrings(tempB[i],permitId)){
                        _addressPermits[adr].push(tempB[i]);
                    }
                }
            }
        }
        */



    //

    // ================ Get Methods
        
        function getAllPermits() public view returns(string[] memory){
            return allPermits;
        }

        function getNumberOfAllPermits() public view returns(uint256){
            return allPermits.length;
        }

        function getAddressPermits(address adr) public view returns(string[] memory){
            return _addressPermits[adr];
        }

        function getNumberOfAddressPermits(address adr) public view returns(uint256){
            return _addressPermits[adr].length;
        }

        function getAllPermitsTypes() public view returns(uint256[] memory){
            return allPermitsTypes;
        }

        function getPermitOwner(string calldata permitId) public view returns(address){
            return _permitOwner[permitId];
        }

        function getPermitType(string calldata permitId) public view returns(uint256){
            return _permitType[permitId];
        }

        function getPermitLandType(string calldata permitId) public view returns(uint256){
            return _permitLandType[permitId];
        }

        function getPermitUsed(string calldata permitId) public view returns(bool){
            return _permitUsed[permitId];
        }

        function getPermitNumerator() public view returns(uint256){
            return permitNumerator;
        }

    //

    // ================ Set Methods ONLY FOR DEVELOPMENT PHASE

        function pushToAllPermits(string memory pId) public {
            allPermits.push(pId);
        }

        function pushToAllPermitsTypes(uint256 pType) public {
            allPermitsTypes.push(pType);
        }

        function setAllPermits(string[] memory pIds) public {
            allPermits = pIds;
        }

        function setAllPermitsTypes(uint256[] memory pTypes) public {
            allPermitsTypes = pTypes;
        }

        function setPermitOwner(address adr, string calldata pId) public {
            _permitOwner[pId] = adr;
        }

        function setAddressPermits(address adr, string[] memory pIds ) public {
            _addressPermits[adr] = pIds;
        }

        function addToAddressPermits(address adr, string memory pId) public {
            _addressPermits[adr].push(pId);
        }

        function setPermitType(string calldata pId, uint256  pType) public {
            _permitType[pId] = pType;
        }

        function setPermitLandType(string calldata pId, uint256  bLType) public {
            _permitLandType[pId] = bLType;
        }


        // remains at production
        function setPermitUsed(string calldata pId, bool  isUsed) public {
            require(isPermitIdExist(pId),"not existed");
            _permitUsed[pId] = isUsed;
        }



    //

    // ==================== LATHERAL ====================
        function compareStrings(string memory a, string memory b) public pure returns (bool) {
            return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
        }
    
        function append(string memory a, string memory b) internal pure returns (string memory) {
            return string(abi.encodePacked( a, "-", b));
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
