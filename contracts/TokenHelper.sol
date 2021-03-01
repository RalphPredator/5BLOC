pragma solidity ^0.5.0;

import "./tokenfactory.sol";

contract TokenHelper is TokenFactory {
	
  modifier onlyOwnerOf(uint _tokenId) {
    require(msg.sender == tokenToOwner[_tokenId]);
    _;
  }

  function getTokenDetail (uint _tokenId) public view
  returns(
    uint,
    string memory,
    string memory,
    uint,
    string memory,
    string memory
    ) {
    require( (_tokenId > 0) || (_tokenId <= tokens.length) );
    
    Token memory token = tokens[_tokenId];

    return (
      _tokenId,
      token.name,
      token.addresse,
      token.price,
      token.image,
      token.description
    );
  }
  

  function getTokensByOwner(
    address _owner
  ) external view returns(uint[] memory) {

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

  function getAllTokens() external view returns(uint[] memory) {
    uint[] memory result = new uint[](tokens.length);
    uint counter = 0;
    for (uint i = 0; i < tokens.length; i++) {
      result[counter] = i;
      counter++;
    }
    return result;
  }

  function updateToken(
    uint _tokenId, 
    string memory _name, 
    string memory _addresse, 
    uint _price, 
    string memory _image, 
    string memory _description
  ) public onlyOwnerOf(_tokenId) {
  
    tokens[_tokenId].name = _name;
    tokens[_tokenId].addresse = _addresse;
    tokens[_tokenId].price = _price;
    tokens[_tokenId].image = _image;
    tokens[_tokenId].description = _description;
  }

  function setTokenOnline(uint _tokenId) external onlyOwnerOf(_tokenId) {
    tokens[_tokenId].state = true;
    tokens[_tokenId].updatedAt = now;
  }

  function setTokenOffline(uint _tokenId) external onlyOwnerOf(_tokenId) {
    tokens[_tokenId].state = false;
    tokens[_tokenId].updatedAt = now;
  }

}
