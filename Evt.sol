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
    
    Token token;
    mapping (address => uint) tokenBalanceForAddress;
    address tokenWalletAddress;
    
    //////////////////////
    //     FUNCTIONS    //
    //////////////////////
    function addData(string key, string value, uint dispatchId) {
        require(tokenBalanceForAddress[msg.sender] >= 1);
        require(tokenBalanceForAddress[msg.sender] - 1 <= tokenBalanceForAddress[msg.sender]);
        require(tokenBalanceForAddress[tokenWalletAddress] + 1 >= tokenBalanceForAddress[tokenWalletAddress]);
        tokenBalanceForAddress[tokenWalletAddress] += 1;
        tokenBalanceForAddress[msg.sender] -= 1;
        
        require(records_length + 1 > records_length);
        records_length++;
        records[records_length].value = value;
        records[records_length].key = key;
        records[records_length].dispatchId = dispatchId;
        
        require(tokenBalanceForAddress[tokenWalletAddress] >= 1);
        require(tokenBalanceForAddress[tokenWalletAddress] - 1 <= tokenBalanceForAddress[tokenWalletAddress]);
        require(tokenBalanceForAddress[msg.sender] + 1 >= tokenBalanceForAddress[msg.sender]);
        tokenBalanceForAddress[tokenWalletAddress] -= 1;
        tokenBalanceForAddress[msg.sender] += 1;
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
    function setTokenWalletAddress(address _address) {
        require(_address != address(0));
        tokenWalletAddress = _address;
    }
    
    function setToken(string symbolName, address erc20TokenAddress) {
        token.symbolName = symbolName;
        token.tokenContract = erc20TokenAddress;
    }
    
    function depositToken(uint amount) {
        ERC20Interface tokenInstance = ERC20Interface(token.tokenContract);
        require(tokenInstance.transferFrom(msg.sender, address(this), amount) == true);
        require(tokenBalanceForAddress[msg.sender] + amount >= tokenBalanceForAddress[msg.sender]);
        tokenBalanceForAddress[msg.sender] += amount;
    }

    function withdrawToken(uint amount) {
        ERC20Interface tokenInstance = ERC20Interface(token.tokenContract);

        require(tokenBalanceForAddress[msg.sender] - amount >= 0);
        require(tokenBalanceForAddress[msg.sender] - amount <= tokenBalanceForAddress[msg.sender]);

        tokenBalanceForAddress[msg.sender] -= amount;
        require(tokenInstance.transfer(msg.sender, amount) == true);
    }

    function getBalance() constant returns (uint) {
        return tokenBalanceForAddress[msg.sender];
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