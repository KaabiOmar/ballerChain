pragma solidity >=0.4.21 <0.9.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/VaultCoin.sol";

contract TestVaultCoin {
    function testInitialBalanceUsingDeployedContract() public {
        
        VaultCoin meta = VaultCoin(DeployedAddresses.VaultCoin());
        uint expected = 100000000000000000000000000;

        Assert.equal(
            meta.balanceOf(msg.sender),
            expected,
            "Owner should have 10000 VaultCoin initially"
        );
    }

    function testInitialBalanceWithNewVaultCoin() public {
        VaultCoin meta = new VaultCoin();

        uint expected = 100000000000000000000000000;

        Assert.equal(
            meta.balanceOf(address(this)),
            expected,
            "Owner should have 10000 VaultCoin initially"
        );
    }
}
