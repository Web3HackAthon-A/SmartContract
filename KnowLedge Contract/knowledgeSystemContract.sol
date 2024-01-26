// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Interface for the Contract of Knowledge NFT
interface IKnowledgeNFT {
    function createKnowlegde(string memory knowledge) external;
}

// Interface for the Contract of Skill Token
interface IKnowledgeToken {
    function decimals() external view returns (uint256);
    function reward(address to, uint256 amount) external;
}

contract KnowledgeSystem {
    // address IKnowledgeNFTAddress = 0xDc7CF4AF26E512E9E55461F7da527c91406c3f8A;
    // IKnowledgeNFT nftContract = IKnowledgeNFT(IKnowledgeNFTAddress)

    // address IKnowledgeTokenAddress = 0x641331167df458511f03D8ceFb4A9697a8a96EdB;
    // IKnowledgeToken tokenContract = IKnowledgeToken(IKnowledgeTokenAddress);

    IKnowledgeNFT private nftContract;
    IKnowledgeToken private tokenContract;

    constructor(address nftContractAddress, address tokenContractAddress) {
        nftContract = IKnowledgeNFT(nftContractAddress);
        tokenContract = IKnowledgeToken(tokenContractAddress);
    }

    uint256 amount = 20 * 10 ** tokenContract.decimals();
    function createKnowledge(string memory knowledge) public {
        nftContract.createKnowlegde(knowledge);
        tokenContract.reward(msg.sender, amount);
    }
}
