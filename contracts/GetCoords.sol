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
    IGameManager.PlaceOnLand[15] memory rightPlaces = [
      IGameManager.PlaceOnLand(6, 5),
      IGameManager.PlaceOnLand(6, 3),
      IGameManager.PlaceOnLand(6, 4),
      IGameManager.PlaceOnLand(5, 4),
      IGameManager.PlaceOnLand(5, 3),
      IGameManager.PlaceOnLand(5, 2),
      IGameManager.PlaceOnLand(4, 2),
      IGameManager.PlaceOnLand(4, 3),
      IGameManager.PlaceOnLand(3, 2),
      IGameManager.PlaceOnLand(7, 3),
      IGameManager.PlaceOnLand(7, 4),
      IGameManager.PlaceOnLand(8, 4),
      IGameManager.PlaceOnLand(8, 3),
      IGameManager.PlaceOnLand(8, 2),
      IGameManager.PlaceOnLand(7, 2)
    ];
    bool [9][9] memory rightPlacesMatrix;
    for (uint256 i = 0; i<rightPlaces.length; i++) {
      rightPlacesMatrix[rightPlaces[i].x][rightPlaces[i].y] = true;
    }
    IGameManager.PlaceOnLand memory base = gameManager.baseStationsPlacement(tokenId);
    IGameManager.PlaceOnLand memory transport = gameManager.transportPlacement(tokenId);
    IGameManager.PlaceOnLand memory robot = gameManager.robotAssemblyPlacement(tokenId);
    IGameManager.PlaceOnLand memory power = gameManager.powerProductionPlacement(tokenId);
    IGameManager.PlaceOnLand[4] memory coordinates = [
      base,
      transport,
      robot,
      power
    ];
    for (uint256 i = 0; i < coordinates.length; i++) {
      if (coordinates[i].x == 0 && coordinates[i].y == 0) {
        continue;
      }
      if (
        coordinates[i].x < rightPlacesMatrix.length &&
        coordinates[i].y < rightPlacesMatrix[0].length &&
        rightPlacesMatrix[coordinates[i].x][coordinates[i].y] == true
      ) {
        rightPlacesMatrix[coordinates[i].x][coordinates[i].y] = false;
      } else {
        for (uint256 j = 0; j < rightPlaces.length; j++) {
          if (rightPlacesMatrix[rightPlaces[j].x][rightPlaces[j].y] == true) {
            rightPlacesMatrix[rightPlaces[j].x][rightPlaces[j].y] = false;
            coordinates[i].x = rightPlaces[j].x;
            coordinates[i].y = rightPlaces[j].y;
            break;
          }
        }
      }
    }
    return Coordinates(coordinates[0], coordinates[1], coordinates[2], coordinates[3]);
  }

}
