// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import"./VotingStore.sol";

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
    struct VotingStatus {
        uint256 id;
        bytes32 name;
        uint256 count;
    }
    Candidate[] public candidates;
    uint256 public id = 0;

    VotingStore public storeContract;
    
    // mapping 타입은 golang의 map타입으로 해시테이블 구조로 key값으로 데이터에 빠르게 접근
    mapping(uint256 => uint256) public votingMap; // { {"dasom": 3}, {"kelly": 5} }

    constructor(address _storeAddress) ERC721("somiVote", "SV") {
        setStoreContract(_storeAddress);
    }

    // store연결
    function setStoreContract(address _storeAddress) public {
        storeContract = VotingStore(_storeAddress);
    }

    // 후보자 생성
    function setCandidates(CandidateNoId[] memory _candidateList) public {
        Candidate[] memory data = new Candidate[](_candidateList.length);
        for (uint256 i = 0; i < _candidateList.length; i++) {
            // set candidates
            id += 1;
            data[i] = Candidate(id, _candidateList[i].name, _candidateList[i].description, _candidateList[i].imageName);
            // candidates.push(data[i]);
        }
        // Store에 저장
    }

    // 전체 후보자 get
    function getCandidates() public view returns(Candidate[] memory) {
        return candidates;
    }
    // 각 후보자에 투표
    function vote(uint256 _id) public {
        require(validCandidate(_id), 'Not valid candidate.');
        votingMap[_id] += 1;
        // Store에 저장
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

    // 전체 후보자 조회
    function getVotingStatusList() public view returns(VotingStatus[] memory) {
        // Candidate[] memory candidates = 
        VotingStatus[] memory votingStatusList = new VotingStatus[](candidates.length);
        for(uint256 i = 0; i < candidates.length; i++) {
            uint256 candidateId = candidates[i].id;
            bytes32 name = candidates[i].name;
            uint256 count = 1;
            votingStatusList[i] = VotingStatus(candidateId, name, count);
        }
        return votingStatusList;
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
