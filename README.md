# DegenToken

The `DegenToken` smart contract is an ERC-20-based token with additional functionality for gamified reward redemption. Built using OpenZeppelin's Solidity libraries, this contract allows users to earn, burn, and redeem tokens for predefined rewards.

---

## Features

1. **ERC-20 Token Implementation**
   - Token name: `Degen`
   - Token symbol: `DGN`
   - **Custom Decimals**: Uses 0 decimals, meaning tokens are indivisible.

2. **Owner Privileges**
   - Token minting is restricted to the contract owner using OpenZeppelin's `Ownable` module.

3. **Reward System**
   - Users can redeem their tokens for predefined rewards.
   - Rewards are stored as a list of `Reward` structs, which include:
     - `itemName`: The name of the reward item.
     - `cost`: The token cost of the reward.

4. **Burnable Tokens**
   - Token holders can burn tokens via the redemption process, reducing the total supply.

5. **Utilities**
   - Includes a helper function `uint2str` to convert numbers to strings for dynamic reward listing.

---
# Author
**Ella Belle G. Wong**
