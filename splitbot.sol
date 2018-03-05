pragma solidity ^0.4.15;

contract ERC20Interface {
    function totalSupply() public constant returns (uint);
    function balanceOf(address tokenOwner) public constant returns (uint balance);
    function allowance(address tokenOwner, address spender) public constant returns (uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

contract Split {
    address public donate;
    address public owner;
    uint public percent;

    modifier validPercent(uint _percent) {
        require(_percent >= 1 && _percent <= 99);
        _;
    }

    function Split(address _owner, address _donate, uint _percent)
        public
        validPercent(_percent)
    {
      owner = _owner;
      donate = _donate;
      percent = _percent;
    }

    function() payable public {
        if (msg.value > 0) {
            uint toDonate = msg.value * percent / 100;
            uint toOwner = msg.value - toDonate;

            owner.transfer(toOwner);
            donate.transfer(toDonate);
        }
    }

    function transferAnyERC20Token(address tokenAddress) public returns (bool success) {
      ERC20Interface token = ERC20Interface(tokenAddress);
      uint balance = token.balanceOf(address(this));
      return token.transfer(owner, balance);
    }
}
