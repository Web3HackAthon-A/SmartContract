// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ナレッジNFT用コントラクトとのInterfaceの定義
interface IKnowledgeNFT {
    function createKnowlegde(address knowledgeOwner, string memory knowledge) external;
    function getKnowledge(uint256 tokenId) external view returns (string memory);
    function ownerOf(uint256 tokenId) external view returns (address);
}

// トークン用コントラクトとのInterfaceの定義
interface IKnowledgeToken {
    function decimals() external view returns (uint256);
    function reward(address to, uint256 amount) external;
}

// ナレッジシステム本体のコントラクトの定義
contract KnowledgeSystem {
    // Interface用の変数定義
    address nftContractAddress;
    address tokenContractAddress;
    IKnowledgeNFT private nftContract;
    IKnowledgeToken private tokenContract;

    // インセンティブ量のパラメータ定義
    uint256 amountForCreateKnowledge;
    uint256 amountForViewerAtViewing;
    uint256 amountForCreaterAtViewing;

    // コンストラクタ
    constructor(address _nftContractAddress, address _tokenContractAddress) {
        // ナレッジNFT用コントラクトとトークン用コントラクトとの接続
        nftContractAddress = _nftContractAddress;
        tokenContractAddress = _tokenContractAddress;
        nftContract = IKnowledgeNFT(nftContractAddress);
        tokenContract = IKnowledgeToken(tokenContractAddress);

        // インセンティブ量のデフォルト値の設定
        amountForCreateKnowledge = 20;
        amountForViewerAtViewing = 5;
        amountForCreaterAtViewing = 10;
    }

    // ナレッジの作成
    function createKnowledge(string memory knowledge) public {
        uint256 amount = amountForCreateKnowledge * 10 ** tokenContract.decimals();
        nftContract.createKnowlegde(msg.sender, knowledge);
        tokenContract.reward(msg.sender, amount);
    }

    // ナレッジの参照
    function getKnowledge(uint256 tokenId) public view returns (string memory) {
        return nftContract.getKnowledge(tokenId);
    }

    // ナレッジのオーナーアカウントの取得
    function getKnowledgeOwner(uint256 tokenId) public view returns (address) {
        return nftContract.ownerOf(tokenId);
    }

    // ナレッジ閲覧に伴うインセンティブの付与
    function rewardAtViewing(uint256 tokenId) public {
        tokenContract.reward(msg.sender, amountForViewerAtViewing * 10 ** tokenContract.decimals());
        rewardForKnowledge(tokenId, amountForCreaterAtViewing);
    }

    // ナレッジを指定したインセンティブの付与
    function rewardForKnowledge(uint256 tokenId, uint256 amount) public {
        address ownerAddress = nftContract.ownerOf(tokenId);
        tokenContract.reward(ownerAddress, amount * 10 ** tokenContract.decimals());
    }
}
