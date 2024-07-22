#Pre-requisite
Install [aptos cli](https://aptos.dev/en/build/cli)

# Move Fungible Token Example
In this example, the fungible token(fixed supply) is created in two steps, first publish the module and then initialize the coin.

## Step 1
cd into MyToken folder then run `aptos init --network testnet`
After aptos init, replace the coin_address with the generated account address in .**aptos/config.yaml** account

## Step 2
Publish the package (You doesn't need to fund the account, the commands will automatically faucet 1 test apt for you.)

`aptos move publish --package-dir .`

Result:
```
Do you want to submit a transaction for a range of [7100 - 10600] Octas at a gas unit price of 100 Octas? [yes/no] >
yes
{
  "Result": {
    "transaction_hash": "0xdc4db05d7eeeb9d4be3a7be5dce010800a4686d8ea24cf38586634de8bfa7aea",
    "gas_used": 71,
    "gas_unit_price": 100,
    "sender": "27c47b05e43e516fc9037ff06be129b003dd64e92be365e87b7d27b28aa4084e",
    "sequence_number": 1,
    "success": true,
    "timestamp_us": 1721607142997793,
    "version": 5508894420,
    "vm_status": "Executed successfully"
  }
}
```
You may scan the transaction hash in the aptos explorer for more information about the transaction.

## Step 3
Initialize the coin

`aptos move run --function-id 0x27c47b05e43e516fc9037ff06be129b003dd64e92be365e87b7d27b28aa4084e::MyToken::initialize_token --args string:"MyToken" string:"MTK" u8:8 u64:1000000`

Result:
```
Do you want to submit a transaction for a range of [97200 - 145800] Octas at a gas unit price of 100 Octas? [yes/no] >
yes
{
  "Result": {
    "transaction_hash": "0xce4b100ae1b51dc9586d084a6f426ba23d8ce3b0fc522f4979aff3ecd091af9f",
    "gas_used": 972,
    "gas_unit_price": 100,
    "sender": "27c47b05e43e516fc9037ff06be129b003dd64e92be365e87b7d27b28aa4084e",
    "sequence_number": 2,
    "success": true,
    "timestamp_us": 1721607212565027,
    "version": 5508898900,
    "vm_status": "Executed successfully"
  }
}
```

## To validate the contract codes
`aptos move prove --package-dir src/MyToken`

## Notes
- This implementation required two steps, which is publish the module then initialize the coin.

- You can do two steps at once through replacing the entry function to `fun init_module(sender: &signer)`.

- This uses the [Coin(Legacy)](https://aptos.dev/en/build/smart-contracts/aptos-coin)
 standard.
- There is new standard name [Fungible Asset](https://aptos.dev/en/build/smart-contracts/fungible-asset)


