#!/bin/sh

envsubst -i config.xml -o config.xml

./G2O_Server.x64
