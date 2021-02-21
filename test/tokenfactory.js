const ImmoDity = artifacts.require("tokenfactory")

const tokens = [["token1","france",129,"https://cdn.pixabay.com/photo/2016/11/08/05/11/umbrella-1807513__480.jpg"],["token2","france",128,"https://cdn.pixabay.com/photo/2016/11/08/05/11/umbrella-1807513__480.jpg"],["token3","france",148,"https://cdn.pixabay.com/photo/2016/11/08/05/11/umbrella-1807513__480.jpg"]]

contract('Immodity token factory', (accounts) => {
  let [ben] = accounts

  beforeEach(async () => {
    contractInstance = await ImmoDity.new();
  });

  it('should be able to create new token', async () => {
    const result = await contractInstance.createToken(tokens[0][0], tokens[0][1], tokens[0][2], tokens[0][3], {from: ben});

    assert.equal(result.receipt.status, true);
    assert.equal(result.logs[0].args.name,tokens[0][0]);
  });

  it('should be able to a second token', async () => {
    const result = await contractInstance.createToken(tokens[0][0], tokens[0][1], tokens[0][2], tokens[0][3], {from: ben});

    assert.equal(result.receipt.status, true);
  });

});
