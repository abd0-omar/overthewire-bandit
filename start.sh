#!/bin/bash

lvl=$1

sshpass -p $(cat $lvl) ssh bandit$lvl@bandit.labs.overthewire.org -p 2220
