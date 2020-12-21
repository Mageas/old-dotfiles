#!/bin/bash
updates=$(checkupdates | wc -l)
echo -e "$updates"