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

  struct Avatars {
    address owner;
    string name;
  }

  IUserData public userData;
  IUserData public MColonists;
  address public MCAddress;
  
  constructor (address _UserData, address _MCAddress, address _MColonists) {
    userData = IUserData(_UserData);
    MCAddress = _MCAddress;
    MColonists = IUserData(_MColonists);
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

  function getAvatarData(uint256 from, uint256 to) view external returns (Avatars[] memory) {
    Avatars[] memory result = new Avatars[](to-from+1);
    for (uint i = from; i <= to; i++) {
      result[i-from] = Avatars(
        MColonists.ownerOf(i),
        MColonists.names(i)
      );
    }
    return result;
  }
}