module coin_address::MyToken {
    use aptos_framework::signer;
    use aptos_framework::coin;
    use aptos_framework::string;

    // Define the struct for the token type
    struct Token has copy, drop, store {}
    
    // Function to initialize the token
    public entry fun initialize_token(
        sender: &signer,
        name: vector<u8>,
        symbol: vector<u8>,
        decimals: u8,
        initial_supply: u64
    ) {
        let coin_name = string::utf8(name);
        let coin_symbol = string::utf8(symbol);
        // Register the new coin type
        let (burn_cap, freeze_cap, mint_cap) = coin::initialize<Token>(
            sender,
            coin_name,
            coin_symbol,
            decimals,
            true,
        );

        // Register the CoinStore for the sender
        coin::register<Token>(sender);

        // Mint initial supply to the creator's sender
        let initial_coins = coin::mint<Token>(initial_supply, &mint_cap);
        coin::deposit(signer::address_of(sender), initial_coins);

        // Destroy the capabilities to avoid unused value error
        coin::destroy_burn_cap(burn_cap);
        coin::destroy_freeze_cap(freeze_cap);
        coin::destroy_mint_cap(mint_cap);
    }
}
