// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract VulnerableContract {
    IERC721 public token;
    mapping(address => uint256) public balances;

    constructor(address _token) {
        token = IERC721(_token);
    }

    function deposit(uint256 _tokenId) external {
        // Transfer the ERC721 token to this contract
        token.transferFrom(msg.sender, address(this), _tokenId);
        // Update the balance of the sender
        balances[msg.sender] += 1;
    }

    function withdraw(uint256 _tokenId) external {
        // Check if the sender has a balance of the token
        require(balances[msg.sender] > 0, "No balance");
        // Update the balance of the sender
        balances[msg.sender] -= 1;
        // Transfer the ERC721 token back to the sender
        token.transfer(msg.sender, _tokenId);
    }

    function vulnerableWithdraw(uint256 _tokenId) external {
        // This is the vulnerable function
        // An attacker can call this function repeatedly to exploit the reentrancy vulnerability
        require(balances[msg.sender] > 0, "No balance");
        // Update the balance of the sender
        balances[msg.sender] -= 1;
        // Perform some external call that might trigger a reentrancy attack
        // For example, an attacker's malicious contract could have a fallback function that calls back into this contract
        // and calls vulnerableWithdraw again
        // This would result in a reentrancy attack
        token.transfer(msg.sender, _tokenId);
    }
}
