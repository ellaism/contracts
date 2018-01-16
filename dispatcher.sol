pragma solidity ^0.4.19;

contract Dispatcher {
    address constant public dev = 0xe9C2d958E6234c862b4AfBD75b2fd241E9556303;
    address constant public community = 0xA2C7779077Edc618C926AB5BA7510877C187cd92;
    
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
