// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract KnowledgeNFT is ERC721, AccessControl {
    uint256 public tokenCounter;
    mapping (uint256 => string) public knowledgeData;
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    constructor(address defaultAdmin, address minter) ERC721("KnowledgeNFT", "KNFT") {
        tokenCounter = 0;
        _grantRole(DEFAULT_ADMIN_ROLE, defaultAdmin);
        _grantRole(MINTER_ROLE, minter);
    }

    function createKnowlegde(address knowledgeOwner, string memory knowledge) public onlyRole(MINTER_ROLE) {
        knowledgeData[tokenCounter] = knowledge;
        _mint(knowledgeOwner, tokenCounter);
        tokenCounter++;
    }

    function getKnowledge(uint256 tokenId) public view returns (string memory) {
        return knowledgeData[tokenId];
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://raw.githubusercontent.com/Web3HackAthon-A/SmartContract/katori-dev//NFT/metadata/";
    }

    // The following functions are overrides required by Solidity.
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}