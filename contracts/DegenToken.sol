// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.0/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.0/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {
    // Store rewards data
    struct Reward {
        string itemName;
        uint256 cost;
    }

    Reward[] public rewards;

    event TokensMinted(address indexed to, uint256 amount);
    event TokensRedeemed(address indexed player, string itemName, uint256 cost);

    constructor() ERC20("Degen", "DGN") {
        // rewards
        rewards.push(Reward("Diamond Armour", 500));
        rewards.push(Reward("Diamond Sword", 300));
        rewards.push(Reward("Diamond Pickaxe", 100));
    }
    //decimals to 0
    function decimals() public view virtual override returns (uint8) {
        return 0;
    }

    //
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
        emit TokensMinted(to, amount);
    }

    // List available rewards
    function rewardsList() public view returns (string memory) {
        string memory list = "Available Rewards:\n";
        for (uint256 i = 0; i < rewards.length; i++) {
            list = string.concat(
                list,
                string.concat(
                    uint2str(i + 1),
                    ". ",
                    rewards[i].itemName,
                    " (Cost: ",
                    uint2str(rewards[i].cost),
                    " DGN)\n"
                )
            );
        }
        return list;
    }

    // Redeem tokens for an item
    function redeem(uint256 choice) external {
        require(choice > 0 && choice <= rewards.length, "Invalid choice");
        Reward memory selectedReward = rewards[choice - 1];

        require(balanceOf(msg.sender) >= selectedReward.cost, "Insufficient balance");

        _burn(msg.sender, selectedReward.cost);
        emit TokensRedeemed(msg.sender, selectedReward.itemName, selectedReward.cost);
    }

    // Helper function to convert uint to string
    function uint2str(uint256 _i) internal pure returns (string memory) {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 length;
        while (j != 0) {
            length++;
            j /= 10;
        }
        bytes memory bstr = new bytes(length);
        uint256 k = length;
        while (_i != 0) {
            k = k - 1;
            uint8 temp = uint8(48 + uint256(_i % 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }
}
