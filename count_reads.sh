#!/usr/bin/env bash
# count_reads.sh — how many reads a FASTQ file holds: every read is four lines.
#
#   bash count_reads.sh <reads.fastq | reads.fastq.gz>
set -euo pipefail

file=${1:?usage: count_reads.sh <reads.fastq | reads.fastq.gz>}
if [[ ${file} == *.gz ]]; then
    lines=$(gzip -dc "${file}" | wc -l)
else
    lines=$(wc -l < "${file}")
fi
if (( lines % 4 != 0 )); then
    echo "error: $(( lines )) lines in" "$file" "is not a whole number of reads" >&2
    exit 65
fi
echo $(( lines / 4 ))
