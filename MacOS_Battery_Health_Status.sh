#!/bin/sh

echo "<result>$(system_profiler SPPowerDataType | sed -n '/Cycle/,/Condition/p')</result>"
