// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.7;

contract Vote {
    // 후보자 초기화
    bytes32[] public candidates;

    constructor(bytes32[] memory candidateList) {
        candidates = candidateList;
    }

    // 각 후보자에 투표
    // mapping 타입은 golang의 map타입으로 해시테이블 구조로 key값으로 데이터에 빠르게 접근
    mapping(bytes32 => uint8) public voteRecived; // { {"dasom": 3}, {"kelly": 5} }

    function votingForCandidate(bytes32 candidate) public {
        require(validCandidate(candidate));
        voteRecived[candidate] += 1;
    }

    // 후보자 득표수 조회
    function getCanditeNumberOfVotes(bytes32 candidate)
        public
        view
        returns (uint8)
    {
        require(validCandidate(candidate));
        return voteRecived[candidate];
    }

    // 입력값 유효성 체크
    function validCandidate(bytes32 candidate) public view returns (bool) {
        for (uint256 i = 0; i < candidates.length; i++) {
            if (candidates[i] == candidate) {
                return true;
            }
        }
        return false;
    }
}
