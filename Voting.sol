// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.7;
pragma experimental ABIEncoderV2;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract Vote is ERC721Enumerable {
    // 후보자 초기화
    struct CandidateNoId {
        bytes32 name;
        bytes32 description;
        bytes32 imageName;
    }
    struct Candidate {
        uint256 id;
        bytes32 name;
        bytes32 description;
        bytes32 imageName;
    }
    Candidate[] public candidates;
    uint256 public id = 0;
    
    // mapping 타입은 golang의 map타입으로 해시테이블 구조로 key값으로 데이터에 빠르게 접근
    mapping(uint256 => uint256) public votingMap; // { {"dasom": 3}, {"kelly": 5} }

    constructor() ERC721("somiVote", "SV") {}

    // 후보자 생성
    function setCandidates(CandidateNoId[] memory _candidateList) public {
        Candidate[] memory data = new Candidate[](_candidateList.length);
        for (uint256 i = 0; i < _candidateList.length; i++) {
            id += 1;
            data[i].id = id;
            data[i].name = _candidateList[i].name;
            data[i].description = _candidateList[i].description;
            data[i].imageName = _candidateList[i].imageName;
            candidates.push(data[i]);
        }
    }

    // 전체 후보자 get
    function getCandidates() public view returns(Candidate[] memory) {
        return candidates;
    }
    // 각 후보자에 투표
    function vote(uint256 _id) public {
        require(validCandidate(_id), 'Not valid candidate.');
        votingMap[_id] += 1;
    }

    // 후보자 득표수 조회
    function getCanditeNumberOfVotes(uint256 _id)
        public
        view
        returns (uint256)
    {
        require(validCandidate(_id), 'Not valid candidate.');
        return votingMap[_id];
    }

    // 입력값 유효성 체크
    function validCandidate(uint256 _id) public view returns (bool) {
        for (uint256 i = 0; i < candidates.length; i++) {
            if (candidates[i].id == _id) {
                return true;
            }
        }
        return false;
    }
}
