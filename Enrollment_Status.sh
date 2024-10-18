#!/bin/sh
enrollStatus=$(profiles status -type enrollment)
date=$(date)

echo "<result>$enrollStatus - checked at $date</result>"
