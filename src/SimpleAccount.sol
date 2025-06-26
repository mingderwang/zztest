// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SimpleAccount {
    address public owner;

    constructor(address _owner) {
        owner = _owner;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    // Allows the owner to transfer ERC20 tokens held by this contract to another address
    function transferERC20(address token, address to, uint256 amount) external onlyOwner {
        require(IERC20(token).transfer(to, amount), "Transfer failed");
    }

    // Allow the contract to receive ether (optional)
    receive() external payable {}
}
