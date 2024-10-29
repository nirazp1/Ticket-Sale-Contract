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
Deploying contract with account: 0xA7449C4BDdC3910f2Afe7e94D2534730f053f62B
Account balance: 1000000000000000000000
Contract deployed to: 0x48Cd9110d9BbaBA4217B876120aFAc5F9437b3fd
    ✔ deploys a contract
Deploying contract with account: 0xA7449C4BDdC3910f2Afe7e94D2534730f053f62B
Account balance: 999998199776000000000
Contract deployed to: 0x928071f8fF7F868aC99581d8CDc904EeC0cDCEfc
Buyer initial balance: 1000000000000000000000
    ✔ allows one account to buy a ticket (44ms)
Deploying contract with account: 0xA7449C4BDdC3910f2Afe7e94D2534730f053f62B
Account balance: 999996399552000000000
Contract deployed to: 0x0482bD807158626549fe0f1F3dBB7D7843f2AC3F
    ✔ prevents buying same ticket twice (43ms)
Deploying contract with account: 0xA7449C4BDdC3910f2Afe7e94D2534730f053f62B
Account balance: 999994599328000000000
Contract deployed to: 0xC1ABa8c45Bc92a6B572975202D3a6ee78424db26
    ✔ allows ticket swap between two users (103ms)
Deploying contract with account: 0xA7449C4BDdC3910f2Afe7e94D2534730f053f62B
Account balance: 999992799104000000000
Contract deployed to: 0xe36B9C3C6185ecd81E6906E53470628B4D3C8d2A
    ✔ allows resale of tickets (81ms)


  5 passing (467ms)
```

## Deployment Results

```shell
Contract compiled successfully!
MNEMONIC exists: true
INFURA_URL exists: true
Attempting to deploy from account 0xFa12724063D16a22a13621272409085731D4acA4
Contract deployed to 0x4d594a3A020580Fb74ec2e07eB576a13b5C9eAce
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
