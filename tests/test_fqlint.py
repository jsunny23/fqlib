import os
import shlex
from subprocess import Popen, PIPE


def command(cmd):
    process = Popen(shlex.split(cmd), stdout=PIPE, stderr=PIPE)
    (stdout, stderr) = process.communicate()
    exitcode = process.wait()
    return (stdout.decode("UTF-8"), stderr.decode("UTF-8"), exitcode)


def test_wellformed():
    read_one = os.path.abspath("./tests/inputs/00_wellformed/R1.fastq.gz")
    read_two = os.path.abspath("./tests/inputs/00_wellformed/R2.fastq.gz")
    (stdout, stderr, exitcode) = command(f"fqlint {read_one} {read_two}")
    assert exitcode == 0


def test_incomplete_reads():
    read_one = os.path.abspath("./tests/inputs/01_incomplete_reads/R1.fastq.gz")
    read_two = os.path.abspath("./tests/inputs/01_incomplete_reads/R2.fastq.gz")
    (stdout, stderr, exitcode) = command(f"fqlint {read_one} {read_two}")
    assert exitcode == 1


def test_mismatched_read_names():
    read_one = os.path.abspath(
        "./tests/inputs/02_mismatched_readnames/R1.fastq.gz"
    )
    read_two = os.path.abspath(
        "./tests/inputs/02_mismatched_readnames/R2.fastq.gz"
    )
    (stdout, stderr, exitcode) = command(f"fqlint {read_one} {read_two}")
    assert exitcode == 2