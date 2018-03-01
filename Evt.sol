pragma solidity ^0.4.13;

import "./ERC20Interface.sol";

contract Evt {
    
    ///////////////////////
    // GENERAL STRUCTURE //
    ///////////////////////
    
    // Record
    struct Record {
        string value;
        string key;
        uint dispatchId;
    }

    mapping (uint => Record) records;
    uint records_length;
    
    // Token
    struct Token {
        address tokenContract;
        string symbolName;
    }
    mapping (uint8 => Token) tokens; // we support a max of 255 tokens...
    uint8 symbolNameIndex;
    
    //////////////////////
    //     FUNCTIONS    //
    //////////////////////
    function addData(string key, string value, uint dispatchId) returns (uint) {
        // uint8 symbolNameIndex = getSymbolIndexOrThrow(symbolName);
        // require(tokens[symbolNameIndex].tokenContract != address(0));
        // ERC20Interface token = ERC20Interface(tokens[symbolNameIndex].tokenContract);
        // require(token.transferFrom(msg.sender, address(this), 1) == true);
        // require(token.transfer(account_2, 1) == true);
        
        require(records_length + 1 > records_length);
        records_length++;
        records[records_length].value = value;
        records[records_length].key = key;
        records[records_length].dispatchId = dispatchId;
        
        // require(token.transferFrom(account_2, msg.sender, 1) == true);
        
        return records_length;
    }
    
    function searchByKey(string _key) constant returns (string, string, uint) {
        uint index = 0;
        for (uint i = 1; i <= records_length; i++) {
            if (stringsEqual(records[i].key, _key)) {
                index = i;
            }
        }
        require(index > 0);
        
        return (records[index].key, records[index].value, records[index].dispatchId);
    }

    //////////////////////
    // TOKEN MANAGEMENT //
    //////////////////////
    function addToken(string symbolName, address erc20TokenAddress) {
        require(!hasToken(symbolName));
        require(symbolNameIndex + 1 > symbolNameIndex);
        symbolNameIndex++;

        tokens[symbolNameIndex].symbolName = symbolName;
        tokens[symbolNameIndex].tokenContract = erc20TokenAddress;
    }

    function hasToken(string symbolName) constant returns (bool) {
        uint8 index = getSymbolIndex(symbolName);
        if (index == 0) {
            return false;
        }
        return true;
    }

    function getSymbolIndex(string symbolName) internal returns (uint8) {
        for (uint8 i = 1; i <= symbolNameIndex; i++) {
            if (stringsEqual(tokens[i].symbolName, symbolName)) {
                return i;
            }
        }
        return 0;
    }

    function getSymbolIndexOrThrow(string symbolName) returns (uint8) {
        uint8 index = getSymbolIndex(symbolName);
        require(index > 0);
        return index;
    }

    ////////////////////////////////
    // STRING COMPARISON FUNCTION //
    ////////////////////////////////
    function stringsEqual(string storage _a, string memory _b) internal returns (bool) {
        bytes storage a = bytes(_a);
        bytes memory b = bytes(_b);
        if (a.length != b.length) {
            return false;
        }
        // @todo unroll this loop
        for (uint i = 0; i < a.length; i ++) {
            if (a[i] != b[i]) {
                return false;
            }
        }
        return true;
    }
}