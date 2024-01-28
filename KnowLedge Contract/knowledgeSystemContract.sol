// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Interface for the Contract of Knowledge NFT
interface IKnowledgeNFT {
    function createKnowlegde(address knowledgeOwner, string memory knowledge) external;
    function getKnowledge(uint256 tokenId) external view returns (string memory);
    function ownerOf(uint256 tokenId) external view returns (address);
}

// Interface for the Contract of Skill Token
interface IKnowledgeToken {
    function decimals() external view returns (uint256);
    function reward(address to, uint256 amount) external;
}

contract KnowledgeSystem {
    // address IKnowledgeNFTAddress = 0xDc7CF4AF26E512E9E55461F7da527c91406c3f8A;
    // IKnowledgeNFT nftContract = IKnowledgeNFT(IKnowledgeNFTAddress);

    // address IKnowledgeTokenAddress = 0x641331167df458511f03D8ceFb4A9697a8a96EdB;
    // IKnowledgeToken tokenContract = IKnowledgeToken(IKnowledgeTokenAddress);

    IKnowledgeNFT private nftContract;
    IKnowledgeToken private tokenContract;

    constructor(address nftContractAddress, address tokenContractAddress) {
        nftContract = IKnowledgeNFT(nftContractAddress);
        tokenContract = IKnowledgeToken(tokenContractAddress);
    }

    function createKnowledge(string memory knowledge) public {
        uint256 amount = 20 * 10 ** tokenContract.decimals();
        nftContract.createKnowlegde(msg.sender, knowledge);
        tokenContract.reward(msg.sender, amount);
    }

    function getKnowledge(uint256 tokenId) public view returns (string memory) {
        return nftContract.getKnowledge(tokenId);
    }

    function getKnowledgeOwner(uint256 tokenId) public view returns (address) {
        return nftContract.ownerOf(tokenId);
    }

    function rewardAtViewing(uint256 tokenId) public {
        tokenContract.reward(msg.sender, 5 * 10 ** tokenContract.decimals());
        rewardForKnowledge(tokenId, 10);
    }

    function rewardForKnowledge(uint256 tokenId, uint256 amount) public {
        address ownerAddress = nftContract.ownerOf(tokenId);
        tokenContract.reward(ownerAddress, amount * 10 ** tokenContract.decimals());
    }

}
