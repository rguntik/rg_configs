#!/usr/bin/env bash

find ~/workspace/oht/scripts/periodic -type f | grep -v /disabled | grep -oP "periodic\/\K(.*)"


