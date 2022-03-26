// SPDX-License-Identifier: MIT
pragma solidity =0.8.13;

interface IGameManager {
  struct PlaceOnLand {
    uint32 x;
    uint32 y;
  }
  function baseStationsPlacement(uint256 tokenId) view external returns (PlaceOnLand memory);
  function transportPlacement(uint256 tokenId) view external returns (PlaceOnLand memory);
  function robotAssemblyPlacement(uint256 tokenId) view external returns (PlaceOnLand memory);
  function powerProductionPlacement(uint256 tokenId) view external returns (PlaceOnLand memory);
}
