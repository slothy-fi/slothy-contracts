import { ethers } from "hardhat";

async function main() {
  // We get the contract to deploy
  const SuperfluidStreamReceiverBlock = await ethers.getContractFactory("SuperfluidStreamReceiverBlock");
  const superfluidStreamReceiverBlock = await SuperfluidStreamReceiverBlock.deploy();

  await superfluidStreamReceiverBlock.deployed();

  console.log("SuperfluidStreamReceiverBlock deployed to:", superfluidStreamReceiverBlock.address);
  


  // We get the contract to deploy
  const SuperfluidUnwrapAllTokenBlock = await ethers.getContractFactory("SuperfluidUnwrapAllTokenBlock");
  const superfluidUnwrapAllTokenBlock = await SuperfluidUnwrapAllTokenBlock.deploy();

  await superfluidUnwrapAllTokenBlock.deployed();

  console.log("SuperfluidUnwrapAllTokenBlock deployed to:", superfluidUnwrapAllTokenBlock.address);
  

  // We get the contract to deploy
  const SuperfluidUnwrapPercentTokenBlock = await ethers.getContractFactory("SuperfluidUnwrapPercentTokenBlock");
  const superfluidUnwrapPercentTokenBlock = await SuperfluidUnwrapPercentTokenBlock.deploy();

  await superfluidUnwrapPercentTokenBlock.deployed();

  console.log("SuperfluidUnwrapPercentTokenBlock deployed to:", superfluidUnwrapPercentTokenBlock.address);
  


}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
