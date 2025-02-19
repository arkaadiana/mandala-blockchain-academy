// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuggyStorage {
    // DO NOT EDIT COMMENTS
    // Task 1: Declare an array as numbers;
    uint256[] public numbers;
    // Task 2: Declare a string as message;
    string public message;
    // Task 3: Declare a mapping of address to balance as balances;
    mapping(address => uint256) public balances;

    // Bug 1: Array bounds
    function getNumber(uint256 index) public view returns (uint256) {
        require(index < numbers.length, "Index out of bounds");
        return numbers[index]; 
    }

    function addNumber(uint256 number) public {
        // Task 4: Implement adding numbers to the array
        numbers.push(number);
    }

    // Bug 2: Slice array correctly
    function sliceArray(uint256 start, uint256 end) public view returns (uint256[] memory) {
        require(start < end, "Invalid index start must be less than end");
        require(end <= numbers.length, "End index must be within array bounds");

        uint256[] memory _slicedArray = new uint256[](end - start);

        unchecked {
            for (uint256 i = start; i < end; i++) {
                _slicedArray[i - start] = numbers[i];
            }
        }

        return _slicedArray;
    }

    // Bug 3: Concatenate strings correctly
    function setMessage(string calldata newMessage) public {
        message = string(abi.encodePacked(message, newMessage));
    }

    // Bug 4: How do we update numbers with memory as params?
    function validMemoryUsage(uint256[] memory input) public {
        require(input.length > 0, "Input array cannot be empty");
        // Implement logics to update numbers here
        numbers = input;
    }

    function getBalance(address user) public view returns (uint256) {
        // Task 5: Returning the balance for a specific user
        return balances[user];
    }

    // Bug 5: How to safely pop elements from the array?
    function removeLastNumber() public {
        require(numbers.length > 0, "No numbers in the array");
        numbers.pop();
    }

    function updateBalance(address user, uint256 amount) public {
        require(amount > 0, "Amount must be greater than zero");
        // Task 6: Update balance of a user with a specific amount
        balances[user] += amount;
    }
}
