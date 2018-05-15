# cython: infertypes=True
# cython: language_level=3
# cython: c_string_type=unicode
# cython: c_string_encoding=ascii
# distutils: language=c++

from libc.stdlib cimport malloc, srand, rand
from libc.time cimport time
from libc.string cimport strlen

cpdef void seed()
cdef char *rand_str(char *buff, size_t blen, char *charset, size_t cslen)
cdef char *rand_str_alloc(size_t slen, char* charset, size_t cslen)

cdef char *rand_alpha_str(char *buff, size_t blen)
cdef char *rand_alpha_upper_str(char *buff, size_t blen)
cdef char *rand_nucl_str(char *buff, size_t blen)
cdef char *rand_qual_str(char *buff, size_t blen)