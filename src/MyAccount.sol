// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.27;

import {Account} from "@openzeppelin/community-contracts/account/Account.sol";
import {EIP712} from "@openzeppelin/contracts/utils/cryptography/EIP712.sol";
import {ERC1155Holder} from "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import {ERC721Holder} from "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import {ERC7739} from "@openzeppelin/community-contracts/utils/cryptography/signers/ERC7739.sol";
import {Initializable} from "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import {SignerP256} from "@openzeppelin/community-contracts/utils/cryptography/signers/SignerP256.sol";

/// @custom:oz-upgrades-unsafe-allow constructor
contract MyAccount is Initializable, Account, EIP712, ERC7739, SignerP256, ERC721Holder, ERC1155Holder {

    constructor() EIP712("MyAccount", "1") {
        _disableInitializers();
    }

    function initializeP256(bytes32 qx, bytes32 qy) public initializer {
        _setSigner(qx, qy);
    }
}
