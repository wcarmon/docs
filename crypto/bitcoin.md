# Overview
1. TODO


# Network
1. Around since 2009
1. Scripting language is limited and only allows what is necessary


# Blocks
1. Block Hash is based on all previous Block hashes
1. Each block has transactions + proof of work
1. A Block might have thousands of transactions
1. View blocks
    1. https://www.blockchain.com/explorer
    1. https://blockexplorer.one/


# Mining/Verification
1. Miners listen for transactions and create blocks
1. Miners broadcast blocks
1. Anyone can be a block creator (miner/verifier)
1. Verification process has tunable complexity, auto adjusted to take about 10 minutes
1. Task:
    1. find a number `x`
    1. if you append `x` to the end of a transaction list, the hash must start with `n` zeros.
    1. Changing `n` changes the complexity


## Rewards
1. As part of doing the block creation & verification, miner adds a new transaction (fee) which gives them coin as a block reward
    1. Think: a tip for doing the work
1. Rewards decrease geometrically over time


# Non-miners
1. Just listen for blocks & update their local ledger
1. May need to wait for things to settle.
    1. Easier to trust blocks which are referenced (as opposed to latest block)


# Consensus

## On Conflict
1. Accept the "ledger fork" with the most proof of work (the longer chain)


# Fraud prevention
1. Digital signatures: ...
1. TODO



# TODO: Unorganized
1. Assumptions: Cryptographic hashes are infeasible to reverse (brute force is the best option)
1. A block is only valid if it has proof of work
1. Each block has a hash referencing the previous block (Think Linked List)
1. Rewards


# Other resources
1. TODO
