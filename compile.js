const path = require('path');
const fs = require('fs');
const solc = require('solc');

const contractPath = path.resolve(__dirname, 'contracts/TicketSale.sol');
const sourceCode = fs.readFileSync(contractPath, 'utf8');

const input = {
  language: 'Solidity',
  sources: {
    'TicketSale.sol': {
      content: sourceCode,
    },
  },
  settings: {
    outputSelection: {
      '*': {
        '*': ['*'],
      },
    },
    optimizer: {
      enabled: true,
      runs: 200
    }
  },
};

const output = JSON.parse(solc.compile(JSON.stringify(input)));

if (output.errors) {
  output.errors.forEach(error => {
    if (error.severity === 'error') {
      throw new Error(`Compilation Error: ${error.message}`);
    }
    console.warn(`Warning: ${error.message}`);
  });
}

const contract = output.contracts['TicketSale.sol']['TicketSale'];

if (!contract) {
  throw new Error('Contract not found in compilation output');
}

// Write ABI to file
fs.writeFileSync(
  path.resolve(__dirname, 'ABI.txt'),
  JSON.stringify(contract.abi, null, 2)
);

// Write Bytecode to file
fs.writeFileSync(
  path.resolve(__dirname, 'Bytecode.txt'),
  contract.evm.bytecode.object
);

module.exports = {
  interface: JSON.stringify(contract.abi),
  bytecode: contract.evm.bytecode.object
};

console.log('Contract compiled successfully!');
console.log('ABI and Bytecode files generated successfully!'); 