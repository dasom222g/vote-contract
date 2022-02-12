// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.7;

contract Vote {
    // 후보자 초기화
    bytes32[] public candites;

    constructor(bytes32[] memory candidates) {
        candites = candidates;
    }
    // 각 후보자에 투표
    // mapping 타입은 golang의 map타입으로 해시테이블 구조로 key값으로 데이터에 빠르게 접근
    mapping(bytes32 => uint8) public voteRecived; // { {"dasom": 3}, {"kelly": 5} }

    function votingForCandidate(bytes32 candidate) public {
        voteRecived[candidate] += 1;
    }
    // 후보자 득표수 조회
    function getCanditeNumberOfVotes(bytes32 candidate) view public returns (uint8) {
        return voteRecived[candidate];
    }
}

