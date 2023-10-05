# Smart-Contract-Vulnerable-To-Reentrancy-ERC721-ERC1155-ERC777-
Smart Contract Vulnerable To Reentrancy (ERC721, ERC1155, ERC777)

# Description
~ Reentrancy vulnerabilities are a type of security issue in smart contracts that can occur when a contract interacts with external contracts, especially when handling tokens like ERC721, ERC1155, or ERC777. These vulnerabilities can allow an attacker to repeatedly call back into the vulnerable contract, potentially leading to unauthorized access or manipulation of funds. 

# vulnerable.sol
~ In this vulnerable.sol, the vulnerableWithdraw function is the vulnerable part of the contract. An attacker can repeatedly call vulnerableWithdraw and, if they have a malicious contract, they can use this function to trigger a reentrancy attack. This attack allows the attacker to repeatedly enter the vulnerableWithdraw function and potentially drain the contract of its ERC721 tokens.

# fix.sol
~ In the safeWithdraw function, we have applied the Checks-Effects-Interactions pattern to ensure that state changes are made before any external interaction. This helps prevent reentrancy attacks because the state is updated before the external transfer of the ERC721 token.

~ Various audit tools, such as Slither - https://github.com/crytic/slither, Mythril - https://mythx.io/ and Securify - https://github.com/eth-sri/securify2, can check for the presence of the different types of reentrancy vulnerabilities.
