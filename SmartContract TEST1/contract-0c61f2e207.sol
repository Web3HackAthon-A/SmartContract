// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts@5.0.1/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@5.0.1/token/ERC20/extensions/ERC20Permit.sol";

contract KnowLedgeToken is ERC20, ERC20Permit {
    constructor() ERC20("KnowLedgeToken", "KTK") ERC20Permit("KnowLedgeToken") {
        _mint(msg.sender, 10000 * 10 ** decimals());
    }
}
