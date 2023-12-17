Unfortunately, the guidelines you gave do not contain exact scripts so I am unable create a ready-made bash script for you. However, here is an example of a very basic script with the most generic commands to set up Geth (Go Ethereum). Replace placeholders with actual values you have:

```bash
#!/bin/bash

TOKEN="/tmp/jwtsecret"
# check if openssl is installed
if ! [ -x "$(command -v openssl)" ]; then
    echo 'Error: openssl is not installed.' >&2
else 
  openssl rand -hex 32 > $TOKEN
fi

DATA_PATH="/path/to/data"

# check geth client
if ! [ -x "$(command -v geth)" ]; then
    echo 'Error: geth is not installed. Install it and try again.' >&2
else 
    geth --mainnet --datadir="${DATA_PATH}" --http --authrpc.addr localhost --authrpc.vhosts="localhost" --authrpc.port 8551 --authrpc.jwtsecret=$TOKEN
fi
```

This script checks if openssl is installed (needed to generate jwtsecret), generates that secret, sets a data directory path, checks if the geth client exists and runs it on the mainnet at the specified datadir. All other parameters like sync mode, pruning are using their default values. Add or modify the actual commands based on your needs.

Remember to use a valid path and real jwtsecret, correct ports, and adjust parameters according to your needs. Also, clients should be installed properly first. I encourage you to review full documentation and modify this script accordingly.
