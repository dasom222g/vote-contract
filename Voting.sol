// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import"./VotingStore.sol";
import"./DataType.sol";

contract Vote is DataType {
    VotingStore public store;

    constructor(address _storeAddress) {
        setStoreContract(_storeAddress);
    }

    // store연결
    function setStoreContract(address _storeAddress) public {
        store = VotingStore(_storeAddress);
    }

    // 후보자 생성
    function setCandidates(CandidateNoId[] memory _candidateList) public {
        Candidate[] memory data = new Candidate[](_candidateList.length);
        uint256 serialId = store.getCurrentId();
        for (uint256 i = 0; i < _candidateList.length; i++) {
            serialId++;
            data[i] = Candidate(serialId, _candidateList[i].name, _candidateList[i].description, _candidateList[i].imageName);
        }
        // Store에 저장
        store.setCandidates(data);
    }

    // 전체 후보자 get
    function getCandidates() public view returns(Candidate[] memory) {
        return store.getCandidates();
    }
    // 각 후보자에 투표
    function vote(uint256 _id) public {
        require(validCandidate(_id), 'Not valid candidate.');
        store.setVotingMap(_id, store.getCountById(_id) + 1);
    }

    // 후보자 득표수 조회
    function getCountById(uint256 _id)
        public
        view
        returns (uint256)
    {
        require(validCandidate(_id), 'Not valid candidate.');
        return store.getCountById(_id);
    }

    // 전체 후보자 조회
    function getVotingStatusList() public view returns(VotingStatus[] memory) {
        Candidate[] memory candidates;
        VotingStatus[] memory votingStatusList = new VotingStatus[](candidates.length);
        for(uint256 i = 0; i < candidates.length; i++) {
            uint256 candidateId = candidates[i].id;
            bytes32 name = candidates[i].name;
            uint256 count = store.getCountById(candidateId);
            votingStatusList[i] = VotingStatus(candidateId, name, count);
        }
        return votingStatusList;
    }

    // 입력값 유효성 체크
    function validCandidate(uint256 _id) public view returns (bool) {
        Candidate[] memory candidates = store.getCandidates();
        for (uint256 i = 0; i < candidates.length; i++) {
            if (candidates[i].id == _id) {
                return true;
            }
        }
        return false;
    }
}
