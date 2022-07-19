// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 

contract PermitsAgent{

    // ========== Read Methods

        function getAllPermits() public view returns(string[] memory) {
            return PS.getAllPermits();
        }

        function getAllPermitsTypes() public view returns(uint256[] memory){
            return PS.getAllPermitsTypes();
        }

        function getPermitOwner(string memory pId) public view returns(address adr){
            return PS.getPermitOwner(pId);
        }

        function getAddressPermits(address adr) public view returns(string[] memory){
            return PS.getAddressPermits(adr);
        }

        function getPermitType(string memory pId) public view returns(uint256){
            return PS.getPermitType(pId);
        }

    //

    // ========== Write Methods

        function issuePermit(address pOwner, string memory pId, uint256 bType, uint256 lType) public {
            PS.addPermit(pOwner,  pId,  bType, lType);
        }

        function usePermit(string calldata PermitId) public {
            PS.setPermitUsed(PermitId, true);
        }
    //


    // ========== Storage Contract

        address PSA;
        PermitsStorage PS;

        function setPermitsStorage(address adr) public {
            PSA = adr;
            PS = PermitsStorage(adr);
        }

        function getPSA() public view returns(address){
            return PSA;
        }

    //
}

interface PermitsStorage{
    
    // Write
    function addPermit(address adr, string memory permitId, uint256 permitType, uint256 landType) external;

    function setPermitUsed(string calldata pId, bool  isUsed) external;


    //Read
    function getAllPermits() external view returns(string[] memory);

    function getAddressPermits(address adr) external view returns(string[] memory);

    function getAllPermitsTypes() external view returns(uint256[] memory);
    
    function getPermitOwner(string calldata PermitId) external view returns(address);
    
    function getPermitType(string calldata PermitId) external view returns(uint256);


}