// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Script} from "forge-std/Script.sol";
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
import {AirToken} from "../src/AirToken.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DeployMerkleAirdrop is Script {
    bytes32 public ROOT =
        0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    uint256 public constant AMOUNT_TO_TRANSFER = 100e18;
    uint256 public constant AMOUNT_TO_CLAIM = 25e18;

    function deployMerkleAirdrop() public returns (MerkleAirdrop, AirToken) {
        vm.startBroadcast();
        AirToken token = new AirToken();
        MerkleAirdrop airdrop = new MerkleAirdrop(ROOT, IERC20(address(token)));
        token.mint(token.owner(), AMOUNT_TO_TRANSFER);
        token.transfer(address(airdrop), AMOUNT_TO_TRANSFER);
        vm.stopBroadcast();
        return (airdrop, token);
    }

    function run() external returns (MerkleAirdrop, AirToken) {
        return deployMerkleAirdrop();
    }
}
