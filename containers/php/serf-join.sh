#!/bin/bash

exec serf agent \
    -tag role=php \
    -join $SERF_1_PORT_7946_TCP_ADDR:$SERF_1_PORT_7946_TCP_PORT
