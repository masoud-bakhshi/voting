// SPDX-License-Identifier: Masoud
pragma solidity >=0.7.5 <0.9.0;
pragma abicoder v2;

contract Voting{
    
    struct Candidate{
        uint256 id;
        string name;
        uint256 VoteCount;
    }
    
    mapping(uint=>Candidate) public Candidates;
    mapping(address=>bool)Participants;
    
    uint128 CandidateCount;
    address owner;
    
    constructor()public{
        owner=msg.sender;
    }
    
    function AddCandidate(string memory _name) public returns(string memory){
        require(msg.sender==owner,"Error");
        CandidateCount++;
       Candidates[CandidateCount]=Candidate(CandidateCount,_name,0);
       return "Success";
    }
    
    function Vote(uint id) public returns(string memory){
        require(id<=CandidateCount && id>0 ,"Candidate Not Found");
        require(Participants[msg.sender]==false);
        Candidates[id].VoteCount++;
        Participants[msg.sender]=true;
        return "Success";
    }
    
    function ShowWinner() view public returns(string memory){
            uint winnerID=0;
            uint winnerVote=0;
            
            for(uint i=1;i<=CandidateCount;i++){
                if(Candidates[i].VoteCount>=winnerVote){
                    winnerID=i;
                    winnerVote=Candidates[i].VoteCount;
                }
            }
            return Candidates[winnerID].name;
            
    }
    
    function ShowUser() public view returns(string memory) {
    string memory output="";
    for (uint i = 1; i < CandidateCount + 1; i++) {
        output = string(abi.encodePacked(output,"[", int( Candidates[i].id), ",", Candidates[i].name, ",",int( Candidates[i].VoteCount), "]"));
        // output = string(abi.encodePacked(output,"[", Candidates[i].VoteCount, ",", Candidates[i].name, ",", Candidates[i].id, "]"));


    }
    return output;
    }
}