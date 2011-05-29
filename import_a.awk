BEGIN {FS=","}
$2 { gsub(/[\'\"\”]/,""); printf "%s:\n  section: %s\n  linenumber: %s\n  description: '%s'\n  skill: %s\n  skillamount: %s\n  otherreward: '%s'\n", NR, $1, $2, $3, $4, $5, $6 }
