// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.12 <0.9.0;


contract SharedWallet{

  uint256 balanceWallet;

  event Successfultrans(address _from, uint amount);

  struct User
  {
    address UsAd;
    uint256 amount;
  }

  mapping(address => User) users;

  function pay() public payable 
  {
    require(msg.value > 0, "The transfer is made by positive numbers only!");
    users[msg.sender].amount += msg.value;
    balanceWallet += msg.value; 
    emit Successfultrans(msg.sender, msg.value);
  }

  function getBalance(address UsAd) public view returns (uint256)
  {
    return uint256(users[UsAd].amount);
  }

  function refund() public payable
  {
    require(users[msg.sender].amount > 0, "You've got all your funds!");
    uint256 refundAmount = uint256(users[msg.sender].amount);
    users[msg.sender].amount = 0;
    payable(msg.sender).transfer(refundAmount);
  }

}
