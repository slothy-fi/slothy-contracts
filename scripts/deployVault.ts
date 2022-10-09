import { ethers } from "hardhat";
hre = require("hardhat");

async function main() {
  // We get the contract to deploy
  const SlothyVaultFactory = await ethers.getContractFactory("SlothyVaultFactory");
  const slothyVaultFactory = await SlothyVaultFactory.deploy();

  await slothyVaultFactory.deployed();

  console.log("SlothyVault deployed to:", slothyVaultFactory.address);
  try {
    await hre.run("verify:verify", {
      address: slothyVaultFactory.address
    });
  } catch {
    console.log("!!Failed to verify:", slothyVaultFactory.address);
  }
  console.log("SlothyVault verified");

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
