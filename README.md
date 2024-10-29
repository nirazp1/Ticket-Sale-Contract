# Ticket Sale Smart Contract

A decentralized ticket sale system built on Ethereum that enables secure ticket purchasing, swapping, and reselling with automated service fee handling.

## Overview

This smart contract implements a comprehensive ticket management system with the following capabilities:
- Primary ticket sales
- Ticket ownership verification
- Peer-to-peer ticket swapping
- Secondary market resales with automated fee processing
- One-ticket-per-address policy enforcement

## Smart Contract Details

**Network:** Sepolia Testnet  
**Contract Address:** `0x38251CB8a27Ad7805A57bDD1864CB8CA78C6fACc`  
**Solidity Version:** 0.8.9

### Core Functions

| Function | Description | Parameters |
|----------|-------------|------------|
| `buyTicket` | Purchase a ticket from primary sale | `uint ticketId` |
| `getTicketOf` | Query ticket ownership | `address person` |
| `offerSwap` | Initiate a ticket swap | `uint ticketId` |
| `acceptSwap` | Complete a ticket swap | `uint ticketId` |
| `resaleTicket` | List ticket for resale | `uint price` |
| `acceptResale` | Purchase a resale ticket | `uint index` |
| `checkResale` | View available resale tickets | - |

## Test Results

```shell
  TicketSale Contract
    ✔ deploys a contract
    ✔ allows one account to buy a ticket (46ms)
    ✔ prevents buying same ticket twice (47ms)
    ✔ allows ticket swap between two users (100ms)
    ✔ allows resale of tickets (83ms)

  5 passing (479ms)
```

## Deployment Results

```shell
Contract compiled successfully!
MNEMONIC exists: true
INFURA_URL exists: true
Attempting to deploy from account 0xFa12724063D16a22a13621272409085731D4acA4
Contract deployed to 0x38251CB8a27Ad7805A57bDD1864CB8CA78C6fACc
```

## Project Structure

```
├── contracts/
│   └── TicketSale.sol      # Main contract
├── scripts/
│   ├── compile.js          # Compilation script
│   └── deploy.js           # Deployment script
├── test/
│   └── test.js            # Test suite
├── .env                    # Environment configuration
└── package.json           # Project dependencies
```

## Setup and Installation

1. Clone the repository:
```bash
git clone [repository-url]
cd ticket-sale-contract
```

2. Install dependencies:
```bash
npm install
```

3. Configure environment:
Create `.env` file with:
```
MNEMONIC=your_mnemonic_phrase
INFURA_URL=your_infura_url
```

4. Run tests:
```bash
npm test
```

5. Deploy contract:
```bash
npm run deploy
```

## Security Features

- Ownership validation for all operations
- Prevention of double-purchasing
- Secure swap mechanism
- Automated service fee collection
- Access control for critical functions

## Technical Implementation

- Built with Solidity 0.8.9
- Tested with Mocha
- Deployed using Web3.js and Truffle HDWallet Provider
- Gas-optimized for efficient operation

## Development Tools

- Solidity
- Web3.js
- Ganache CLI
- Mocha
- Truffle HDWallet Provider

## Author

Niraj Pandey

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

**Note:** This contract is deployed on the Sepolia testnet. For production use, additional security audits and optimizations are recommended.
