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

cdef char *rand_alphastr(char* buff, size_t blen)
cdef char *rand_nuclstr(char* buff, size_t blen)

cdef char *rand_alphastr_alloc(size_t slen)
cdef char *rand_nuclstr_alloc(size_t slen)

cpdef char *rand_alphastr_py(size_t slen)
cpdef char *rand_nuclstr_py(size_t slen)