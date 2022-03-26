// SPDX-License-Identifier: MIT
pragma solidity =0.8.13;

import "./IGameManager.sol";

contract GetCoords {

  struct Coordinates {
    IGameManager.PlaceOnLand base;
    IGameManager.PlaceOnLand transport;
    IGameManager.PlaceOnLand robot;
    IGameManager.PlaceOnLand power;
  }

  IGameManager public gameManager;
  
  constructor (address _GameManager) {
    gameManager = IGameManager(_GameManager);
  }

  function getCoord(uint256 tokenId) view external returns (Coordinates memory) {
    IGameManager.PlaceOnLand memory base = gameManager.baseStationsPlacement(tokenId);
    IGameManager.PlaceOnLand memory transport = gameManager.transportPlacement(tokenId);
    IGameManager.PlaceOnLand memory robot = gameManager.robotAssemblyPlacement(tokenId);
    IGameManager.PlaceOnLand memory power = gameManager.powerProductionPlacement(tokenId);
    return Coordinates(base, transport, robot, power);
  }

}
