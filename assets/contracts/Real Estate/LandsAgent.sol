// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 

contract LandsAgent{

    // ========== Read Methods

        function getLandsAgentavailable() public pure returns(bool){
            return true;
        }

        function getAllLands() public view returns(string[] memory) {
            return LS.getAllLands();
        }

        function getAllLandsTypes() public view returns(uint256[] memory){
            return LS.getAllLandsTypes();
        }

        function getLandOwner(string calldata land) public view returns(address){
            return LS.getLandOwner(land);
        }

        function getAddressLands(address adr) public view returns(string[] memory){
            return LS.getAddressLands(adr);
        }

        function getLandType(string calldata lId) public view returns(uint256){
            return LS.getLandType(lId);
        }

        function getIsLandExist(string calldata lId) public view returns(bool){
            return LS.isLandExist(lId);
        }

        function getSellLandList() public view returns (string[] memory){
            return LS.getAllSellTickets();
        }

        function getIsTicketExist(string calldata lId) public view returns(bool){
            return LS.isTicketExist(lId);
        }

        function  getLandHasBuilding(string calldata lId) public view returns(bool){
            return LS.getLandHasBuilding(lId);
        }



    //

    // ========== Write Methods

        function mintLand(address pOwner, string memory lId, uint256 bType, uint256 lType) public {
            LS.addLand(pOwner,  lId,  bType, lType);
        }

        function listLandToSell(string memory landId, uint256 price) public {
            address owner = LS.getLandOwner(landId);
            require(tx.origin == owner, "Not Yours");
            string memory ticket = append(landId, uint2str(price));
            LS.addToSellTickets(ticket);
        }

        function signLandToBuyer(address buyer, string calldata landId, string calldata ticket) public {
            LS.transferLandOwnership(buyer,landId);
            LS.removeSellTicket(ticket);
        }

        function unlistLand(string calldata ticket) public {
            require(LS.isTicketExist(ticket),"Ticket not existed");
            LS.removeSellTicket(ticket);
        }


    //

    // ========== Storage Contract

        address LSA;
        ILandsStorage LS;

        function setILandsStorage(address adr) public {
            LSA = adr;
            LS = ILandsStorage(adr);
        }

        function getLSA() public view returns(address){
            return LSA;
        }

    //

    //========== LATHERAL

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

interface ILandsStorage{
    
    // Write
    function addLand(address adr, string memory LandId, uint256 LandType, uint256 landType) external;

    function transferLandOwnership(address to, string calldata lId) external;

    function addToSellTickets(string memory sellTicket) external;

    function removeSellTicket(string memory ticket) external;

    //Read
    function getAllLands() external view returns(string[] memory);

    function getAddressLands(address adr) external view returns(string[] memory);

    function getAllLandsTypes() external view returns(uint256[] memory);
    
    function getLandOwner(string calldata landId) external view returns(address);
    
    function getLandType(string calldata LandId) external view returns(uint256);

    function getAllSellTickets() external view returns (string[] memory);

    function isLandExist(string calldata landId) external view returns(bool);

    function isTicketExist(string calldata ticket) external view returns(bool);

    function getLandHasBuilding(string calldata landId) external view returns(bool);

}