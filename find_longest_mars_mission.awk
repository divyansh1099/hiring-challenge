#!/usr/bin/env awk -f
# Script to find the longest successful Mars mission
# Usage: awk -f find_longest_mars_mission.awk space_missions.log

BEGIN {
    max_duration = 0
    security_code = ""
}
# Skip comment lines and system lines
/^#/ || /^SYSTEM:/ || /^CONFIG:/ || /^CHECKSUM:/ || NF < 8 { next }
{
    # Trim whitespace from fields
    gsub(/^[ \t]+|[ \t]+$/, "", $1)
    gsub(/^[ \t]+|[ \t]+$/, "", $2)
    gsub(/^[ \t]+|[ \t]+$/, "", $3)
    gsub(/^[ \t]+|[ \t]+$/, "", $4)
    gsub(/^[ \t]+|[ \t]+$/, "", $5)
    gsub(/^[ \t]+|[ \t]+$/, "", $6)
    gsub(/^[ \t]+|[ \t]+$/, "", $7)
    gsub(/^[ \t]+|[ \t]+$/, "", $8)
    
    # Check if destination is Mars and status is Completed
    if ($3 == "Mars" && $4 == "Completed") {
        duration = $6 + 0  # Convert to number
        if (duration > max_duration) {
            max_duration = duration
            security_code = $8
        }
    }
}
END {
    if (security_code != "") {
        print security_code
    } else {
        print "No completed Mars missions found"
    }
}

