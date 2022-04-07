// SPDX-License-Identifier: MIT
pragma solidity =0.8.13;


interface NFTMintableInterface {
  function ownerOf(uint256 tokenId) external view returns (address owner);
}