// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Lottery {
    
    struct Customer {
        address id;
        uint256 number;
        uint256 amount;
        bool available;
    }
    enum LotteryState { Opened, Closed }
    
    address private owner;
    uint private startDay;
    uint private endDay;
    string public lotteryNumber;
    
    LotteryState state;
    Customer[] customers;
    
    constructor() {
        owner = msg.sender;
        lotteryNumber = "4302";
    }
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    function setDateRange( uint _start, uint _end ) public onlyOwner {
        if( block.timestamp >= _end || state == LotteryState.Closed ) {
            startDay = _start;
            endDay = _end;
            state = LotteryState.Opened;    
        } else {
            revert( "We have a lottery running right now. We couldnt set the new range yet." );
        }
    }
    
    function checkExistingCustomer( address _address ) private returns( bool ) {
        bool result = false;
        for( uint i = 0; i < customers.length;i++ ) {
            if( customers[i].id == _address ) {
                    result = true;
            } else {
                result = false;
            }
        }
        return result;
    }
    
    function addCustomer( address _address, uint256 _number, uint256 _amount ) public {
        require( !(checkExistingCustomer( _address )), "The customer already exist." );
        customers.push( Customer( _address, _number, _amount, true ) );
    }
    
    function generateLotteryNumber() internal view returns( uint ) {
        return uint( keccak256( abi.encodePacked( block.difficulty, block.timestamp, customers.length ) ) );
    }
    
    function setLosers() private {
        
    }
    
    function getWinners() public onlyOwner {
        // if it is out the range
        finish();
    }
    
    function resetCustomers() private {
        for( uint i = 0; i < customers.length;i++ ) {
            customers[i].number = 0;
            customers[i].amount = 0;
            customers[i].available = false;
        }
    }
    
    function finish() private {
        state = LotteryState.Closed;
        resetCustomers();
    }
    
}