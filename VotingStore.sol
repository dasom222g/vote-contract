// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract VotingStore {

    struct Candidate {
        uint256 id;
        bytes32 name;
        bytes32 description;
        bytes32 imageName;
    }

    struct VotingStatus {
        uint256 id;
        bytes32 name;
        uint256 count;
    }

    // data
    Candidate[] public candidates;
    uint256 public id = 0;
    mapping(uint256 => uint256) public votingMap;

    constructor() {}

    // fuction
    function setCandidates(Candidate[] memory _candidates) public {
        for(uint256 i = 0; i < _candidates.length; i++) {
            candidates.push(_candidates[i]);
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
}