// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract IDVerifier {
    // Owner of the contract (the deployer)
    address public owner;

    // Struct to store user details
    struct User {
        string name;
        string uniqueId; // can be Aadhar-like, college ID, etc.
        bool isVerified;
    }

    // Mapping of wallet address -> User
    mapping(address => User) private users;

    constructor() {
        owner = msg.sender; // No inputs required at deployment
    }

    // Modifier to restrict functions to owner only
    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    // Add a user and mark verified
    function verifyUser(
        address _userAddress,
        string memory _name,
        string memory _uniqueId
    ) public onlyOwner {
        users[_userAddress] = User(_name, _uniqueId, true);
    }

    // Check if a user is verified
    function isUserVerified(address _userAddress) public view returns (bool) {
        return users[_userAddress].isVerified;
    }

    // Get full user details
    function getUserDetails(address _userAddress)
        public
        view
        returns (string memory, string memory, bool)
    {
        User memory u = users[_userAddress];
        return (u.name, u.uniqueId, u.isVerified);
    }
}
