// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract GameManagerMock {

  struct PlaceOnLand {
    uint32 x;
    uint32 y;
  }
  mapping (uint256 => PlaceOnLand) public baseStationsPlacement;
  mapping (uint256 => PlaceOnLand) public transportPlacement;
  mapping (uint256 => PlaceOnLand) public robotAssemblyPlacement;
  mapping (uint256 => PlaceOnLand) public powerProductionPlacement;

  function setCoords(uint tokenId, uint32 baseX, uint32 baseY, uint32 transX, uint32 transY, uint32 roboX, uint32 roboY, uint32 powX, uint32 powY) external {
    baseStationsPlacement[tokenId].x = baseX;
    baseStationsPlacement[tokenId].y = baseY;
    transportPlacement[tokenId].x = transX;
    transportPlacement[tokenId].y = transY;
    robotAssemblyPlacement[tokenId].x = roboX;
    robotAssemblyPlacement[tokenId].y = roboY;
    powerProductionPlacement[tokenId].x = powX;
    powerProductionPlacement[tokenId].y = powY;
  }
}
