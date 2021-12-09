#!/bin/sh

/usr/local/bin/cobc -x -o bin/$(basename $1 .cbl) -std=default -debug "$1" 
