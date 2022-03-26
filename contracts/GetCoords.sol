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
  function getUnique(IGameManager.PlaceOnLand[4] memory  arr1, IGameManager.PlaceOnLand[15] memory  arr2, uint256 k, uint256 i) view private {
    bool flag = false;
    for (uint256 l = 0; l < arr1.length; l++) {
      if (arr1[l].x == arr2[k].x && arr1[l].y == arr2[k].y) {
        flag = true;
        break;
      }
    }
    if (flag == true) {
      k++;
      getUnique(arr1, arr2, k, i);
    } else {
      arr1[i].x = arr2[k].x;
      arr1[i].y = arr2[k].y;
    }
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
    uint256 k = 0;
    for (uint256 i = 0; i < coordinates.length; i++) {
      bool flag = false;
      for (uint256 j = 0; j < rightPlaces.length; j++) {
        if (coordinates[i].x == rightPlaces[j].x && coordinates[i].y == rightPlaces[j].y) {
          flag = true;
          break;
        } 
      }
      if (flag == false) {
        bool flag1 = false;
        for (uint256 j = 0; j < coordinates.length; j++) {
          if (coordinates[i].x == coordinates[j].x && coordinates[i].y == coordinates[j].y) {
            getUnique(coordinates, rightPlaces, k, i);
            flag1 = true;
          }
        }
        if (flag1 == false) {
          coordinates[i].x = rightPlaces[k].x;
          coordinates[i].y = rightPlaces[k].y;
        }
      }
    }
    return Coordinates(coordinates[0], coordinates[1], coordinates[2], coordinates[3]);
  }

}
