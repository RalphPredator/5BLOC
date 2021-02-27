const ImmoDity = artifacts.require("tokenhelper")

const tokens = [["token1","france",129,"https://cdn.pixabay.com/photo/2016/11/08/05/11/umbrella-1807513__480.jpg"],["token2","france",128,"https://cdn.pixabay.com/photo/2016/11/08/05/11/umbrella-1807513__480.jpg"],["token3","france",148,"https://cdn.pixabay.com/photo/2016/11/08/05/11/umbrella-1807513__480.jpg"]]

contract('Immodity token helper', (accounts) => {
  let [ben, alice] = accounts

  beforeEach(async () => {
    contractInstance = await ImmoDity.new();
  });

  context("create token and put online", async ()=>{

	  it('should be create and put token online', async () => {
	    const result = await contractInstance.createToken(tokens[0][0], tokens[0][1], tokens[0][2], tokens[0][3], {from: ben});
	    const tokenId = result.logs[0].args.tokenId.toNumber();

	    await contractInstance.setTokenOnline(tokenId, {from: ben});

	    const tokenOnline = await contractInstance.tokens(tokenId);

	    assert.equal(tokenOnline.state, true);
	  });

	  it('should be create and put token offline', async () => {
	    const result = await contractInstance.createToken(tokens[0][0], tokens[0][1], tokens[0][2], tokens[0][3], {from: ben});
	    const tokenId = result.logs[0].args.tokenId.toNumber();

	    await contractInstance.setTokenOnline(tokenId, {from: ben});

	    const tokenOnline = await contractInstance.tokens(tokenId);


	    await contractInstance.setTokenOffline(tokenId, {from: ben});

	    const tokenOffline = await contractInstance.tokens(tokenId);

	    assert.equal(tokenOnline.state, true);
	    assert.equal(tokenOffline.name,tokens[0][0]);
	    assert.equal(tokenOffline.state, false);
	  });

	  it('should be create three token and check if two is online', async () => {
	    var result1 = await contractInstance.createToken(tokens[0][0], tokens[0][1], tokens[0][2], tokens[0][3], {from: ben});
	    var result2 = await contractInstance.createToken(tokens[1][0], tokens[1][1], tokens[1][2], tokens[1][3], {from: ben});
	    var result3 = await contractInstance.createToken(tokens[2][0], tokens[2][1], tokens[2][2], tokens[2][3], {from: ben});

	    const token1 = result1.logs[0].args.tokenId.toNumber();
	    const token2 = result2.logs[0].args.tokenId.toNumber();
	    const token3 = result3.logs[0].args.tokenId.toNumber();

	    await contractInstance.setTokenOnline(token1, {from: ben});
	    await contractInstance.setTokenOnline(token3, {from: ben});

	    const token = await contractInstance.getTokensByOwner(ben);


	    const tokenOnline1 = await contractInstance.tokens(token1);
	    const tokenOnline2 = await contractInstance.tokens(token3);
	    const tokenOnline3 = await contractInstance.tokens(token2);

	    assert.equal(tokenOnline1.state, true);
	    assert.equal(tokenOnline2.state, true);
	    assert.equal(tokenOnline3.state, false);
	  });

  });

  context("Get all token create by all user", async ()=>{

  	it('create token for ben and alice and return them with function', async () => {
  		const result = await contractInstance.createToken(tokens[0][0], tokens[0][1], tokens[0][2], tokens[0][3], {from: ben});
  		const result1 = await contractInstance.createToken(tokens[1][0], tokens[1][1], tokens[1][2], tokens[1][3], {from: alice});

  		const rs = await contractInstance.getAllTokens()
  		const rs1 = await contractInstance.getTokensByOwner(ben)

  		assert.equal(rs.length, 2);
  		assert.equal(rs1.length, 1);

  	})

  });

});
