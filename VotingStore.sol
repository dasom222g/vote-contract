// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import"./DataType.sol";

contract VotingStore is DataType {

    // data
    Candidate[] public candidates;
    uint256 public id;
    mapping(uint256 => uint256) public votingMap;

    uint256[] public idList;

    constructor() {
        id = 0;
    }

    // fuction
    function setCandidates(Candidate[] memory _candidates) public {
        for(uint256 i = 0; i < _candidates.length; i++) {
            candidates.push(_candidates[i]);
            idList.push(_candidates[i].id);
        }
    }

    function getCandidates() public view returns(Candidate[] memory) {
        return candidates;
    }

    function getCurrentId() public view returns (uint256) {
        return id;
    }

    function setVotingMap(uint256 _key, uint256 _value) public {
        votingMap[_key] = _value;
    }

    function getCountById(uint256 _id) public view returns(uint256) {
        return votingMap[_id];
    }

    function getIdListLength() public view returns(uint256) {
        return idList.length;
    }
    function getIdList() public view returns(uint256[] memory) {
        return idList;
    }
    
}