pragma solidity ^0.4.18;

import "./SmartToken.sol";


contract EvidentProofToken is SmartToken {

    //
    string public name = "Evident Proof Token";

    //
    string public symbol = "EVP";

    //
    uint8 public decimals = 18;
    // 400,000,000 tokens with 18 decimal places
    //    uint256 public INITIAL_SUPPLY = 3.65e9 * (10 ** uint256(decimals));
    //    uint256 public INITIAL_SUPPLY = 3.65e4 * (10 ** uint256(decimals));
    uint256 public INITIAL_SUPPLY = 1000;
    uint256 public MAX_SUPPLY = 4e8;
    
    /**
     * @dev Constructor that gives msg.sender all of existing tokens.
     */
    function EvidentProofToken()
    public
    SmartToken(name, symbol, decimals) CappedToken(MAX_SUPPLY) {
        owner = msg.sender;
        totalSupply_ = INITIAL_SUPPLY;
        balances[msg.sender] = INITIAL_SUPPLY;
        Transfer(0x0, owner, INITIAL_SUPPLY);
        NewSmartToken(address(this));
    }

    function deposit() payable returns (bool success) {
        if (msg.value == 0) return false;
        balances[msg.sender] += msg.value;
        totalSupply_ += msg.value;
        return true;
    }
}
