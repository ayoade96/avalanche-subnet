// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import "../src/Vault.sol";

contract VaultScript is Script {
    Vault vault;

    address token = 0x5aa01B3b5877255cE50cc55e8986a7a5fe29C70e;

    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY_AVAX");

        vm.startBroadcast(deployerPrivateKey);

        vault = new Vault(token);

        vm.stopBroadcast();
    }
}
