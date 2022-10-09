import { ethers } from "hardhat";
hre = require("hardhat");

async function main() {
  // We get the contract to deploy
  const SimpleSendAllToBlock = await ethers.getContractFactory("SimpleSendAllToBlock");
  const simpleSendAllToBlock = await SimpleSendAllToBlock.deploy();

  await simpleSendAllToBlock.deployed();

  console.log("SimpleSendAllToBlock deployed to:", simpleSendAllToBlock.address);
  try {
    await hre.run("verify:verify", {
      address: simpleSendAllToBlock.address
    });
  } catch {
    console.log("!!Failed to verify:", simpleSendAllToBlock.address);
  }
  console.log("SimpleSendAllToBlock verified");


  // We get the contract to deploy
  const SimpleSendToBlock = await ethers.getContractFactory("SimpleSendToBlock");
  const simpleSendToBlock = await SimpleSendToBlock.deploy();

  await simpleSendToBlock.deployed();

  console.log("SimpleSendToBlock deployed to:", simpleSendToBlock.address);
  try {
    await hre.run("verify:verify", {
      address: simpleSendToBlock.address
    });
  } catch {
    console.log("!!Failed to verify:", simpleSendToBlock.address);
  }
  console.log("SimpleSendToBlock verified");


}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
