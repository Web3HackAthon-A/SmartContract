// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract SkillToken is ERC20, Ownable, ERC20Permit {
    mapping (address => bool) public rewarders;

    constructor(address initialOwner)
        ERC20("SkillToken", "STK")
        Ownable(initialOwner)
        ERC20Permit("SkillToken")
    {
        _mint(msg.sender, 10000 * 10 ** decimals());
        rewarders[msg.sender] = true; // Initialise the sender as rewarder
    }

    function setRewarder(address _rewarder, bool _status) public onlyOwner {
        rewarders[_rewarder] = _status;
    }

    function reward(address _to, uint256 _amount) public onlyOwner {
        _mint(_to, _amount);
    }

    function rewardFromRewarder(address _to, uint256 _amount) public {
        require(rewarders[msg.sender] == true, "Caller is not a rewarder");
        _mint(_to, _amount);
    }
}