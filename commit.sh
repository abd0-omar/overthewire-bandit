#!/bin/bash
lvl=$1

echo "$2" >"$lvl"

git add "$lvl"

git commit -m "lvl $lvl"
