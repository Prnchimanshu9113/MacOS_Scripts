#!/bin/sh
superLog=$(tail -20 /Library/Management/super/logs/super.log)

if [[ -f /Library/Management/super/logs/super.log ]]; then
        echo "<result>$superLog</result>"
else
        echo "S.U.P.E.R.M.A.N. not found."
fi
