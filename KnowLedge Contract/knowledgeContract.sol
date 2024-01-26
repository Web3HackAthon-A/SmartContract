// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract KnowledgeNFT is ERC721 {
    uint256 public tokenCounter;
    mapping (uint256 => string) public knowledgeData;

    constructor() ERC721("KnowledgeNFT", "KNFT") {
        tokenCounter = 0;
    }

    function createKnowlegde(string memory knowledge) public {
        knowledgeData[tokenCounter] = knowledge;
        _mint(msg.sender, tokenCounter);
        tokenCounter++;
    }

    function getKnowledge(uint256 tokenId) public view returns (string memory) {
        return knowledgeData[tokenId];
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://raw.githubusercontent.com/Web3HackAthon-A/SmartContract/katori-dev/NFT%20Folder/";
    }
}