// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 

contract LandsAgent{

    // ========== Read Methods

        function getAllLands() public view returns(string[] memory) {
            return PS.getAllLands();
        }

        function getAllLandsTypes() public view returns(uint256[] memory){
            return PS.getAllLandsTypes();
        }

        function getLandOwner(string memory pId) public view returns(address adr){
            return PS.getLandOwner(pId);
        }

        function getAddressLands(address adr) public view returns(string[] memory){
            return PS.getAddressLands(adr);
        }

        function getLandType(string memory pId) public view returns(uint256){
            return PS.getLandType(pId);
        }

    //

    // ========== Write Methods

        function mintLand(address pOwner, string memory pId, uint256 bType, uint256 lType) public {
            PS.addLand(pOwner,  pId,  bType, lType);
        }

    //


    // ========== Storage Contract

        address LSA;
        LandsStorage PS;

        function setLandsStorage(address adr) public {
            LSA = adr;
            PS = LandsStorage(adr);
        }

        function getLSA() public view returns(address){
            return LSA;
        }

    //
}

interface LandsStorage{
    
    // Write
    function addLand(address adr, string memory LandId, uint256 LandType, uint256 landType) external;



    //Read
    function getAllLands() external view returns(string[] memory);

    function getAddressLands(address adr) external view returns(string[] memory);

    function getAllLandsTypes() external view returns(uint256[] memory);
    
    function getLandOwner(string calldata LandId) external view returns(address);
    
    function getLandType(string calldata LandId) external view returns(uint256);


}