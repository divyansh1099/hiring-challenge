# Challenge Solution

## Answer
**Security Code: XRT-421-ZQP**

## Mission Details
- **Date:** 2065-06-05
- **Mission ID:** WGU-0200
- **Destination:** Mars
- **Status:** Completed
- **Duration:** 1629 days

## Solution Command

The following awk command was used to find the longest successful Mars mission:

```bash
awk -F'|' '
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
}' space_missions.log
```

## How It Works

1. **Field Separator:** Uses `|` as the field separator (`-F'|'`)
2. **Skip Comments:** Filters out lines starting with `#`, `SYSTEM:`, `CONFIG:`, or `CHECKSUM:`
3. **Trim Whitespace:** Removes leading/trailing whitespace from all fields to handle inconsistent spacing
4. **Filter Criteria:** 
   - Destination must be "Mars"
   - Status must be "Completed"
5. **Find Maximum:** Tracks the mission with the longest duration
6. **Output:** Prints the security code of the longest mission

