// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ZakatChain {
    address public owner;
    uint256 public operationalPercentage = 2; // 2%
    mapping(address => Applicant) public applicants;

    struct Applicant {
        bool isRegistered;
        bool hasReceived;
        address walletAddress;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can execute this.");
        _;
    }

    event DonationReceived(address donor, uint256 amount);
    event ZakatDistributed(address recipient, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    function registerApplicant(address applicantAddress) external onlyOwner {
        require(!applicants[applicantAddress].isRegistered, "Applicant is already registered.");

        applicants[applicantAddress] = Applicant({
            isRegistered: true,
            hasReceived: false,
            walletAddress: address(0)
        });
    }

    function setWalletAddress(address wallet) external {
        require(applicants[msg.sender].isRegistered, "Applicant is not registered.");
        require(!applicants[msg.sender].hasReceived, "Applicant has already received Zakat.");

        applicants[msg.sender].walletAddress = wallet;
    }

    function donate() external payable {
        require(msg.value > 0, "Amount should be greater than 0.");

        uint256 operationalAmount = (msg.value * operationalPercentage) / 100;
        uint256 donationAmount = msg.value - operationalAmount;

        payable(owner).transfer(operationalAmount); // transfer operational cost

        address[] memory addresses = _getRandomApplicant();
        for (uint i = 0; i < addresses.length; i++) {
            payable(addresses[i]).transfer(donationAmount);
            applicants[addresses[i]].hasReceived = true;
            emit ZakatDistributed(addresses[i], donationAmount);
        }

        emit DonationReceived(msg.sender, msg.value);
    }

    function _getRandomApplicant() internal view returns(address[] memory) {
        address[] memory registeredAddresses = new address[](1); // currently set to distribute to only 1 person, but can be expanded
        uint count = 0;

        for (uint i = 0; i < 1; i++) { // same here, currently looking for only one address
            address current = address(uint(keccak256(abi.encodePacked(count, block.timestamp))));
            while (!applicants[current].isRegistered || applicants[current].hasReceived || applicants[current].walletAddress == address(0)) {
                current = address(uint(keccak256(abi.encodePacked(current, block.timestamp))));
            }
            registeredAddresses[i] = current;
        }

        return registeredAddresses;
    }
}

