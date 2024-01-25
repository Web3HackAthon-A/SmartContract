// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract SkillToken is ERC20, Ownable, ERC20Permit {
    constructor(address initialOwner)
        ERC20("SkillToken", "STK")
        Ownable(initialOwner)
        ERC20Permit("SkillToken")
    {
        _mint(msg.sender, 10000 * 10 ** decimals());
    }

    function reward(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}