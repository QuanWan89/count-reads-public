# count-reads

How many reads a FASTQ file holds: `bash count_reads.sh reads.fastq.gz`.

`tests/test_count_reads.sh` checks it on `tests/tiny.fastq` (3 reads), plain and gzipped. GitHub Actions
runs ShellCheck and the test on every push to `main` and every pull request
(`.github/workflows/check.yml`).
