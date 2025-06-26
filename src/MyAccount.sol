// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {Account} from "@openzeppelin/community-contracts/account/Account.sol";
import {EIP712} from "@openzeppelin/contracts/utils/cryptography/EIP712.sol";
import {SignerP256} from "@openzeppelin/community-contracts/utils/cryptography/signers/SignerP256.sol";
import {Initializable} from "@openzeppelin/contracts/proxy/utils/Initializable.sol";

/// @custom:oz-upgrades-unsafe-allow constructor
contract MyAccount is Initializable, Account, EIP712, SignerP256 {
    constructor() EIP712("MyAccount", "1") {
        _disableInitializers();
    }

    function initializeP256(bytes32 qx, bytes32 qy) public initializer {
        _setSigner(qx, qy);
    }
}