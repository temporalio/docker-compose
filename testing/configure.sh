#!/bin/bash

set -x

# Adding artificial delay for all network calls.
# In order to verify that there is a delay, you can login to the container and run:
# > tc qdisc show dev eth0
# To change the delay inside of the running container, run:
# > tc qdisc del dev eth0 root && tc qdisc add dev eth0 root netem delay 100ms
#
# Read more about what's possible with tc here:
# https://www.badunetworks.com/traffic-shaping-with-tc/
tc qdisc add dev eth0 root netem delay 50ms
