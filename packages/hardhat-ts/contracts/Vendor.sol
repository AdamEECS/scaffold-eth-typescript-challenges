pragma solidity >=0.8.0 <0.9.0;
// SPDX-License-Identifier: MIT

import '@openzeppelin/contracts/access/Ownable.sol';
import './YourToken.sol';

contract Vendor is Ownable {
  YourToken public yourToken;

  uint256 public constant tokensPerEth = 100;

  constructor(address tokenAddress) {
    yourToken = YourToken(tokenAddress);
  }

  event BuyTokens(address buyer, uint256 amountOfEth, uint256 amountOfTokens);

  // ToDo: create a payable buyTokens() function:
  // should use msg.value and tokensPerEth to calculate an amount of tokens to yourToken.transfer() to msg.sender
  //       - it should emit the BuyTokens event
  function buyTokens() public payable {
    uint256 amountOfTokens = msg.value * tokensPerEth;
    yourToken.transfer(msg.sender, amountOfTokens);
    emit BuyTokens(msg.sender, msg.value, amountOfTokens);
  }

  // ToDo: create a withdraw() function that lets the owner withdraw ETH
  function withdraw() public onlyOwner {
    payable(msg.sender).transfer(address(this).balance);
  }

  // ToDo: create a sellTokens() function:
  function sellTokens(uint256 amountOfTokens) public {
    // should use amountOfTokens and tokensPerEth to calculate an amount of ETH to transfer to msg.sender
    //       - it should emit the BuyTokens event
    uint256 amountOfEth = amountOfTokens / tokensPerEth;
    yourToken.transferFrom(msg.sender, address(this), amountOfTokens);
    payable(msg.sender).transfer(amountOfEth);
    // emit BuyTokens(msg.sender, amountOfEth, amountOfTokens);
  }
}
