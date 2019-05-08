pragma solidity ^0.5.0;

contract ColdStore {
    
    bool public delaySet;
    uint public delay;
    uint public delayStartingPoint; 
    
    address payable withdrawlAddress;
    address public owner;
    
    event countDownStarted(address payable destination, address contractAddress, uint value);
    event transfered(address payable destination, address contractAddress, uint value);
    
   constructor(address _owner, uint _delay) public{
        owner = _owner;
        delay = _delay;
    }
    
    function withdraw(address payable _withdrawlAddress) public {
        require(msg.sender == owner, "This address is not the owner");
        if(delaySet){
            if (now >= delayStartingPoint + delay * 1 seconds) {
            emit transfered(withdrawlAddress, address(this), address(this).balance);
            selfdestruct(withdrawlAddress);
            }
        } else {
            delaySet = true;
            delayStartingPoint = now;
            withdrawlAddress = _withdrawlAddress;
            emit countDownStarted(withdrawlAddress, address(this), address(this).balance);
        }
    }
    
    function getBalance() public view returns(uint256){
        return address(this).balance;
    }

    function() external payable { }
}
