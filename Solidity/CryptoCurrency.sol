// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Cryptocurrency {
    
    // Send and receive
    // Value
    // Balance
    uint256 public valueOfEther;
    mapping( address => uint256 ) balances;
    address public owner;
    
    constructor() {
        balances[ msg.sender ] = 1000;
    }
    
    function send( address _fromAddress, uint _amount )  public {
        
        if( balances[ msg.sender ] < _amount ) revert( "The account value is less." );
        
        balances[ _fromAddress ] += _amount;
        balances[ msg.sender ] -= _amount;
        
    }
    
    function showBalance( address _address ) public view returns( uint256 ) {
        return balances[ _address ];
    }
    
    function emitter( address _fromAddress, uint _amount ) public {
        
        if( msg.sender != owner ) revert("Only the owner can watch this function");
        
        balances[ _fromAddress ] = _amount;
        
    }
    
}