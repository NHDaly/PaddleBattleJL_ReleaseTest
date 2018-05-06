#!/bin/sh
cd releases
unzip Paddle-Battle-v1.0.3.zip

# Test opening with system
(sleep 10; pkill main) &  # Kill after opening  since open 
open Paddle\ Battle.app  # Open the regular way.
[[ 0 == $? ]] && echo "Success" || { echo "App failed to open!"; exit 1; }  # Make sure it opened correctly.
sleep 15  # wait til Paddle Battle is killed fully. (`open` doesn't block)

# Test running the code
(sleep 10; pkill -7 main) &  # Kill with a specific, uncommon signal.
./Paddle\ Battle.app/Contents/MacOS/main
[[ 135 == $? ]] && echo "Success" || { echo "Code failed to run!"; exit 1; }  # Make sure it was killed by -7 (not cause it failed for some other reason)

# Clean up
rm -rf Paddle\ Battle.app
