// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract BuggyContract {
    uint private count = 0;
    string private messages;
    bool public isPaused;
    address private owner;

    error InvalidNumber(uint256 number);

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    // Bug 1
    constructor() {
        owner = msg.sender;
    }

    // Bug 2
    function increment(uint amount) private {
        count += amount;
    }

    // Bug 3
    function getCount() public view returns (uint) {
        return count;
    }

    // Bug 4
    function divideCount(uint divisor) public returns (uint) {
        require(divisor != 0, "Can't divide by zero");
        count = count / divisor;
        return count;
    }

    // Bug 5
    // Hint: make sure that message is only stored temporarily
    function setMessage(string memory message) public {
        messages = message;
    }

    // Bug 6
    // Hint: two things to do here.
    // Think about how to make the loop more efficient
    // and read the compiler
    function sumNumbers(uint n) public pure returns (uint) {
        if (n == 0) revert InvalidNumber(n);
        return (n * (n + 1)) / 2;
    }

    // Bug 7
    // Hint: Think about math operation overflow
    function setCountWithMultiplication(uint x, uint y) public {
        require(x <= type(uint).max / y, "Multiplication overflow");
        count = x * y;
    }

    // Bug 8
    function resetCount() public onlyOwner {
        count = 0;
    }

    // Bug 9
    function togglePause() public onlyOwner {
        isPaused = !isPaused;
    }
}
