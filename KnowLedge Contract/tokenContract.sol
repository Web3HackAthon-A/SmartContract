// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract KnowledgeToken is ERC20, AccessControl, ERC20Permit {
    bytes32 public constant REWARD_ROLE = keccak256("REWARD_ROLE");

    constructor(address defaultAdmin, address rewarder)
        ERC20("SkillToken", "STK")
        ERC20Permit("SkillToken")
    {
        _mint(msg.sender, 10000 * 10 ** decimals());
        _grantRole(DEFAULT_ADMIN_ROLE, defaultAdmin);
        _grantRole(REWARD_ROLE, rewarder);
    }

    // トークン発行によるインセンティブの付与
    function reward(address to, uint256 amount) public onlyRole(REWARD_ROLE) {
        _mint(to, amount);
    }

    // アカウントへのトークン発行権限の付与
    function addRewardRole(address account) public onlyRole(DEFAULT_ADMIN_ROLE) {
        _grantRole(REWARD_ROLE, account);
    }

    // アカウントからのトークン発行権限の削除
    function removeRewardRole(address account) public onlyRole(DEFAULT_ADMIN_ROLE) {
        _revokeRole(REWARD_ROLE, account);
    }
}