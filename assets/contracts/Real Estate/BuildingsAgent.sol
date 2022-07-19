// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 

contract BuildingsAgent{

    // ========== Read Methods

        function getAllBuildings() public view returns(string[] memory) {
            return BS.getAllBuildings();
        }

        function getAllBuildingsTypes() public view returns(uint256[] memory){
            return BS.getAllBuildingsTypes();
        }

        function getBuildingOwner(string memory bId) public view returns(address adr){
            return BS.getBuildingOwner(bId);
        }

        function getAddressBuildings(address adr) public view returns(string[] memory){
            return BS.getAddressBuildings(adr);
        }

        function getBuildingType(string memory bId) public view returns(uint256){
            return BS.getBuildingType(bId);
        }

    //

    // ========== Write Methods

        function buildBuilding(address bOwner, string memory bId, uint256 bType) public {
            BS.addBuilding(bOwner,  bId,  bType);
        }

        function transferBuildingOwnership(address to, string calldata buildingId) public {
            BS.transferBuildingOwnership( to,  buildingId);
        }
    //


    // ========== Storage Contract

        address BSA;
        BuildingsStorage BS;

        function setBuildingsStorage(address adr) public {
            BSA = adr;
            BS = BuildingsStorage(adr);
        }

        function getBSA() public view returns(address){
            return BSA;
        }

    //
}

interface BuildingsStorage{
    
    // Write
    function addBuilding(address adr, string memory buildingId, uint256 buildingType) external;

    function transferBuildingOwnership(address to, string calldata buildingId) external;

    //Read
    function getAllBuildings() external view returns(string[] memory);

    function getAddressBuildings(address adr) external view returns(string[] memory);

    function getAllBuildingsTypes() external view returns(uint256[] memory);
    
    function getBuildingOwner(string calldata buildingId) external view returns(address);
    
    function getBuildingType(string calldata buildingId) external view returns(uint256);

}