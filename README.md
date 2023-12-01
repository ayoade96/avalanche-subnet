# DeFi Empire Smart Contract

## Overview

This smart contract allows players to collect, build, and earn rewards for their participation in the game's activities.

- It has two main contracts, `ERC20` token contract and the `Vault` contract

- The ERC20-Token contract, `src/ERC20.sol`, was deployed on the `mySubnet` network at the contract address `0x5aa01B3b5877255cE50cc55e8986a7a5fe29C70e` and
- The Vault contract, `src/Vault.sol` was deployed on the `mySubnet` network at the contract address`0x4Ac1d98D9cEF99EC6546dEd4Bd550b0b287aaD6D`.


### The ERC20-TOken and Vault Contract

- The ERC20-Token contract, `src/ERC20.sol`, was deployed on the `mySubnet` network at the contract address `0x5aa01B3b5877255cE50cc55e8986a7a5fe29C70e` and
- The Vault contract, `src/Vault.sol` was deployed on the `mySubnet` network at the contract address`0x4Ac1d98D9cEF99EC6546dEd4Bd550b0b287aaD6D`.
- The vault contract is used for managing deposits and withdrawals of a specified ERC-20 token.
- It has functionalities that allows users to deposit tokens, minting shares in proportion to the deposited amount, and later withdraw a corresponding amount of tokens based on the shares they hold.

## Vault Contract Functionalities

### Deposit

- The `deposit()` function allows users to deposit ERC-20 tokens into the vault.

- This function calculates the number of shares to mint based on the deposited amount and the current total supply of shares.

```solidity
function deposit(uint _amount) external {
        uint shares;
        if (totalSupply == 0) {
            shares = _amount;
        } else {
            shares = (_amount * totalSupply) / token.balanceOf(address(this));
        }

        _mint(msg.sender, shares);
        token.transferFrom(msg.sender, address(this), _amount);
    }

```

### Withdraw

- The `withdraw` function allows users to withdraw their tokens from the vault.
- This function calculates the amount to withdraw based on the number of shares burned and the current total supply of shares.

```solidity
function withdraw(uint _shares) external {
        uint amount = (_shares * token.balanceOf(address(this))) / totalSupply;
        _burn(msg.sender, _shares);
        token.transfer(msg.sender, amount);
    }
```

### ERC-20 Interface

The ERC20 interface provides the functions signatures basic token operations like checking balances, transferring tokens, and approving token transfers.

```solidity
interface IERC20 {
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(
        address owner,
        address spender
    ) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}
```

## Usage Guidelines

1. **Token Approval:**
   Before depositing, ensure that you have approved the contract to spend your ERC20 tokens. Use the ERC20 `approve` function to grant the necessary permission.

```solidity
function approve(address spender, uint amount) external returns (bool);
```

2. **Deposit:**
   Call the `deposit` function with the desired amount of tokens to mint corresponding shares.

3. **Withdraw:**
   Call the `withdraw` function with the number of shares to burn and receive the proportional amount of tokens.

4. **Monitor Balances:**
   Keep track of your token balances and shares to manage deposits and withdrawals effectively, by calling the `balanceOf()`

   ```solidity
   function balanceOf(address account) external view returns (uint);
   ```


## Author

Ayoade Abdulrahman
[@metacraftersio](https://twitter.com/Abulrahman)

## Disclaimer

- This smart contract is provided under the MIT license, and users are encouraged to review and understand the code before interacting with it, also this contract is deployed on `mySubnet` Network (my EVM subnet using the Avalanche CLI).
