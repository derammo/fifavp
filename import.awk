BEGIN {FS=","}
$3 { gsub(/[\'\"\”]/,""); printf "%s:\n  role:%s\n  skill: %s\n  value: %s\n", NR, $1, $2, $3 }
