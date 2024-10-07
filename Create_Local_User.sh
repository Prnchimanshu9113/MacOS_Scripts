#!/bin/bash

username="newuser"
password="password"
userUID="501"

# Create user account
sysadminctl -addUser "$username" -password "$password" -UID "$userUID" -admin
