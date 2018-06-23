pragma solidity ^0.4.18;


contract Owned {
	modifier onlyOwner {
		require(msg.sender == owner);
		_;
	}

	event NewOwner(address indexed old, address indexed current);

	function setOwner(address _new) onlyOwner public {
		NewOwner(owner, _new);
		owner = _new;
	}

	address public owner = 0x01ff0FFd25B64dE2217744fd7d4dc4aA3cAbceE7;
}


contract Delegated is Owned {
	modifier onlyDelegate {
		require(msg.sender == delegate);
		_;
	}

	event NewDelegate(address indexed old, address indexed current);

	function setDelegate(address _new) onlyOwner public {
		NewDelegate(delegate, _new);
		delegate = _new;
	}

	address public delegate = address(0);
}


contract TipFactory is Delegated {
	mapping(address => bool) users;

	event NewTipUser(address indexed user);

	function isTipUser(address _user) constant public returns (bool) {
		return users[_user];
	}

	function newTipUser() onlyDelegate public returns (address) {
		TipUser _user = new TipUser(this);
		users[address(_user)] = true;
		NewTipUser(address(_user));
		return address(_user);
	}
}


contract TipUser {
	TipFactory public factory;
	address public withdrawAddress = address(0);

	modifier onlyDelegate {
		require(msg.sender == factory.delegate());
		_;
	}

	function TipUser(TipFactory _factory) public {
		factory = _factory;
	}

	function() payable public {
		if (msg.value == 0 && msg.sender == withdrawAddress) {
			withdrawAddress.transfer(address(this).balance);
		}
	}

	function setWithdrawAddress(address _withdrawAddress) onlyDelegate public {
		require(withdrawAddress == address(0));
		withdrawAddress = _withdrawAddress;
	}

	function withdraw(uint _amount) onlyDelegate public {
		require(withdrawAddress != address(0));
		withdrawAddress.transfer(_amount);
	}

	function transfer(address _to, uint _amount) onlyDelegate public {
		require(factory.isTipUser(_to));
		_to.transfer(_amount);
	}
}
