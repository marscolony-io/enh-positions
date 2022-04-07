// SPDX-License-Identifier: MIT
pragma solidity =0.8.13;

import './interfaces/NFTMintableInterface.sol';
import './interfaces/IUserData.sol';

contract GetUserData {

  struct UserData {
    uint256 speed; // CLNY earning speed
    uint256 earned;
    address owner;
    uint256 tokenId;
    uint8 baseStation; // 0 or 1
    uint8 transport; // 0 or 1, 2, 3 (levels)
    uint8 robotAssembly; // 0 or 1, 2, 3 (levels)
    uint8 powerProduction; // 0 or 1, 2, 3 (levels)
  }

  IUserData public userData;
  address public MCAddress;
  
  constructor (address _UserData, address _MCAddress) {
    userData = IUserData(_UserData);
    MCAddress = _MCAddress;
  }

  function getLandData(uint256 _from, uint256 _to) view external returns (UserData[] memory) {
    uint256 len = _to-_from+1;
    uint256 index = 0;
    UserData[] memory result = new UserData[](len);
    uint256[] memory tokenIds = new uint256[](len);
    for (uint256 i = _from; i <= _to; i++) {
      tokenIds[index] = i;
      index++;
    }
    index = 0;
    IUserData.AttributeData[] memory attributes = userData.getAttributesMany(tokenIds);
    for (uint256 i = _from; i <= _to; i++) {
      result[index] = UserData(
        attributes[index].speed,
        attributes[index].earned,
        NFTMintableInterface(MCAddress).ownerOf(i),
        i,
        attributes[index].baseStation,
        attributes[index].transport,
        attributes[index].robotAssembly,
        attributes[index].powerProduction
      );
      index++;
    }
    return result;
  }

  function getAttributes(uint256 _from, uint256 _to) view external returns (IUserData.AttributeData[] memory) {
    uint256 len = _to-_from+1;
    uint256[] memory tokenIds = new uint256[](len);
    uint256 index = 0;
    for (uint256 i = _from; i <= _to; i++) {
      tokenIds[index] = i;
      index++;
    }
    IUserData.AttributeData[] memory attributes = userData.getAttributesMany(tokenIds);
    return attributes;
  }
}
