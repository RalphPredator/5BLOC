pragma solidity ^0.4.19;

import "./Ownable.sol";

contract TokenFactory is Ownable {
	
	event newToken(uint tokenId, string name, string address, uint price, string image);

	struct Token {
		string name;
		string address;
		uint price;
		string image;
		bool state;
	}

	Token[] public tokens;

	mapping (uint => address) public tokenToOwner;
  mapping (address => uint) ownerTokenCount;

  function _createToken(string name, string _address, uint _price, string _image) internal {
	  uint id = tokens.push(Token(_name,_address,_price,image,0))-1;
	  tokenToOwner[id] = msg.sender++
	  ownerTokenCount[msg.sender];
	  newToken(id,_namen,_address,_price,_image);
  }

}