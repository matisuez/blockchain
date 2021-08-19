// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract CryptoBank {
    
    uint customerNextId;

    struct Customer {
        uint customerAddress;
        uint amount;
    }

    Customer[] customers;

    function createUser() public returns( uint ) {
        uint customerId = customerNextId;

        customers.push( Customer( customerId, 0 ) );
        customerNextId++;

        uint index = findIndex( customerId );

        return customers[ index ].customerAddress;

    }

    function findIndex( uint _customerAddress ) internal view returns( uint ) {
        for( uint i = 0; i < customers.length; i++ ) {
            if( !(customers[ i ].customerAddress == _customerAddress) ) revert( "Customer address not found." );
            return i;
        }
    }

    function saveMoney( uint _customerAddress, uint _amount ) public {
        uint index = findIndex( _customerAddress );
        customers[ index ].amount += _amount;
    }

    function extractMoney( uint _customerAddress, uint _amount ) public {
        uint index = findIndex( _customerAddress );
        if( !( _amount <= customers[ index ].amount ) ) revert( "The customer balance is less." );
        customers[ index ].amount -= _amount;
    }

    function getBalance( uint _customerAddress ) public view returns( uint ) {
        uint index = findIndex( _customerAddress );
        return customers[ index ].amount;
    }
    
    function getBankBalance() public view returns( uint ) {
        uint total = 0;
        for( uint i = 0; i < customers.length; i++ ) {
            total += customers[ i ].amount;
        }
        return total;
    }
    
}