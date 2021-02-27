pragma solidity ^0.5.0;

import "./erc721.sol";
import "./safemath.sol";
import "./tokenhelper.sol";

contract TokenOwnership is TokenHelper, ERC721 {

  using SafeMath for uint256;

  mapping (uint => address) tokenApprovals;

  function balanceOf(address _owner) external view returns (uint256) {
    return ownerTokenCount[_owner];
  }

  function ownerOf(uint256 _tokenId) external view returns (address) {
    return tokenToOwner[_tokenId];
  }

  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownerTokenCount[_to] = ownerTokenCount[_to].add(1);
    ownerTokenCount[msg.sender] = ownerTokenCount[msg.sender].sub(1);
    tokenToOwner[_tokenId] = _to;
    emit Transfer(_from, _to, _tokenId);
  }

  function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
    require (tokenToOwner[_tokenId] == msg.sender || tokenApprovals[_tokenId] == msg.sender);
    _transfer(_from, _to, _tokenId);
  }

  function approve(address _approved, uint256 _tokenId) external payable onlyOwnerOf(_tokenId) {
    tokenApprovals[_tokenId] = _approved;
    emit Approval(msg.sender, _approved, _tokenId);
  }

}