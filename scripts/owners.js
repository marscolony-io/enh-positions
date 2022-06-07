const fs = require('fs');

const GM = artifacts.require('NFTMintableInterface');

module.exports = async (callback) => {
  const mc = await GM.at('0xe17dbc6dfba05783554955d3bc34bfbadf6a1dfe'); // bsc mc
  const allTokens = await mc.allTokens();
  // console.log(allTokens);
  const addresses = new Set();
  const whales = new Map();
  for (const tokenId of allTokens) {
    const owner = await mc.ownerOf(tokenId);
    addresses.add(owner);
    whales.set(owner, (whales.get(owner) ?? 0) + 1);
    if (owner!=='0x4e9A024d53D7E7d4E64a5d958F8F72Eb2857d334')
    console.log(+tokenId, owner)
  }
  console.log([...addresses]);
  console.log([...whales.entries()].map(([a, b]) => `${a},${b}`).join('\n'));
  // fs.writeFileSync(
  //   './avatar-owners.csv', 
  //   'address;owns\n' + Array.from(whales.entries()).map(x => `${x[0]};${x[1]}`).join('\n')
  // );
  callback();
};
