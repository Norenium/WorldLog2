// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 

    // TODO:
    // add get set for food consts
    // add transfer opous money limmitations included.

contract TokenAgent{


    // ==================== ADMINISTRATION ====================

        // Other Contracts

            // Token Storage
            ITokensStorage TS;
            address TSAddress;

            constructor(){
                TS = ITokensStorage(0xEAc293617c30ECcC5eA3e49f78910eeb4C8e83Ba);
            }

            function getTokensStorageAddress() public view returns(address) {
                return TSAddress;
            }

            function setTokensStorageAddress(address adr) public {
                TSAddress = adr;
                TS = ITokensStorage(TSAddress);
            }

            // Lands Logic
            ILandsAgent LA;

            address LAAddress;

            function getLandsAgentAddress() public view returns(address) {
                return LAAddress;
            }

            function setLandsAgentAddress(address adr) public {
                LAAddress = adr;
                LA = ILandsAgent(LAAddress);
            }

            function setBothAddresses (address TokenStorageAdr, address LandAgentAde) public {
                TSAddress = TokenStorageAdr;
                TS = ITokensStorage(TSAddress);
                LAAddress = LandAgentAde;
                LA = ILandsAgent(LAAddress);
            }

            function isAvailable() public pure returns (bool){
                return true;
            }
        
        //

        // Logic variables
            uint256 huntPeriod = 180; // Increase it to 43200 Later
            uint256 huntRevenue = 1000; // Grams of Meat
            uint256 huntEnergyConsumption = 350; // Grams of Meat
        //


        // Get Set variavbles
            
            function getHuntPeriod() public view returns(uint256){
                return huntPeriod;
            }    

            function setHuntPeriod(uint256 value) public {
                huntPeriod = value;
            }

            function getHuntRevenue() public view returns(uint256){
                return huntRevenue;
            }    

            function setHuntRevenue(uint256 value) public {
                huntRevenue = value;
            }

            function getHuntEnergyConsumption() public view returns(uint256){
                return huntEnergyConsumption;
            }    

            function setHuntEnergyConsumption(uint256 value) public {
                huntEnergyConsumption = value;
            }
        //
    //
   


    // ==================== FOODS ENERGY Consts

        // Minimum To Eat
        uint256 minMeat = 20;
        uint256 minBread = 20;
        uint256 minMeatSandwich = 100;

        uint256 meatCalFor100g = 143;
        uint256 breadCalFor100g = 265;
        uint256 meatSandwichCalFor100g = 220;

        uint256 meatFatFor100g = 2;
        uint256 breadFatFor100g = 0;
        uint256 meatSandwichFatFor100g = 1;

        // Maximum to have
        uint256 maxBodyHealth = 100;
        uint256 maxBodyFat = 5000;
        uint256 maxBodyEnergy = 1000;
    //

    function start (string memory name) public {
        address to = tx.origin;
        require(TS.getPersonId(to) == 0 ,"adress is a person");
        uint256[] memory inp  = new uint256[](10);
        inp[0] = 1000;
        inp[1] = 0;
        inp[2] = 0;
        inp[3] = 0;
        inp[4] = 0;
        inp[5] = 0;
        inp[6] = 100;
        inp[7] = 700;
        inp[8] = 1000;
        inp[9] = block.timestamp;
        TS.setInventory(to, inp);

        uint256 PIN = TS.getPersonIdNumerator();
        TS.setPersonIdNumerator(PIN+1);
        TS.setPersonIdToAddress(PIN, to);
        TS.setPersonName(to, name);
        TS.setPersonId(to, PIN);
    }



    // ==================== ACTIONS
        // ==================== EAT

            function eatMeat(uint256 amount) public {
                address to = tx.origin;
                require( amount >= minMeat ); // minimum maet to eat
                uint256 meatB = TS.getMeatBalances(to);
                require( meatB >= amount);
                TS.setMeatBalances(to, meatB - amount);

                uint256 energyB = TS.getBodyEnergyBalances(to);
                uint256 newEnrg = energyB + ( amount * meatCalFor100g / 100);
                if( newEnrg > maxBodyEnergy){
                    TS.setBodyEnergyBalances(to, maxBodyEnergy);
                    // TODO add fat in case ov over eating
                }else{
                    TS.setBodyEnergyBalances(to, newEnrg);
                }

                uint256 fatB = TS.getBodyFatBalances(to);
                uint256 newFatB = fatB + ( amount * meatFatFor100g / 100);


                if( newFatB > maxBodyFat){
                    TS.setBodyFatBalances(to, maxBodyFat);
                }else{
                    TS.setBodyFatBalances(to, newFatB);
                }
            }

            function eatBread(uint256 amount) public {
                address to = tx.origin;
                require( amount >= minBread ); // minimum maet to eat(
                uint256 breadB = TS.getBreadBalances(to);
                require(breadB >= amount);

                uint256 newBreadB = breadB - amount;
                TS.setBreadBalances(to, newBreadB);

                uint256 energyB = TS.getBodyEnergyBalances(to);
                uint256 newEnrg = energyB + ( amount * meatCalFor100g / 100);

                if( newEnrg > maxBodyEnergy){
                    TS.setBodyEnergyBalances(to, maxBodyEnergy);
                    // TODO add fat in case ov over eating
                }else{
                    TS.setBodyEnergyBalances(to, newEnrg);
                }

                uint256 fatB = TS.getBodyFatBalances(to);
                uint256 newFatB = fatB + ( amount * meatFatFor100g / 100);


                if( newFatB > maxBodyFat){
                    TS.setBodyFatBalances(to, maxBodyFat);
                }else{
                    TS.setBodyFatBalances(to, newFatB);
                }

            }

            function eatSandwich(uint256 amount) public {
                address to = tx.origin;
                require( amount >= minMeatSandwich ); // minimum maet to eat

                uint256 meatB = TS.getMeatBalances(to);
                uint256 breadB = TS.getBreadBalances(to);

                require(meatB >= amount/2);
                require(breadB >= amount/2);

                TS.setMeatBalances(to, (meatB - amount/2));
                TS.setBreadBalances(to, (breadB - amount/2));





                uint256 energyB = TS.getBodyEnergyBalances(to);
                uint256 newEnrg = energyB + ( amount * meatSandwichCalFor100g / 100);

                if( newEnrg > maxBodyEnergy){
                    TS.setBodyEnergyBalances(to, maxBodyEnergy);
                    // TODO add fat in case ov over eating
                }else{
                    TS.setBodyEnergyBalances(to, newEnrg);
                }

                uint256 fatB = TS.getBodyFatBalances(to);
                uint256 newFatB = fatB + ( amount * meatFatFor100g / 100);


                if( newFatB > maxBodyFat){
                    TS.setBodyFatBalances(to, maxBodyFat);
                }else{
                    TS.setBodyFatBalances(to, newFatB);
                }



                /*
                if( _BodyEnergyBalances[to] > maxBodyEnergy){
                    _BodyEnergyBalances[to] = maxBodyEnergy;
                }
                _BodyFatBalances[to] += ( amount * meatSandwichFatFor100g / 100);
                if( _BodyFatBalances[to] > maxBodyFat){
                    _BodyFatBalances[to] = maxBodyFat;
                }*/
            }
        //

        // ==================== WORK

            function Hunt() public {
                address to = tx.origin;
                //require( checkHuntingPrivilege(to) );  UNCOMMENT IT LATER   <<<<<<<<<<<<<=======


                require( TS.getBodyEnergyBalances(to) >  huntEnergyConsumption); 
                //require( _latestHunts[to] < block.timestamp - huntPeriod ); // preventing frequent hunt
                string memory can = checkHuntingPrivilege();
                require(!compareStrings(can,""),"cant hunt");

                TS.setLastTimeHC(can);
                uint256 meatB = TS.getMeatBalances(to);
                TS.setMeatBalances(to, (meatB + huntRevenue));
                uint256 energB = TS.getBodyEnergyBalances(to);
                TS.setBodyEnergyBalances(to, (energB - huntEnergyConsumption));

            }

            function checkHuntingPrivilege()internal view returns(string memory){
                
                string[] memory buildings = LA.getMyBuildings();

                require(buildings.length>0,"nobuilding");

                for(uint i = 0; i<buildings.length; i++){
                    
                    if(TS.getLastTimeHC(buildings[i]) + huntPeriod < block.timestamp){
                        return buildings[i];
                    }
                }

                return "";
            }
            
            function whenCanHunt() external view returns (uint256){
                
                string[] memory buildings = LA.getMyBuildings();
                uint256 timeRes = 2000000000;
                uint256 time = 0;


                require(buildings.length>0,"nobuilding");

                for(uint i = 0; i<buildings.length; i++){
                    time = TS.getLastTimeHC(buildings[i]);
                    if(time < timeRes){
                        time = timeRes;
                    }
                }
                return timeRes;
            }


            function getTS() public view returns (uint256){
                return block.timestamp;
            }

        //

        //==================== BUSINESSES
            function pay(address to, uint256 amount) external {

                address from = tx.origin;
                uint256 balance = TS.getOpousMoneyBalances(from);
                require(balance >= amount, "Low Balance");
                TS.setOpousMoneyBalances(from, balance - amount);
                uint256 reseiverBal = TS.getOpousMoneyBalances(to);
                TS.setOpousMoneyBalances(to, reseiverBal + amount);

            }
        //

        // PLAY
            function getMyInventory() public view returns(uint256[] memory){
                return TS.getInventory(tx.origin);
            }

            function getMyName() public view returns(string memory) {
                return TS.getPersonName(tx.origin);
            }

            function getMyId() public view returns(uint256) {
                return TS.getPersonId(tx.origin);
            }

        //

        // ==================== Sell Offer

            function listMeatToSell(uint256 amount, uint256 price) public {                
                TS.addSellMeat(amount,price);
            }

            function cancelMeatToSell(uint256 ticketId) public {                
                address to = tx.origin;
                uint256[] memory ticket = TS.getSellMeat(ticketId);
                address seller = TS.getPersonIdToAddress(ticket[1]);
                require(to == seller,"not yours");
                uint256 meatBal = TS.getMeatBalances(to);
                TS.setMeatBalances(to, meatBal+ticket[2]);
                TS.removeSellMeat(ticketId);
            }

            function buyMeat(uint256 ticketId) public {

                address to = tx.origin;
                uint256[] memory ticket = TS.getSellMeat(ticketId);
                address seller = TS.getPersonIdToAddress(ticket[1]);

                TS.pay(seller, ticket[3]);
                uint256 meatBal = TS.getMeatBalances(to);
                TS.setMeatBalances(to, meatBal+ticket[2]);
                TS.removeSellMeat(ticketId);

            }

            function getMeatSellList() public view returns (string[] memory){
                return TS.getAllSellMeat();
            }

        //
    //

    // ==================== TRANSFER
        /*
        function _transferOpousMoneyBalances(address from, address to, uint256 amount) internal virtual {
            require(from != address(0), "ERC20: transfer from the zero address");
            require(to != address(0), "ERC20: transfer to the zero address");
            require(tx.origin == from, "You are not the owner");

            uint256 fromBalance = _OpousMoneyBalances[from];
            require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
            
                _OpousMoneyBalances[from] = fromBalance - amount;
            
            _OpousMoneyBalances[to] += amount;

            emit Transfer(from, to, amount, "OpousMoney");

        }




        function _transferElectricityBalances(address from, address to, uint256 amount) internal virtual {
            require(from != address(0), "ERC20: transfer from the zero address");
            require(to != address(0), "ERC20: transfer to the zero address");
            require(tx.origin == from, "You are not the owner");

            uint256 fromBalance = _ElectricityBalances[from];
            require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
            
                _ElectricityBalances[from] = fromBalance - amount;
            
            _ElectricityBalances[to] += amount;

            emit Transfer(from, to, amount, "Electricity");

        }




        function _transferWheatBalances(address from, address to, uint256 amount) internal virtual {
            require(from != address(0), "ERC20: transfer from the zero address");
            require(to != address(0), "ERC20: transfer to the zero address");
            require(tx.origin == from, "You are not the owner");

            uint256 fromBalance = _WheatBalances[from];
            require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
            
                _WheatBalances[from] = fromBalance - amount;
            
            _WheatBalances[to] += amount;

            emit Transfer(from, to, amount, "Wheat");

        }




        function _transBreadBalances(address from, address to, uint256 amount) internal virtual {
            require(from != address(0), "ERC20: transfer from the zero address");
            require(to != address(0), "ERC20: transfer to the zero address");
            require(tx.origin == from, "You are not the owner");

            uint256 fromBalance = _BreadBalances[from];
            require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
            
                _BreadBalances[from] = fromBalance - amount;
            
            _BreadBalances[to] += amount;

            emit Transfer(from, to, amount, "Bread");

        }




        function _transferFlourBalances(address from, address to, uint256 amount) internal virtual {
            require(from != address(0), "ERC20: transfer from the zero address");
            require(to != address(0), "ERC20: transfer to the zero address");
            require(tx.origin == from, "You are not the owner");

            uint256 fromBalance = _FlourBalances[from];
            require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
            
                _FlourBalances[from] = fromBalance - amount;
            
            _FlourBalances[to] += amount;

            emit Transfer(from, to, amount, "Flour");

        }




        function _transferMeatBalances(address from, address to, uint256 amount) internal virtual {
            require(from != address(0), "ERC20: transfer from the zero address");
            require(to != address(0), "ERC20: transfer to the zero address");
            require(tx.origin == from, "You are not the owner");

            uint256 fromBalance = _MeatBalances[from];
            require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
            
                _MeatBalances[from] = fromBalance - amount;
            
            _MeatBalances[to] += amount;

            emit Transfer(from, to, amount, "Meat");

        }




        function _transferBodyFatBalances(address from, address to, uint256 amount) internal virtual {
            require(from != address(0), "ERC20: transfer from the zero address");
            require(to != address(0), "ERC20: transfer to the zero address");
            require(tx.origin == from, "You are not the owner");

            uint256 fromBalance = _BodyFatBalances[from];
            require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
            
                _BodyFatBalances[from] = fromBalance - amount;
            
            _BodyFatBalances[to] += amount;

            emit Transfer(from, to, amount, "BodyFat");

        }




        function _transferBodyEnergyBalances(address from, address to, uint256 amount) internal virtual {
            require(from != address(0), "ERC20: transfer from the zero address");
            require(to != address(0), "ERC20: transfer to the zero address");
            require(tx.origin == from, "You are not the owner");

            uint256 fromBalance = _BodyEnergyBalances[from];
            require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
            
                _BodyEnergyBalances[from] = fromBalance - amount;
            
            _BodyEnergyBalances[to] += amount;

            emit Transfer(from, to, amount, "BodyEnergy");

        }




        function _transferBodyHealthBalances(address from, address to, uint256 amount) internal virtual {
            require(from != address(0), "ERC20: transfer from the zero address");
            require(to != address(0), "ERC20: transfer to the zero address");
            require(tx.origin == from, "You are not the owner");

            uint256 fromBalance = _BodyHealthBalances[from];
            require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
            
                _BodyHealthBalances[from] = fromBalance - amount;
            
            _BodyHealthBalances[to] += amount;

            emit Transfer(from, to, amount, "BodyHealth");

        }




        */
        event Transfer( address from, address to, uint256 amount, string token);                      

    //




    // ==================== GET BALANCES
        /*
        function OpousMoneybalanceOf(address account) public view returns(uint256) {
            return  _OpousMoneyBalances[account];
        }

        function ElectricitybalanceOf(address account) public view returns(uint256) {
            return  _ElectricityBalances[account];
        }

        function WheatbalanceOf(address account) public view returns(uint256) {
            return  _WheatBalances[account];
        }

        function BreadbalanceOf(address account) public view returns(uint256) {
            return  _BreadBalances[account];
        }

        function FlourbalanceOf(address account) public view returns(uint256) {
            return  _FlourBalances[account];
        }

        function MeatbalanceOf(address account) public view returns(uint256) {
            return  _MeatBalances[account];
        }

        function BodyFatbalanceOf(address account) public view returns(uint256) {
            return  _BodyFatBalances[account];
        }

        function BodyEnergybalanceOf(address account) public view returns(uint256) {
            return  _BodyEnergyBalances[account];
        }

        function BodyHealthbalanceOf(address account) public view returns(uint256) {
            return  _BodyHealthBalances[account];
        }
        */

    //


    // ==================== GET MY

        /*
        function getMyOpousMoney() public view returns(uint256) {
            return  _OpousMoneyBalances[msg.sender];
        }

        function getMyElectricity() public view returns(uint256) {
            return  _ElectricityBalances[msg.sender];
        }

        function getMyWheat() public view returns(uint256) {
            return  _WheatBalances[msg.sender];
        }

        function getMyBread() public view returns(uint256) {
            return  _BreadBalances[msg.sender];
        }

        function getMyFlour() public view returns(uint256) {
            return  _FlourBalances[msg.sender];
        }

        function getMyMeat() public view returns(uint256) {
            return  _MeatBalances[msg.sender];
        }

        function getMyBodyHealth() public view returns(uint256) {
            return  _BodyHealthBalances[msg.sender];
        }

        function getMyBodyFat() public view returns(uint256) {
            return  _BodyFatBalances[msg.sender];
        }

        function getMyBodyEnergy() public view returns(uint256) {
            return  _BodyEnergyBalances[msg.sender];
        }
        */



        
    //

    



    // =================== Latheral
        function compareStrings(string memory a, string memory b) public pure returns (bool) {
            return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
        }
    //


}


interface ITokensStorage{
    
    
    // ==================== Methods

        function getInventory(address to) external view returns(uint256[] memory);
    
        function setInventory(address to, uint256[] memory data) external;
    
        function getOpousMoneyBalances(address adr) external view returns(uint256);

        function setOpousMoneyBalances(address adr, uint256 value) external;

        function getElectricityBalances(address adr) external view returns(uint256);

        function setElectricityBalances(address adr, uint256 value) external;

        function getWheatBalances(address adr) external view returns(uint256);

        function setWheatBalances(address adr, uint256 value) external;

        function getBreadBalances(address adr) external view returns(uint256);

        function setBreadBalances(address adr, uint256 value) external;

        function getFlourBalances(address adr) external view returns(uint256);

        function setFlourBalances(address adr, uint256 value) external;

        function getMeatBalances(address adr) external view returns(uint256);

        function setMeatBalances(address adr, uint256 value) external;

        function getBodyFatBalances(address adr) external view returns(uint256);

        function setBodyFatBalances(address adr, uint256 value) external;

        function getBodyEnergyBalances(address adr) external view returns(uint256);

        function setBodyEnergyBalances(address adr, uint256 value) external;

        function getBodyHealthBalances(address adr) external view returns(uint256);

        function setBodyHealthBalances(address adr, uint256 value) external;

        function getPersonId(address adr) external view returns(uint256);

        function setPersonId(address adr, uint256 value) external;
        
        function getBirthday(address adr) external view returns(uint256);

        function setBirthday(address adr, uint256 value) external ;

        function getPersonIdToAddress(uint id) external view returns(address);

        function setPersonIdToAddress(uint id, address value) external;

        function getPersonName(address adr) external view returns(string memory);

        function setPersonName(address adr, string memory value) external;
        
        function getPersonIdNumerator() external view returns(uint256);

        function setPersonIdNumerator(uint256 value) external;

        function pay(address to, uint256 amount) external;


        function getLastTimeHC(string calldata buildingId) external view returns(uint256);

        function setLastTimeHC(string calldata buildingId) external ;
        
        function getLastTimeFarm(string calldata buildingId) external view returns(uint256);

        function setLastTimeFarm(string calldata buildingId) external  ;
        
        function getLastTimeGrindr(string calldata buildingId) external view returns(uint256);

        function setLastTimeGrindr(string calldata buildingId) external  ;
        
        function getLastTimeBakery(string calldata buildingId) external view returns(uint256);

        function setLastTimeBakery(string calldata buildingId) external ;
        
        function getLastTimeWindmill(string calldata buildingId) external view returns(uint256);

        function setLastTimeWindmill(string calldata buildingId) external;

        function addSellMeat( uint256 amount, uint256 price) external;

        function removeSellMeat( uint256 sellTicketId) external;

        function getSellMeat(uint256 ticketId) external view returns(uint256[] memory);

        function getAllSellMeat() external view returns(string[] memory);

    //

}

interface ILandsAgent{

    function getLandBuilding(string calldata landId) external view returns (string memory);

    function getMyBuildings() external view returns (string[] memory);

}