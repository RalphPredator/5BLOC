pragma solidity ^0.5.0;

import "./TokenFactory.sol";

contract TokenHelper is TokenFactory {
	
  modifier onlyOwnerOf(uint _tokenId) {
    require(msg.sender == tokenToOwner[_tokenId]);
    _;
  }

  function getTokensByOwner(address _owner) external view returns(uint[]) {
    uint[] memory result = new uint[](ownerTokenCount[_owner]);
    uint counter = 0;
    for (uint i = 0; i < tokens.length; i++) {
      if (tokenToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }

  function putOnline(uint _tokenId) external onlyOwnerOf(_tokenId) {
  	tokens[_tokenId].state = 1;
  }
  
  function popOnline(uint _tokenId) external onlyOwnerOf(_tokenId) {
  	tokens[_tokenId].state = 0;
  }

  function updateToken(uint _tokenId, string _name, string _address, uint _price, string _image) external onlyOwnerOf(_tokenId) {
  	tokens[_tokenId].name = _name;
  	tokens[_tokenId].address = _address;
  	tokens[_tokenId].price = _price;
  	tokens[_tokenId].image = _image;
  }

}
