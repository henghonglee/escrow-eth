pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Escrow {
    enum PaymentStatus {Pending, Completed, Refunded}
    ERC20 public currencyX;
    ERC20 public currencyY;
    uint256 public amountX;
    uint256 public amountY;
    address public payerAddress;
    address public payeeAddress;

    event Supply(address sender, ERC20 currency, uint256 amount);

    constructor(
        address _currencyX,
        address _currencyY,
        uint256 _amountX,
        uint256 _amountY,
        address _payerAddress,
        address _payeeAddress
    ) {
        currencyX = ERC20(_currencyX);
        currencyY = ERC20(_currencyY);
        payerAddress = _payerAddress;
        payeeAddress = _payeeAddress;
        amountX = _amountX;
        amountY = _amountY;
    }

    // Requires appproval that the contract can spend the tokens for the supplying user before callng this method
    function supply() public {
        require(msg.sender == payerAddress || msg.sender == payeeAddress);

        ERC20 token = msg.sender == payerAddress ? currencyX : currencyY;
        uint256 amount = msg.sender == payerAddress ? amountX : amountY;

        require(amount < token.balanceOf(msg.sender)); // only proceed if user has enough to supply
        require(token.balanceOf(address(this)) == 0); // only proceed if token X has not been filled by alice

        token.transferFrom(msg.sender, address(this), amount);
        emit Supply(msg.sender, token, amount);
    }

    // if both sides have paid ,this method will transfer the tokens from the escrow account to their accounts respectively
    function release() public {
        require(currencyX.balanceOf(address(this)) == amountX);
        require(currencyY.balanceOf(address(this)) == amountY);
        currencyX.transfer(payeeAddress, amountX);
        currencyY.transfer(payerAddress, amountY);
    }

    function reject() public {
        // TODO:
        // at any point should someone back out they can get back their tokens before the other party supplies theirs
    }
}
