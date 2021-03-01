pragma solidity ^0.5.0;

import "../app-token/node_modules/openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract TokenFactory is Ownable {

	event newToken(uint tokenId, string name, string addresse, uint price, string image,bool state, string description);

	struct Token {
		string name;
		string addresse;
		uint price;
		string image;
		bool state;
		string description;
		uint createdAt;
		uint updatedAt;
		
	}

	Token[] public tokens;

	mapping (uint => address) public tokenToOwner;
	mapping (address => uint) ownerTokenCount;

	function createToken(string memory _name, string memory _addresse, uint _price, string memory _image, string memory _description) public {
		uint id = tokens.push(Token(_name,_addresse,_price,_image,false,_description,now,now))-1;
		tokenToOwner[id] = msg.sender;
		ownerTokenCount[msg.sender] ++;
		emit newToken(id,_name,_addresse,_price,_image,false,_description);
	}

}

