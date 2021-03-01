pragma solidity ^0.5.0;

import "./tokenhelper.sol";
import "../app-token/node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "../app-token/node_modules/openzeppelin-solidity/contracts/token/ERC721/ERC721.sol";


contract TokenOwnership is TokenHelper, ERC721 {
  
  event Transfer(
    address indexed _from,
    address indexed _to,
    uint256 _tokenId
  );

  event Approval(
    address indexed _owner,
    address indexed _approved,
    uint256 _tokenId
  );

  using SafeMath for uint256;

  mapping (uint => address) tokenApprovals;

  function balanceOf(address _owner) public view returns (uint256) {
    return ownerTokenCount[_owner];
  }

  function _transfer(
    address _from,
    address _to,
    uint256 _tokenId
  ) private {

    ownerTokenCount[_to] = ownerTokenCount[_to].add(1);
    ownerTokenCount[msg.sender] = ownerTokenCount[msg.sender].sub(1);
    tokenToOwner[_tokenId] = _to;
    emit Transfer(_from, _to, _tokenId);

  }

  function transfer(
    address _from,
    address _to,
    uint256 _tokenId
  ) public payable onlyOwner(){

    require (tokenToOwner[_tokenId] == msg.sender || tokenApprovals[_tokenId] == msg.sender);
    _transfer(_from, _to, _tokenId);
  }

  function approve(
    address _to, 
    uint256 _tokenId
  ) public onlyOwner() {
    
    tokenApprovals[_tokenId] = _to;
    emit Approval(msg.sender, _to, _tokenId);
  }

}