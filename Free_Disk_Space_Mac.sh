#!/bin/bash

echo "<result>$(diskutil info / | awk '/Free Space|Available Space/{print $4}')</result>"  #{print $4} prints the fourth field from the matched lines (/Free Space|Available Space/)
