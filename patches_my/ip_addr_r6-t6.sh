#!/bin/bash
uci set network.lan.proto='static'
uci set network.lan.ipaddr='192.168.10.11'
uci set network.lan.netmask='255.255.255.0'
uci set network.lan.gateway='192.168.10.1'
uci set network.lan.dns='192.168.10.1'
uci commit network
