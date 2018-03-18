pragma solidity ^0.4.15;

contract Vote {
    event LogVote(address indexed addr);

    function() {
        if (msg.value > 0) {
            throw;
        }

        LogVote(msg.sender);
    }
}
