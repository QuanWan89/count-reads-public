#!/usr/bin/env bash
# test_count_reads.sh — tiny.fastq holds 3 reads; count_reads.sh must say 3, plain and gzipped.
set -euo pipefail

here=$(cd "$(dirname "$0")" && pwd)
gz=$(mktemp "${TMPDIR:-/tmp}/tiny.XXXXXX")
gzip -c "${here}/tiny.fastq" > "${gz}.fastq.gz"

for f in "${here}/tiny.fastq" "${gz}.fastq.gz"; do
    got=$(bash "${here}/../count_reads.sh" "${f}")
    if [[ ${got} != 3 ]]; then
        echo "FAIL: $(basename "${f}") holds 3 reads; count_reads.sh says ${got}"
        exit 1
    fi
done
rm -f "${gz}" "${gz}.fastq.gz"

# A truncated file: its last read has two of its four lines.
if bash "${here}/../count_reads.sh" "${here}/truncated.fastq" 2>/dev/null; then
    echo "FAIL: truncated.fastq is cut off mid-read; count_reads.sh did not refuse it"
    exit 1
fi
echo "PASS: 3 reads, plain and gzipped; a truncated file refused"
