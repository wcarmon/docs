# Overview
1. TODO


# Goal
1. To verify blockchain transactions
1. To decide who updates the blockchain
1. Incentive: Earn (more of) the crypto currency and sometimes transaction fees


# Proof-of-Work (PoW)
1. Used by Bitcoin
1. Mining Incentives: transaction fees
1. On Conflict: Trust the "branch" that has the most computational work
1. Hard to verify a block, but easy to confirm it's correct
1. Mining relies on brute force computation (dedicated hardware)
1. Luck is part of it (which can be good or bad)
1. `Con`: Favors those with the enough infra (large mining pools, expensive)
1. `Con`: Difficulty increases with number of Miners/Verifiers
1. `Con`: Energy inefficient (and gets worse as Miners join)
1. `Con`: High infrastructure costs
1. `Con`: Based on competition, so miners must keep upgrading
1. `Con`: Slow by design (like 10 TPS), limits transaction processing scalability (compare to Visa's 20k+ TPS)
1. `Pro`: Anyone can verify blocks (no central authority)
1. `Pro`: Distributed
1. `Pro`: Proven (working since 2009)

## Fraud risk
1. Need 51% of the network to take over


# Proof-of-Stake (PoS)
1. Used by Ethereum
1. Mining Incentives: transaction fees
1. Only one validator/verifier/miner selected to build the block
    - think lottery
    - mostly random selection, bias toward higher staked miners
1. Rewards those who put up their coins/tokens as collateral (Staking, think Escrow)
    1. Staking = lock up your tokens, hoping to get more of the crypto currency
        - think bank account interest
1. `Con`: **Must own/purchase enough native currency first (expensive)**
1. `Con`: Favors wealthy verifiers/miners ("rich get richer")
1. `Con`: Less proven than PoW
1. `Con`: More centralized than PoW, since "something" must select the verifier
1. `Pro`: Block verification is orders of magnitude faster than PoW
1. `Pro`: Does not require large computing infra
1. `Pro`: Energy efficient (compared to PoW)


## Fraud risk
1. Coins lost if verifier/miner behaves fraudulently


# TODO: Unorganized
1. Validators == Miners
1. PoH, PoET, DBFT
1. Scalability Trilemma problem
    1. TODO: https://www.bitstamp.net/learn/blockchain/what-is-the-blockchain-trilemma/
    1. TODO: https://www.gemini.com/cryptopedia/blockchain-trilemma-decentralization-scalability-definition#section-what-is-the-blockchain-trilemma
    1. TODO: https://www.finextra.com/blogposting/24941/blockchain-and-the-scalability-challenge-solving-the-blockchain-trilemma
    1. TODO: https://www.theblock.co/learn/249536/what-is-the-blockchain-trilemma
    1. TODO: https://education.district0x.io/general-topics/ethereum-scaling/ethereum-scalability-trilemma/
    1. TODO: https://medium.com/logos-network/everything-you-know-about-the-scalability-trilemma-is-probably-wrong-bc4f4b7a7ef
    1. TODO: https://crypto.com/university/blockchain-scalability


# Other resources
1. TODO
