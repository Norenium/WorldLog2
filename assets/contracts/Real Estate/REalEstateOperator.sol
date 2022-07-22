// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 

contract RealEstateOperator{

    // restrictional variables

        uint256 minLandPrice = 50;
        uint256 maxLandPrice = 2000;

        function setRestrictions(uint256[] memory restList) public {
            minLandPrice = restList[0];
            maxLandPrice = restList[1];
        }

        function getRestrictions() public view returns(uint256[] memory) {
            uint256[] memory restList;
            restList[0] = minLandPrice;
            restList[1] = maxLandPrice;
            return restList;
        }


    //


    // Lands 
        // ========== Read Methods

            function getAllLands() public view returns(string[] memory) {
                return LA.getAllLands();
            }

            function getAllLandsTypes() public view returns(uint256[] memory){
                return LA.getAllLandsTypes();
            }

            function getLandOwner(string memory pId) public view returns(address adr){
                return LA.getLandOwner(pId);
            }

            function getAddressLands(address adr) public view returns(string[] memory){
                return LA.getAddressLands(adr);
            }

            function getLandType(string memory pId) public view returns(uint256){
                return LA.getLandType(pId);
            }

            function getSellLandList() public view returns (string[] memory){
                return LA.getSellLandList();
            }

        //
    

    
        // ========== Write Methods

            function listLandToSell(string calldata lId, uint256 price) public {
                require(price >= minLandPrice,"too low price");
                require(price <= maxLandPrice,"too high price");
                require(LA.getIsLandExist(lId),"Not Exist");
                LA.listLandToSell(lId,price);
            }

            function cancelSell(string memory ticket) public {
                require(LA.getIsTicketExist(ticket),"Ticket not Exist");
                LA.unlistLand(ticket);            
            }

            function buyLand(string calldata ticket, uint256 price) public{
                require(LA.getIsTicketExist(ticket),"Ticket not Exist");
                uint256 tPrice = getTicketPrice(ticket);
                require(tPrice == price, "Price doesnt match");
                // do some validation about the buyer

                // Payment
                string memory lId = getTicketLandId(ticket);
                LA.signLandToBuyer(tx.origin,lId,ticket);
            }
        //
    //

    // Permits

        // Read
        function getMyPermits() public view returns(string[] memory){
            return PA.getAddressPermits(tx.origin);
        }

        // Write
        function issuePermit(uint256 permitType, uint256 landType) public {
            // do some validation about the user
            // Payment
            PA.issuePermit(tx.origin,permitType,landType);
        }
    //      

    // Buildings
        // ========== Read Methods

            function getAllBuildings() public view returns(string[] memory) {
                return BA.getAllBuildings();
            }

            function getAllBuildingsTypes() public view returns(uint256[] memory){
                return BA.getAllBuildingsTypes();
            }

            function getBuildingOwner(string memory bId) public view returns(address adr){
                return BA.getBuildingOwner(bId);
            }

            function getAddressBuildings(address adr) public view returns(string[] memory){
                return BA.getAddressBuildings(adr);
            }

            function getMyBuildings() public view returns(string[] memory){
                return BA.getAddressBuildings(tx.origin);
            }

            function getBuildingType(string memory bId) public view returns(uint256){
                return BA.getBuildingType(bId);
            }

        //

        // ========== Write Methods


        function buildBuilding(address bOwner, string memory lId, string memory pId, uint256 bType) public {
            
            require(!BA.getIsAvailable(),"Buildings contract is not available");
            require(!LA.getIsLandExist(lId),"Land Not Exist");
            require(!BA.getLandHasBuilding(lId),"Land has building");
            require(!PA.getPermitUsed(pId),"Permit is used");
            require(PA.getPermitOwner(pId) == bOwner,"Permit Not yours");

            // do some validation about the buyer
            string memory bId = append(lId, pId);
            // Payment

            BA.buildBuilding(bOwner,  bId,  bType);
            PA.usePermit(pId);

        }

        //

    //

    // ========== Storage Contracts

        address LAA;
        ILandsAgent LA;

        function setLandsAgent(address adr) public {
            LAA = adr;
            LA = ILandsAgent(adr);
        }

        function getLandsAgentAddress() public view returns(address){
            return LAA;
        }


        address PAA;
        IPermitsAgent PA;

        function setPermitAgent(address adr) public {
            PAA = adr;
            PA = IPermitsAgent(adr);
        }

        function getPermitAgentAddress() public view returns(address){
            return PAA;
        }


        address BAA;
        IBuildingsAgent BA;

        function setBuildingAgent(address adr) public {
            BAA = adr;
            BA = IBuildingsAgent(adr);
        }

        function getBuildingAgentAddress() public view returns(address){
            return BAA;
        }


        function setAllAddresses (address Lands, address Permits, address Buildings) public {
            setLandsAgent(Lands);
            setPermitAgent(Permits);
            setBuildingAgent(Buildings);
        }

    //

    
    // ========== LATHERAL
    
        //=== convertional internal methods
            
            function getTicketPrice(string memory str) public pure returns (uint256){ //delimiter can be any character that separates the integers 
                
                bytes memory b = bytes(str); //cast the string to bytes to iterate
                bytes memory delm = bytes("-"); 
                uint pos =0;

                string memory out = "";
                string memory cc = "";

                for(uint i; i<b.length ; i++){    

                    if((keccak256(abi.encodePacked((b[i]))) == keccak256(abi.encodePacked((delm))))) { //check if a not space
                        pos =i;           
                    }
                    else { 
                    

                        if( pos>0 ){
                            cc = string(abi.encodePacked((b[i])));
                            out = string(abi.encodePacked( out, cc));
                            
                        }
                                
                    }                
                }

                return strToUint(out);

            } 

                    
            function getTicketLandId(string memory str) public pure returns (string memory){ //delimiter can be any character that separates the integers 
                
                bytes memory b = bytes(str); //cast the string to bytes to iterate
                bytes memory delm = bytes("-"); 
                uint pos =0;

                string memory out = "";
                string memory cc = "";

                for(uint i; i<b.length ; i++){    

                    if((keccak256(abi.encodePacked((b[i]))) == keccak256(abi.encodePacked((delm))))) { //check if a not space
                        pos =i;           
                    }
                    else { 
                    

                        if( pos==0 ){
                            cc = string(abi.encodePacked((b[i])));
                            out = string(abi.encodePacked( out, cc));
                            
                        }
                                
                    }                
                }

                return out;

            }     
        //

        
    
        function append(string memory a, string memory b) internal pure returns (string memory) {
            return string(abi.encodePacked( a, "-", b));
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

interface ILandsAgent{
    
    // Read
    function getAllLands() external view returns(string[] memory);

    function getAllLandsTypes() external view returns(uint256[] memory);

    function getLandOwner(string memory pId) external view returns(address adr);

    function getAddressLands(address adr) external view returns(string[] memory);

    function getLandType(string memory pId) external view returns(uint256);

    function getSellLandList() external view returns (string[] memory);

    function getIsLandExist(string memory lId) external view returns(bool);

    function getIsTicketExist(string memory lId) external view returns(bool);


    // Write
    function mintLand(address pOwner, string memory pId, uint256 bType, uint256 lType) external;

    function listLandToSell(string memory landId, uint256 price) external;

    function unlistLand(string calldata ticket) external;

    function signLandToBuyer(address buyer, string calldata landId, string calldata ticket) external;
}

interface IPermitsAgent{


    // ========== Read Methods

        function getAllPermits() external view returns(string[] memory);

        function getAllPermitsTypes() external view returns(uint256[] memory);

        function getPermitOwner(string memory pId) external view returns(address adr);

        function getAddressPermits(address adr) external view returns(string[] memory);

        function getPermitType(string memory pId) external view returns(uint256);

        function getPermitUsed(string memory pId) external view returns(bool);

    //
    // ========== Read Methods

        function issuePermit(address pOwner, uint256 pType, uint256 lType) external ;

        function usePermit(string calldata PermitId) external ;

    //
}

interface IBuildingsAgent{


    // ========== Read Methods

        function getIsAvailable() external pure returns(bool);

        function getAllBuildings() external view returns(string[] memory);

        function getAllBuildingsTypes() external view returns(uint256[] memory);

        function getBuildingOwner(string memory bId) external view returns(address adr);

        function getAddressBuildings(address adr) external view returns(string[] memory);

        function getBuildingType(string memory bId) external view returns(uint256);

        function getLandHasBuilding(string calldata lId) external view returns(bool);


    //

    // ========== Write Methods

        function buildBuilding(address bOwner, string memory lId, uint256 bType) external ;

        function transferBuildingOwnership(address to, string calldata buildingId) external ;
    //
}

