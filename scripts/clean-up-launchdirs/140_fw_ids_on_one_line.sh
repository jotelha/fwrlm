#!/bin/bash
awk 'BEGIN { ORS="," }; { print $1}' | sed 's/,$//'
