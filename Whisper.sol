// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Whisper {
    struct Message {
        string content;
        string password;
        uint256 destroyTime;
    }

    mapping(uint256 => Message) public messages;
    uint256 public messageCount;

    function createWhisper(string memory _content, string memory _password, uint256 _destroyInSeconds) public {
        messages[messageCount] = Message(_content, _password, block.timestamp + _destroyInSeconds);
        messageCount++;
    }

    function getWhisper(uint256 _id, string memory _password) public view returns (string memory) {
        Message memory msgObj = messages[_id];
        require(keccak256(bytes(_password)) == keccak256(bytes(msgObj.password)), "Invalid password");
        require(block.timestamp <= msgObj.destroyTime, "Message expired");
        return msgObj.content;
    }
}
