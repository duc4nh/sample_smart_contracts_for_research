pragma solidity ^0.4.13;

import "github.com/willitscale/solidity-util/lib/Strings.sol";

contract GasPriceCompare {
    using Strings for string;
    
    string[] public data_batch;
    string[] public data;
    
    // fail for storing 100 entries
    // 0.001221244 Ether for just 10 entries (because of the "split" logic)
    function storeDataBatch(string _data_batch_string) public {
        data_batch = _data_batch_string.split(",");
    }
    
    // 0.000107841 Ether for 1 entry -> 100 transaction cost 100 times
    // 0.004586037 Ether for 100 entries, store 1 very long string
    function storeData(string _data) public {
        data.push(_data);
    }
}