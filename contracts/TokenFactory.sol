pragma solidity ^0.5.0;

import "./safemath.sol";

contract Ownable {
  address private _owner;

  event OwnershipTransferred(
    address indexed previousOwner,
    address indexed newOwner
  );

  /**
  * @dev The Ownable constructor sets the original `owner` of the contract to the sender
  * account.
  */
  constructor() internal {
    _owner = msg.sender;
    emit OwnershipTransferred(address(0), _owner);
  }

  /**
  * @return the address of the owner.
  */
  function owner() public view returns(address) {
    return _owner;
  }

  /**
  * @dev Throws if called by any account other than the owner.
  */
  modifier onlyOwner() {
    require(isOwner());
    _;
  }

  /**
  * @return true if `msg.sender` is the owner of the contract.
  */
  function isOwner() public view returns(bool) {
    return msg.sender == _owner;
  }

  /**
  * @dev Allows the current owner to relinquish control of the contract.
  * @notice Renouncing to ownership will leave the contract without an owner.
  * It will not be possible to call the functions with the `onlyOwner`
  * modifier anymore.
  */
  function renounceOwnership() public onlyOwner {
    emit OwnershipTransferred(_owner, address(0));
    _owner = address(0);
  }

  /**
  * @dev Allows the current owner to transfer control of the contract to a newOwner.
  * @param newOwner The address to transfer ownership to.
  */
  function transferOwnership(address newOwner) public onlyOwner {
    _transferOwnership(newOwner);
  }

  /**
  * @dev Transfers control of the contract to a newOwner.
  * @param newOwner The address to transfer ownership to.
  */
  function _transferOwnership(address newOwner) internal {
    require(newOwner != address(0));
    emit OwnershipTransferred(_owner, newOwner);
    _owner = newOwner;
  }
}


contract TokenFactory is Ownable {
	
	using SafeMath for uint256;

	event newToken(uint tokenId, string name, string addresse, uint price, string image,bool state, string description);

	struct Token {
		string name;
		string addresse;
		uint price;
		string image;
		bool state;
		string description;
	}

	Token[] public tokens;

	mapping (uint => address) public tokenToOwner;
  mapping (address => uint) ownerTokenCount;

  function createToken(string memory _name, string memory _addresse, uint _price, string memory _image, string memory _description) public {
	  uint id = tokens.push(Token(_name,_addresse,_price,_image,false,_description))-1;
	  tokenToOwner[id] = msg.sender;
	  ownerTokenCount[msg.sender] ++;
	  emit newToken(id,_name,_addresse,_price,_image,false,_description);
  }

}

