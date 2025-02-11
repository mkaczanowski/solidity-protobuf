pragma solidity <0.9.0;

import "./libs/test_repeated.sol";

contract TestRepeatedPB {
  mapping(address => bytes) public contracts;

  function getTestRepeatedString(address key) public view returns (string memory) {
    bytes storage location = contracts[key];
    bytes memory encoded = ProtoBufRuntime.decodeStorage(location);
    TestRepeated.Data memory data = TestRepeated.decode(encoded);
    return data.string_field;
  }

  function getTestRepeatedBool(address key) public view returns (bool) {
    bytes storage location = contracts[key];
    bytes memory encoded = ProtoBufRuntime.decodeStorage(location);
    TestRepeated.Data memory data = TestRepeated.decode(encoded);
    return data.bool_field;
  }

  function getTestRepeatedUint256(address key) public view returns (uint[] memory) {
    bytes storage location = contracts[key];
    bytes memory encoded = ProtoBufRuntime.decodeStorage(location);
    TestRepeated.Data memory data = TestRepeated.decode(encoded);
    return data.uint256s;
  }

  function getTestRepeatedInt64(address key) public view returns (int64[] memory) {
    bytes storage location = contracts[key];
    bytes memory encoded = ProtoBufRuntime.decodeStorage(location);
    TestRepeated.Data memory data = TestRepeated.decode(encoded);
    return data.sint64s;
  }

  function storeTestRepeated(address key, string memory string_field,
    uint256[] memory uint256s, int64[] memory sint64s,
    bool bool_field) public {
      TestRepeated.Data memory data = TestRepeated.Data({string_field: string_field, uint256s: uint256s,
        sint64s: sint64s, bool_field: bool_field});
      bytes memory encoded = TestRepeated.encode(data);
      ProtoBufRuntime.encodeStorage(contracts[key], encoded);
  }
}
