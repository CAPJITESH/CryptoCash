// //  flutter run | grep -v "D/EGL_emulation"

// // // SPDX-License-Identifier: MIT
// pragma solidity ^0.5.11;
// pragma experimental ABIEncoderV2;

// contract UserRegistry {
//     address public owner;
//     mapping(address => string) public userNames;
//     mapping(address => string) public userImages; // Added mapping for user images
//     mapping(bytes32 => string) public transactionNames;
//     mapping(bytes32 => Transaction) public transactions;
//     bytes32[] public transactionKeys;

//     struct Transaction {
//         address sender;
//         address receiver;
//         uint256 amount;
//         string name; // New field to store transaction name
//         string date; // New field to store transaction date
//     }

//     modifier onlyOwner {
//         require(msg.sender == owner, "Only contract owner can call this function");
//         _;
//     }

//     constructor() public {
//         owner = msg.sender;
//     }

//     function setUserDetails(address _userAddress, string memory _name, string memory _image) public {
//         userNames[_userAddress] = _name;
//         userImages[_userAddress] = _image;
//     }

//     function getUserDetails(address _userAddress) public view returns (string memory, string memory) {
//         return (userNames[_userAddress], userImages[_userAddress]);
//     }

//     function setTransactionName(bytes32 _txHash, string memory _name) public  {
//         transactionNames[_txHash] = _name;
//     }

//     function getTransactionName(bytes32 _txHash) public view returns (string memory) {
//         return transactionNames[_txHash];
//     }

//     function addTransaction(bytes32 _txHash, address _sender, address _receiver, uint256 _amount, string memory _name, string memory _date) public {
//         transactions[_txHash] = Transaction(_sender, _receiver, _amount, _name, _date);
//         transactionKeys.push(_txHash);
//     }

//     function getAllTransactionsForAccount(address _account) public view returns (Transaction[] memory) {
//         uint256 count = 0;
//         for (uint256 i = 0; i < transactionKeys.length; i++) {
//             if (transactions[transactionKeys[i]].sender == _account || transactions[transactionKeys[i]].receiver == _account) {
//                 count++;
//             }
//         }
//         Transaction[] memory result = new Transaction[](count);
//         uint256 index = 0;
//         for (uint256 i = 0; i < transactionKeys.length; i++) {
//             if (transactions[transactionKeys[i]].sender == _account || transactions[transactionKeys[i]].receiver == _account) {
//                 result[index] = transactions[transactionKeys[i]];
//                 index++;
//             }
//         }
//         return result;
//     }
// }
