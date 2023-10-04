// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract FixedContract {
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

    function safeWithdraw(uint256 _tokenId) external {
        // Use the Checks-Effects-Interactions pattern
        // 1. Check if the sender has a balance of the token
        require(balances[msg.sender] > 0, "No balance");

        // 2. Update the balance of the sender before any external interaction
        balances[msg.sender] -= 1;

        // 3. Perform the external interaction after state changes
        // Transfer the ERC721 token back to the sender
        require(token.transfer(msg.sender, _tokenId), "Transfer failed");
    }
}
