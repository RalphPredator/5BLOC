pragma solidity ^0.5.0;

import "./tokenfactory.sol";

contract TokenHelper is TokenFactory {
	
  modifier onlyOwnerOf(uint _tokenId) {
    require(msg.sender == tokenToOwner[_tokenId]);
    _;
  }

  function getTokensByOwner(address _owner) external view returns(uint[] memory) {
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

  function getTokensOnlineByOwner(address _owner) external view returns(uint[] memory) {
    uint[] memory result = new uint[](ownerTokenCount[_owner]);
    uint counter = 0;
    for (uint i = 0; i < tokens.length; i++) {
      if (tokenToOwner[i] == _owner && tokens[i].state == true) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }

  function setTokenOnline(uint _tokenId) external onlyOwnerOf(_tokenId) {
    tokens[_tokenId].state = true;
  }

  function setTokenOffline(uint _tokenId) external onlyOwnerOf(_tokenId) {
    tokens[_tokenId].state = false;
  }

}
