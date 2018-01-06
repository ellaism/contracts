pragma solidity ^0.4.19;

contract Dispatcher {
    address constant public dev = 0x00522e276908428C02457d8a8747b9aA0AB52570;
    address constant public community = 0x46739B691C011530AAf480AAcd339C206a2046E6;
    
    function() payable public {
        if (msg.value > 0) {
            if (community.balance < dev.balance) {
                community.transfer(msg.value);
            } else {
                dev.transfer(msg.value);
            }
        }
    }
}
