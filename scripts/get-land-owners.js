const fs = require('fs');

const GetUserData = artifacts.require('GetUserData');

module.exports = async (callback) => {
  const getUserData = await GetUserData.at('0x7d90B751c0B88Ef90f3928e45D97d601cB5F0A4C');
  const addresses = new Set();
  const whales = new Map();
  for (let i = 1; i < 21000; i = i + 1000) { // last i - 20001
    const data = await getUserData.getAvatarData(i, i + 999); // you can change to getLandData
    for (const item of data) {
      addresses.add(item.owner);
      whales.set(item.owner, (whales.get(item.owner) ?? 0) + 1);
    }
  }
  console.log(whales);
  fs.writeFileSync(
    './avatar-owners.csv', 
    'address;owns\n' + Array.from(whales.entries()).map(x => `${x[0]};${x[1]}`).join('\n')
  );
  callback();
};
