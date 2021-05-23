pragma solidity ^0.8.0;

import "./Escrow.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract EscrowFactory {
    event Init(
        address escrow_contract,
        address currencyX,
        address currencyY,
        uint256 amtCurrencyX,
        uint256 amtCurrencyY
    );

    Escrow[] public escrows;

    function InitEscrow(
        address _currencyX,
        address _currencyY,
        uint256 _amtCurrencyX,
        uint256 _amtCurrencyY,
        address _bobAddress
    ) public {
        escrow = new Escrow(
            _currencyX,
            _currencyY,
            _amtCurrencyX,
            _amtCurrencyY,
            msg.sender,
            _bobAddress
        );
        escrows.push(escrow);
        emit Init(
            address(escrow),
            _currencyX,
            _currencyY,
            _amtCurrencyX,
            _amtCurrencyY
        );
    }
}
