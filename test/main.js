const { expect } = require("chai");

const GetCoords = artifacts.require("GetCoords");
const GameManager = artifacts.require("GameManagerMock");

function toObject (obj) {
  return {
    x: Number(obj.x),
    y: Number(obj.y)
  }
}

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */


contract("main", function (/* accounts */) {
  let getCoords;
  let gameManager;
  before(async function () {
    getCoords = await GetCoords.deployed()
    gameManager = await GameManager.deployed()
  })

  it("Right coordinates 1", async function () {
    await gameManager.setCoords(1, 6, 5, 6, 5, 6, 5, 6, 5)
    const coords = await getCoords.getCoord(1)
    expect(toObject(coords.base)).to.be.eql({ x: 6, y: 5 })
    expect(toObject(coords.transport)).to.be.eql({ x: 6, y: 3 })
    expect(toObject(coords.robot)).to.be.eql({ x: 6, y: 4 })
    expect(toObject(coords.power)).to.be.eql({ x: 5, y: 4 })
  })

  it("Right coordinates 2", async function () {
    await gameManager.setCoords(1, 1, 5, 6, 3, 6, 4, 6, 5)
    const coords = await getCoords.getCoord(1)
    expect(toObject(coords.base)).to.be.eql({ x: 6, y: 5 })
    expect(toObject(coords.transport)).to.be.eql({ x: 6, y: 3 })
    expect(toObject(coords.robot)).to.be.eql({ x: 6, y: 4 })
    expect(toObject(coords.power)).to.be.eql({ x: 5, y: 4 })
  })

  it("Is zero", async function () {
    await gameManager.setCoords(1, 0, 0, 0, 0, 0, 0, 0, 0)
    const coords = await getCoords.getCoord(1)
    expect(toObject(coords.base)).to.be.eql({ x: 0, y: 0 })
    expect(toObject(coords.transport)).to.be.eql({ x: 0, y: 0 })
    expect(toObject(coords.robot)).to.be.eql({ x: 0, y: 0 })
    expect(toObject(coords.power)).to.be.eql({ x: 0, y: 0 })
  })

  it("Out of range", async function () {
    await gameManager.setCoords(1, 99, 99, 0, 0, 0, 0, 0, 0)
    const coords = await getCoords.getCoord(1)
    expect(toObject(coords.base)).to.be.eql({ x: 6, y: 5 })
    expect(toObject(coords.transport)).to.be.eql({ x: 0, y: 0 })
    expect(toObject(coords.robot)).to.be.eql({ x: 0, y: 0 })
    expect(toObject(coords.power)).to.be.eql({ x: 0, y: 0 })
  })
});
