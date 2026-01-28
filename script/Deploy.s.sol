// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import { Script, console } from "forge-std/Script.sol";
import { Example } from "../contracts/Example.sol";

contract DeployScript is Script {
    // Ember Treasury address (receives fees)
    address constant FEE_RECIPIENT = 0xE3c938c71273bFFf7DEe21BDD3a8ee1e453Bdd1b;

    function setUp() public { }

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        Example example = new Example(FEE_RECIPIENT);

        console.log("Contract deployed at:", address(example));
        console.log("Fee recipient:", FEE_RECIPIENT);
        console.log("Owner:", example.owner());

        vm.stopBroadcast();
    }
}
