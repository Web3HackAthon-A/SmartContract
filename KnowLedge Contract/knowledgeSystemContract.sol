// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// contract IKnowledgeNFT {
//     function createKnowlegde(string memory knowledge) public {}
// }

contract IKnowledgeToken {
    function reward(address to, uint256 amount) public {}
}

contract KnowledgeSystem {
    // address IKnowledgeNFTAddress = 0xDc7CF4AF26E512E9E55461F7da527c91406c3f8A;
    // IKnowledgeNFT nftContract = IKnowledgeNFT(IKnowledgeNFTAddress)

    address IKnowledgeTokenAddress = 0x641331167df458511f03D8ceFb4A9697a8a96EdB;
    IKnowledgeToken tokenContract = IKnowledgeToken(IKnowledgeTokenAddress);

    uint256 amount = 20 * 10 ** 18;
    function createKnowledge(string memory knowledge) public {
        // nftContract.createKnowlegde(knowledge);
        tokenContract.reward(msg.sender, amount);
    }
}
