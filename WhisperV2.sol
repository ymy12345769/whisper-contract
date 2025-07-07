// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WhisperV2 {
    struct Whisper {
        address sender;
        bytes32 encryptedMessage;
        bytes32 passwordHash;
        uint256 expiresAt;
    }

    mapping(uint256 => Whisper) public whispers;
    uint256 public nextId;

    event WhisperCreated(uint256 id, address indexed sender);

    function createWhisper(string memory _encryptedMessage, string memory _password, uint256 durationInSeconds) public {
        require(durationInSeconds > 0, "Duration must be > 0");
        uint256 expiresAt = block.timestamp + durationInSeconds;

        whispers[nextId] = Whisper({
            sender: msg.sender,
            encryptedMessage: bytes32(bytes(_encryptedMessage)),
            passwordHash: keccak256(abi.encodePacked(_password)),
            expiresAt: expiresAt
        });

        emit WhisperCreated(nextId, msg.sender);
        nextId++;
    }

    function getWhisper(uint256 id, string memory _password) public view returns (string memory) {
        Whisper memory w = whispers[id];
        require(block.timestamp <= w.expiresAt, "Whisper expired");
        require(keccak256(abi.encodePacked(_password)) == w.passwordHash, "Incorrect password");

        return string(abi.encodePacked(w.encryptedMessage));
    }

    function getExpiresAt(uint256 id) public view returns (uint256) {
        return whispers[id].expiresAt;
    }
}
