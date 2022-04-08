// SPDX-License-Identifier: MIT
pragma solidity =0.8.13;

import '@openzeppelin/contracts/token/ERC721/IERC721.sol';

interface IUserData is IERC721 {
  struct AttributeData {
    uint256 speed; // CLNY earning speed
    uint256 earned;
    uint8 baseStation; // 0 or 1
    uint8 transport; // 0 or 1, 2, 3 (levels)
    uint8 robotAssembly; // 0 or 1, 2, 3 (levels)
    uint8 powerProduction; // 0 or 1, 2, 3 (levels)
  }
  function getAttributesMany(uint256[] calldata tokenIds) external view returns (AttributeData[] memory);
  function names (uint256 tokenId) view external returns (string memory);
}
