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

        function getPermitUsed(string memory pId) public view returns(bool){
            return PS.getPermitUsed(pId);
        }

        

    //

    // ========== Write Methods

        function issuePermit(address pOwner, uint256 pType, uint256 lType) public {
            PS.issueNewPermit(pOwner, pType, lType);
        }

        function usePermit(string calldata PermitId) public {
            PS.setPermitUsed(PermitId, true);
        }
    //


    // ========== Storage Contract

        address PSA;
        IPermitsStorage PS;

        function setPermitsStorage(address adr) public {
            PSA = adr;
            PS = IPermitsStorage(adr);
        }

        function getPSA() public view returns(address){
            return PSA;
        }

    //
}

interface IPermitsStorage{
    
    // Write
    function addPermit(address adr, string memory permitId, uint256 permitType, uint256 landType) external;

    function setPermitUsed(string calldata pId, bool  isUsed) external;

    function issueNewPermit(address adr, uint256 permitType, uint256 landType) external;


    //Read
    function getAllPermits() external view returns(string[] memory);

    function getAddressPermits(address adr) external view returns(string[] memory);

    function getAllPermitsTypes() external view returns(uint256[] memory);
    
    function getPermitOwner(string calldata PermitId) external view returns(address);
    
    function getPermitType(string calldata PermitId) external view returns(uint256);

    function getPermitUsed(string calldata permitId) external view returns(bool);
    


}