#!/bin/bash

username="MSD"
password="TFAR"
userUID="107"

# Create user account
sysadminctl -addUser "$username" -password "$password" -UID "$userUID" -admin
