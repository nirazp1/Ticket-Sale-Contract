// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract TicketSale {

    // Contract Variables
    address public owner; // Owner of the contract
    uint public ticketPrice; // Price per ticket in wei
    uint public totalTickets; // Total number of tickets available
    uint public ticketsSold;  // Number of tickets sold
    
    // Ticket ownership - mapping from ticket ID to owner address
    mapping (uint => address) public ticketOwners; 
    
    // Swap offers - mapping from offerer's ticket ID to offeree's address
    mapping (uint => address) public swapOffers; 

    // Resale information
    struct ResaleOffer {
        uint ticketId;
        uint price;
        address seller; // Add seller to the ResaleOffer struct
    }
    ResaleOffer[] public resaleTickets;

    // Events (for better DApp integration later)
    event TicketPurchased(address buyer, uint ticketId);
    event TicketsSwapped(address buyer1, uint ticketId1, address buyer2, uint ticketId2);
    event TicketResold(address seller, address buyer, uint ticketId, uint price);

    // Constructor
    constructor(uint numTickets, uint price) {
        owner = msg.sender;
        totalTickets = numTickets;
        ticketPrice = price; 
    }

    // Buy a Ticket
    function buyTicket(uint ticketId) public payable {
        require(ticketId > 0 && ticketId <= totalTickets, "Invalid ticket ID.");
        require(ticketOwners[ticketId] == address(0), "Ticket already sold.");
        require(msg.value == ticketPrice, "Incorrect payment amount.");
        require(getTicketOf(msg.sender) == 0, "You can only buy one ticket."); 

        // Assign the ticket to the buyer
        ticketOwners[ticketId] = msg.sender;
        ticketsSold++;

        // Use call to send Ether to the owner
        (bool success, ) = owner.call{value: msg.value}("");
        require(success, "Transfer failed.");

        emit TicketPurchased(msg.sender, ticketId);
    }

    // Get Ticket ID for an Address
    function getTicketOf(address person) public view returns (uint) {
        for (uint i = 1; i <= totalTickets; i++) {
            if (ticketOwners[i] == person) {
                return i; 
            }
        }
        return 0; // Person doesn't own a ticket
    }

    // Offer a Ticket Swap 
    function offerSwap(uint ticketId) public {
        require(ticketOwners[ticketId] == msg.sender, "You don't own this ticket.");
        swapOffers[ticketId] = msg.sender; 
    }

    // Accept a Swap Offer
    function acceptSwap(uint ticketId) public {
        require(getTicketOf(msg.sender) != 0, "You need to own a ticket to swap.");
        require(swapOffers[ticketId] != address(0), "No swap offer for your ticket.");
        require(swapOffers[ticketId] != msg.sender, "Cannot accept your own swap offer.");

        uint offererTicket = ticketId;
        address offerer = swapOffers[ticketId];
        uint acceptorTicket = getTicketOf(msg.sender);

        // Swap Ownership
        ticketOwners[offererTicket] = msg.sender; 
        ticketOwners[acceptorTicket] = offerer; 

        // Remove the swap offer
        delete swapOffers[offererTicket];

        emit TicketsSwapped(offerer, offererTicket, msg.sender, acceptorTicket);
    }

    // Offer a ticket for resale
    function resaleTicket(uint price) public {
        uint ticketId = getTicketOf(msg.sender);
        require(ticketId != 0, "You don't own a ticket to resell.");
       
        // Create a ResaleOffer struct and add it to the array
        resaleTickets.push(ResaleOffer({
            ticketId: ticketId,
            price: price,
            seller: msg.sender // Add the seller's address
        }));
    }

    // Accept a resale offer
    function acceptResale(uint index) public payable { 
        require(index < resaleTickets.length, "Invalid resale ticket index.");
        ResaleOffer memory offer = resaleTickets[index];
        require(offer.price == msg.value, "Incorrect payment amount.");
        require(getTicketOf(msg.sender) == 0, "You can only buy one ticket."); 

        uint serviceFee = offer.price * 10 / 100; // 10% service fee
        uint sellerPayment = offer.price - serviceFee;

        // Transfer ownership to the buyer
        ticketOwners[offer.ticketId] = msg.sender;

        // Send funds to the seller and the manager
        payable(offer.seller).transfer(sellerPayment);  
        payable(owner).transfer(serviceFee);  

        // Remove the resale offer from the array
        resaleTickets[index] = resaleTickets[resaleTickets.length - 1];
        resaleTickets.pop(); 

        emit TicketResold(offer.seller, msg.sender, offer.ticketId, offer.price);
    }

    // Check available resale tickets 
    function checkResale() public view returns (ResaleOffer[] memory) {
        return resaleTickets;
    }
}
/*
> ticket-sale-contract@1.0.0 test
> mocha --timeout 10000

Contract compiled successfully!


  TicketSale Contract
Deploying contract with account: 0xf1477321d5bDBCc537ac280c53C25f9Da5Ab0339
Account balance: 1000000000000000000000
Contract deployed to: 0xbb262661C0aD27D02A9c5B0313c73E4774c83782
    ✔ deploys a contract
Deploying contract with account: 0xf1477321d5bDBCc537ac280c53C25f9Da5Ab0339
Account balance: 999998199776000000000
Contract deployed to: 0x454a48cb713a11f02Beb5278246D15ec60389754
Buyer initial balance: 1000000000000000000000
    ✔ allows one account to buy a ticket (46ms)
Deploying contract with account: 0xf1477321d5bDBCc537ac280c53C25f9Da5Ab0339
Account balance: 999996399552000000000
Contract deployed to: 0x341ccaFbbBa9d7e15c7B73103D79a3AcC819cBe1
    ✔ prevents buying same ticket twice (47ms)
Deploying contract with account: 0xf1477321d5bDBCc537ac280c53C25f9Da5Ab0339
Account balance: 999994599328000000000
Contract deployed to: 0xC7791e7A460028c2d6B693d6891D7e4d82449213
    ✔ allows ticket swap between two users (100ms)
Deploying contract with account: 0xf1477321d5bDBCc537ac280c53C25f9Da5Ab0339
Account balance: 999992799104000000000
Contract deployed to: 0x4F21e92FC46de3eD642d12926b59a9be75F861bB
    ✔ allows resale of tickets (83ms)


  5 passing (479ms)

nirajpandey@Nirajs-MBP folder 1 % 



Deployed to Sepolia Network
nirajpandey@Nirajs-MBP folder 1 % npm run deploy

> ticket-sale-contract@1.0.0 deploy
> node deploy.js

Contract compiled successfully!
MNEMONIC exists: true
INFURA_URL exists: true
Attempting to deploy from account 0xFa12724063D16a22a13621272409085731D4acA4
Contract deployed to 0x38251CB8a27Ad7805A57bDD1864CB8CA78C6fACc

*/

