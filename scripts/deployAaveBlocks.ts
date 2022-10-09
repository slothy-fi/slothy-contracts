import { ethers } from "hardhat";
hre = require("hardhat");

async function main() {
  // We get the contract to deploy
  const AaveSupplyBlock = await ethers.getContractFactory("AaveSupplyBlock");
  const aaveSupplyBlock = await AaveSupplyBlock.deploy();

  await aaveSupplyBlock.deployed();

  console.log("AaveSupplyBlock deployed to:", aaveSupplyBlock.address);
  try {
    await hre.run("verify:verify", {
      address: aaveSupplyBlock.address
    });
  } catch {
    console.log("!!Failed to verify:", aaveSupplyBlock.address);
  }
  console.log("AaveSupplyBlock verified");


  // We get the contract to deploy
  const AaveWithdrawAllBlock = await ethers.getContractFactory("AaveWithdrawAllBlock");
  const aaveWithdrawAllBlock = await AaveWithdrawAllBlock.deploy();

  await aaveWithdrawAllBlock.deployed();

  console.log("AaveWithdrawAllBlock deployed to:", aaveWithdrawAllBlock.address);
  try {
    await hre.run("verify:verify", {
      address: aaveWithdrawAllBlock.address
    });
  } catch {
    console.log("!!Failed to verify:", aaveWithdrawAllBlock.address);
  }
  console.log("AaveWithdrawAllBlock verified");

  // We get the contract to deploy
  const AaveWithdrawPercentageBlock = await ethers.getContractFactory("AaveWithdrawPercentageBlock");
  const aaveWithdrawPercentageBlock = await AaveWithdrawPercentageBlock.deploy();

  await aaveWithdrawPercentageBlock.deployed();

  console.log("AaveWithdrawPercentageBlock deployed to:", aaveWithdrawPercentageBlock.address);
  try {
    await hre.run("verify:verify", {
      address: aaveWithdrawPercentageBlock.address
    });
  } catch {
    console.log("!!Failed to verify:", aaveWithdrawPercentageBlock.address);
  }
  console.log("AaveWithdrawPercentageBlock verified");

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
