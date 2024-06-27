// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract MyContract {
    mapping (address => uint) balances;
    uint constant MAX_ONE_TIME_AMOUNT = 1000;
    uint32 pin = 1234;

   
    function depositMoney(uint _amount) external {
        assert(_amount<=MAX_ONE_TIME_AMOUNT);
        balances[msg.sender]+=_amount;
    }

    function withdrawMoney(uint _amount, uint32 _pin) external {
        assert(_amount<=MAX_ONE_TIME_AMOUNT);

        if(_pin!=pin) revert("Unauthorized withdrawal");

        require(balances[msg.sender]>=_amount, "Insufficient balance");
        balances[msg.sender]-=_amount;
    }
    function displayBalance(uint32 _pin) external view returns(uint) {
        if(_pin!=pin) revert("Unauthorized access");
        return balances[msg.sender];
    }
 
}