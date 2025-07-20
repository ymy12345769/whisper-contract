// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Whisper {
struct Message {
address sender;
string content; // 明文消息
uint256 expiresAt; // 过期时间
}

mapping(uint256 => Message) private messages;
uint256 public nextId;

event MessageCreated(uint256 id, address indexed sender, uint256 expiresAt);

// 创建一条明文消息
function createMessage(string memory _content, uint256 durationInSeconds) public {
require(durationInSeconds > 0, "Duration must be > 0");

uint256 expiresAt = block.timestamp + durationInSeconds;
messages[nextId] = Message({
sender: msg.sender,
content: _content,
expiresAt: expiresAt
});

emit MessageCreated(nextId, msg.sender, expiresAt);
nextId++;
}

// 获取指定ID的明文消息
function getMessage(uint256 id) public view returns (string memory) {
require(id < nextId, "Message does not exist");
Message memory m = messages[id];
require(block.timestamp <= m.expiresAt, "Message expired");
return m.content;
}

// 获取消息的发送者和过期时间
function getMessageInfo(uint256 id) public view returns (address, uint256) {
require(id < nextId, "Message does not exist");
Message memory m = messages[id];
return (m.sender, m.expiresAt);
}
}
