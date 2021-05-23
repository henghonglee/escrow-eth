# Simple escrow program with Solidity

this program uses truffle, ganache

```
truffle compile
truffle migrate

// Setup
// using metamask send over 1 coinx to account[1] and 1 coiny to account[2]
// 
// Test
truffle console
> alice = accounts[1]
> bob = accounts[2]
> coinx = await CoinX.deployed();
> coiny = await CoinY.deployed();
> escrow_factory = await EscrowFactory.deployed();
> escrow_factory.initEscrow(coinx.address, coiny.address, 1, 1, bob, {from: alice}) // initialize the escrow with alice
> escrow = await Escrow.at('0x....')
> coinx.approve(escrow.address, 1, {from: alice})
> coiny.approve(escrow.address, 1, {from: bob})
> escrow.supply({from: alice})
> escrow.supply({from: bob})
> escrow.release({from: alice})

1
