# Core Flow

# Message Structure

# Session vs Application Layer

# Sequence Numbers

# Recovery Scenarios

# Heartbeats and Liveness

# Order State Machine

# Idempotency and Duplicates

# Latency vs Reliability Tradeoffs

# Drop copy vs execution flow separation


# Failure Modes

- ExecutionReports define truth, not requests
- Don't assume the counterparty is correct
- System must be idempotent and replay-safe
- Recovery requires reconciliation

## Handle out-of-order execution reports

## Prevent duplicate fills
- Deduplicate using ExecID (17)

## miss a cancel but receive the fill

## When to use SequenceReset (GapFill) vs full replay

## Recover if both sides have different sequence numbers and keep requesting resends
- FIX does not guarantee automatic convergence
