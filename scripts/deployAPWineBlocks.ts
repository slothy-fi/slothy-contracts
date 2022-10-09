import { ethers } from "hardhat";

async function main() {
  // We get the contract to deploy
  // const ApwineDepositBlock = await ethers.getContractFactory("ApwineDepositBlock");
  // const apwineDepositBlock = await ApwineDepositBlock.deploy();

  // await apwineDepositBlock.deployed();

  // console.log("ApwineDepositBlock deployed to:", apwineDepositBlock.address);
  


  // We get the contract to deploy
  const ApwineRedeemBlock = await ethers.getContractFactory("ApwineRedeemBlock");
  const apwineRedeemBlock = await ApwineRedeemBlock.deploy();

  await apwineRedeemBlock.deployed();

  console.log("ApwineRedeemBlock deployed to:", apwineRedeemBlock.address);
  

  // We get the contract to deploy
  const ApwineSwapUnderlyingForPTBlock = await ethers.getContractFactory("ApwineSwapUnderlyingForPTBlock");
  const apwineSwapUnderlyingForPTBlock = await ApwineSwapUnderlyingForPTBlock.deploy();

  await apwineSwapUnderlyingForPTBlock.deployed();

  console.log("ApwineSwapUnderlyingForPTBlock deployed to:", apwineSwapUnderlyingForPTBlock.address);
  


}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
