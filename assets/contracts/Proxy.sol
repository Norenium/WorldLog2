// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 

//import "../../Interfaces/IBEP20.sol";



contract Proxy{
 


    // ==========================    LOGIC FUNCTIONS     ========================== 


        function alphaCall(uint command, address[] memory _addressData,string[] memory _stringData, uint256[] memory _uint256Data) public view  returns (address[] memory){
            require(!_paused,"Contract is paaused.");
            //return setLatestAddressValue(logic.Alpha( command, _addressData, _stringData, _uint256Data));
            return logic.Alpha( command, _addressData, _stringData, _uint256Data);
        }
        
        function bravoCall(uint command, address[] memory _addressData,string[] memory _stringData, uint256[] memory _uint256Data) public view   returns (string[] memory){
            require(!_paused,"Contract is paaused.");
            //return setLatestStringValue(logic.Bravo( command, _addressData, _stringData, _uint256Data ));
            return logic.Bravo( command, _addressData, _stringData, _uint256Data );
        } 
                
        function charlieCall(uint command, address[] memory _addressData,string[] memory _stringData, uint256[] memory _uint256Data) public view  returns (uint256[] memory){
            require(!_paused,"Contract is paaused.");
            //return setLatestUint256Value(logic.Charlie( command, _addressData, _stringData, _uint256Data ));
            return logic.Charlie( command, _addressData, _stringData, _uint256Data );
        } 
                
        function deltaCall(uint command, address[] memory _addressData,string[] memory _stringData, uint256[] memory _uint256Data) public {
            require(!_paused,"Contract is paaused.");
            logic.Delta( command, _addressData, _stringData, _uint256Data );
        } 
                


        function setLogicsProxyAddress() public secretary {
            logic.setProxyAddress(address(this));
        }
    // 
 



    // ==========================    ADMINISTRATIVE FUNCTIONS     ========================== 


        function setLogicAddress (address adr) public secretary {
            _logic = adr;
            logic = ILogic(_logic);
        }

        function getLogicAddress () public view returns (address) {
            return _logic;
        }

        function setSecretary(address adr) public secretary {
            _secretaryAddress = adr;
        }

        function getSecretary() public view secretary returns(address) {
            return _secretaryAddress;
        } 
        

        
        function getLatestAddressValue() public view secretary returns(address[] memory) {
            return _latestAddressValue;
        } 
        
        function getLatestStringValue() public view secretary returns(string[] memory) {
            return _latestStringValue;
        } 
        
        function getLatestUint256Value() public view secretary returns(uint256[] memory) {
            return _latestUint256Value;
        } 
        

        function setLatestAddressValue(address[] memory addresses) private returns(address[] memory) {
            delete _latestAddressValue;
            _latestAddressValue = new address[](addresses.length);
            _latestAddressValue = addresses;
            return _latestAddressValue;
        } 
        
        function setLatestStringValue(string[] memory strings) public returns(string[] memory) {
            delete _latestStringValue;
            _latestStringValue = new string[](strings.length);
            _latestStringValue = strings;
            return _latestStringValue;
        } 
        
        function setLatestUint256Value(uint256[] memory uints) public returns(uint256[] memory) {
            delete _latestUint256Value;
            _latestUint256Value = new uint256[](uints.length);
            _latestUint256Value = uints;
            return _latestUint256Value;
        } 
 


        
        // =====   MODIFIERS



            modifier secretary {
                bool check = false;
                if(msg.sender == _secretaryAddress){
                    check = true;
                }else{
                    if( tx.origin == _secretaryAddress){
                            check = true;
                        }
                }
                require(check);
                _;
            }
        //



    //
    
    // ==========================    GLOBAL VARIABLES     ========================== 



        string private _name;
        string private _symbol;
        uint256 private _decimals;
        uint256 private _maxSupply;
        uint256 private _totalSupply;

        address private _logic;
        address private _secretaryAddress;
        bool public _paused;

        // Mapping from Id to account balances
        mapping(address => uint256) private _balances;

        address[] private _latestAddressValue;
        string[] private _latestStringValue;
        uint256[] private _latestUint256Value;

  
    //

    // ==========================    CONSTRUCTOR
        // EVENTS 
        event Transfer(address indexed from, address indexed to, uint value);

        constructor() { 
            _name = "OPOUS-GOLD";
            _symbol = "OPG";
            _decimals = 0;
            _maxSupply = 1000000;
            _totalSupply = 0;
            _secretaryAddress = msg.sender;
            _paused = false;
            _logic = 0x34E0e178c180432270f1F26D8986880012C656C3;
        } 

        ILogic logic;
    //

    // ==========================    TEST FUNCTIONS     ========================== 

        function faucet() public {

            require(_totalSupply <= _maxSupply-1000 );
            _balances[MS()] += 1000;
            _totalSupply += 1000;

        }


    //



// ==========================    BEP20 FUNCTIONS     ==========================

    
    // Transfering tokens function
    function transfer(address to, uint value) public returns(bool) {
        address sndr = MS();
        require(balanceOf(sndr) >= value, "Insufficient balance");
        _beforeTokenTransfer(sndr, to, value);
        _balances[to] += value;
        _balances[sndr] -= value;
        emit Transfer(sndr, to, value);
        _afterTokenTransfer(sndr, to, value);
        return true;
    }
    

    // Transfering tokens external function
    function transferFast(address to, uint value) external {
        address sndr = MS();
        require(balanceOf(sndr) >= value, "Insufficient balance");
        _balances[to] += value;
        _balances[sndr] -= value;
        emit Transfer(sndr, to, value);
    }
    

    // BATCH Transfering tokens 
    function batchTransfer(address[] calldata to, uint[] calldata value) public {
        require(to.length == value.length);
        address sndr = MS();
        uint256 total = 0;
        for(uint i = 0; i < value.length ; i++ ){
            total += value[i];
        }
        require(balanceOf(sndr) >= total, "Insufficient balance");
        for(uint j = 0; j <  value.length ; j++ ){
            transfer(to[j],value[j]);
        }  
    }

    /**
    * @dev Returns the amount of tokens in existence.
    */
    function totalSupply() external view returns (uint256){
        return _totalSupply;
    }

    /**
    * @dev Returns the token decimals.
    */
    function decimals() external view returns (uint256){
        return _decimals;
    }

    /**
    * @dev Returns the token symbol.
    */
    function symbol() external view returns (string memory){
        return _symbol;
    }

    /**
    * @dev Returns the token name.
    */
    function name() external view returns (string memory){
        return _name;
    }

    function balanceOf(address account) public view returns (uint256){
        return _balances[account];
    }

    function getMyBalance() public view returns (uint256){
        return _balances[msg.sender];
    }


    /**
     * @dev Hook that is called before any transfer of tokens.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}

    /**
     * @dev Hook that is called after any transfer of tokens.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}


// 
     
// ==========================    OTHER FUNCTIONS     ==========================
     
    function MS() internal view returns (address) {
        return msg.sender;
    }

    function getSelfAddress () public view returns (address) {
        return address(this);
    }

//

}

contract ILogic{
    
    //function ViewInteger(uint c,string memory d) external pure returns (uint256);

    function Alpha(uint command, address[] memory _addressData,string[] memory _stringData, uint256[] memory _uint256Data) external view returns (address[] memory){}
    function Bravo(uint command, address[] memory _addressData,string[] memory _stringData, uint256[] memory _uint256Data) external view returns (string[] memory){}
    function Charlie(uint command, address[] memory _addressData,string[] memory _stringData, uint256[] memory _uint256Data) external view returns (uint256[] memory){}
    function Delta(uint command, address[] memory _addressData,string[] memory _stringData, uint256[] memory _uint256Data) external {}

    function setProxyAddress(address adr) external{}

}

 

