# cython: infertypes=True
# cython: language_level=3
# cython: c_string_type=unicode
# cython: c_string_encoding=ascii
# distutils: language=c++

from libc.stdio cimport FILE, fopen, fputs, fclose, sprintf
from libc.stdlib cimport rand
from fqlib.fqread cimport (
    FastQRead, 
    fqread_populate_paired_reads, 
    fqread_write_to_file_add_interleave
)
from fqlib.rand cimport rand_alpha_upper_str

cdef class FastQWriter:
    cdef public char* filename_readone
    cdef public char* filename_readtwo 
    cdef public char[64] instrument
    cdef public char[64] flowcell
    cdef public char[64] run_number

    cpdef generate(self, n_reads)