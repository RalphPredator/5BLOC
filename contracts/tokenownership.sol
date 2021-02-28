pragma solidity ^0.5.0;

import "./safemath.sol";
import "./tokenhelper.sol";


// interface ERC721 {
//   event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
//   event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);

//   function balanceOf(address _owner) external view returns (uint256 _balance);
//   function ownerOf(uint256 _tokenId) external view returns (address _owner);
//   function transfer(address _to, uint256 _tokenId) external;
//   function approve(address _to, uint256 _tokenId) external;
// }

contract TokenOwnership is TokenHelper {
  event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
  event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);
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
  function transfer(address _from, address _to, uint256 _tokenId) external payable {
    require (tokenToOwner[_tokenId] == msg.sender || tokenApprovals[_tokenId] == msg.sender);
    _transfer(_from, _to, _tokenId);
  }

  function approve(address _to, uint256 _tokenId) external onlyOwnerOf(_tokenId) {
    tokenApprovals[_tokenId] = _to;
    emit Approval(msg.sender, _to, _tokenId);
  }

}