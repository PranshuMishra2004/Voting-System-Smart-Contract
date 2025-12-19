// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract voting{

    address public owner;

    struct candidate{
        string name;
        uint256 votecount;
    }

    candidate[] public candidates;

    mapping(address=>bool) public hasVoted;

    modifier onlyowner(){
        require(msg.sender==owner,"Invalid");
        _;
    }

    constructor(){
        owner=msg.sender;
    }

    function addcandidate(string memory _name) public onlyowner{
        candidates.push(candidate(_name,0));
    }

    function votecount(uint256 candidateindex) public {
        require(!hasVoted[msg.sender],"Already voted");
        require(candidateindex<candidates.length,"Index out of bound");

        hasVoted[msg.sender]=true;
        candidates[candidateindex].votecount+=1;
    }

    function candidatedetails(uint256 index) public view returns(string memory,uint256){
        require(index<candidates.length,"Index Out of Bond");
        return (candidates[index].name,candidates[index].votecount);
    }

}