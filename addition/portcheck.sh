#!/bin/bash
if nc -z localhost 8333
then
    echo "Node is up"
    pkill -f "$BITCOIN_INSTALL_DIR/bin/bitcoin-qt"
else
    echo "Node is down"
fi
