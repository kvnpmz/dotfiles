#!/usr/bin/env bash

IDS="$HOME/Downloads/michael_listing_ids.txt"
CSV="$HOME/Downloads/EtsySoldOrderItems2026.csv"

echo "=== Michael Listing Sales Report ==="
echo

awk -F',' '
NR==FNR {
    ids[$1]=1
    next
}

NR==1 {
    next
}

$15 in ids {
    sales++
    units += $4
    revenue += $12

    listing[$15]++
    item[$15]=$2

    printf "%s | %s | %s | $%s | Listing %s\n", \
        $1, $2, $3, $12, $15
}

END {
    print ""
    print "=============================="
    print "SUMMARY"
    print "=============================="
    printf "Sales: %d\n", sales
    printf "Units: %d\n", units
    printf "Revenue: $%.2f\n", revenue

    print ""
    print "Sales by Listing:"
    for (id in listing) {
        printf "%s sales - %s (ID %s)\n", listing[id], item[id], id
    }
}
' "$IDS" "$CSV"
