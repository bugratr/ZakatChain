// Using the Web3.js library to connect to the HAQQ network
const web3 = new Web3(new Web3.providers.HttpProvider("HAQQ_NETWORK_RPC_URL")); // Insert your HAQQ network's RPC URL here

// Contract details
const contractAddress = "YOUR_CONTRACT_ADDRESS"; // Insert your smart contract's address here
const contractABI = [...]; // Insert your smart contract's ABI here

// Creating an instance to interact with the contract
const zakatChainContract = new web3.eth.Contract(contractABI, contractAddress);

// Function to handle the donation
function donate() {
    const amount = document.getElementById('amount').value;
    const convertedAmount = web3.utils.toWei(amount, 'ether'); // In the HAQQ network, the term 'ether' is a generic term

    // Retrieving user's account address
    web3.eth.getAccounts()
        .then(accounts => {
            const userAddress = accounts[0];

            // Initiating the donation process
            zakatChainContract.methods.donate()
                .send({from: userAddress, value: convertedAmount})
                .on('transactionHash', function(hash){
                    console.log("Transaction hash:", hash);
                    alert('Donation successful! Transaction hash: ' + hash);
                })
                .on('error', function(error){
                    console.error(error);
                    alert('There was an error processing your donation.');
                });
        })
        .catch(err => {
            console.error("Couldn't retrieve accounts", err);
        });
}
