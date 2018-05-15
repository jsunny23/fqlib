# cython: infertypes=True
# cython: language_level=3
# cython: c_string_type=unicode
# cython: c_string_encoding=ascii
# distutils: language=c++

cdef char *alpha_charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
cdef char *nucl_charset =  "ACGT"
cdef size_t alpha_charset_len = strlen(alpha_charset)
cdef size_t nucl_charset_len = strlen(nucl_charset)

cpdef void seed():
    """Seeds the RNG with the time."""
    srand(time(NULL))


cdef char *rand_str(char *buff, size_t blen, char *charset, size_t cslen):
    """Create a random string of characters from charset.

    Arguments:
        buff (char*): a pointer to a preallocated char buffer.
        blen (size_t): size of the buffer, including the terminating byte.
        charset (char*): location of all of the characters we can randomly sample as a
                         C string.
        cslen (size_t): strlen of charset.

    Returns:
        A pointer to the buffer, for convenience.
    """

    cdef int key

    if blen:
        blen = blen - 1
        for i in range(blen):
            key = rand() % cslen 
            buff[i] = charset[key]

        buff[blen] = b'\0'
    
    return buff


cdef char *rand_alphastr(char* buff, size_t blen):
    """Create a random string of alphabetical characters without allocating a new
    memory buffer.

    See:
        rand_str() as this is just utilizing that with a specific charset for
        convenience.
    """
    return rand_str(buff, blen, alpha_charset, alpha_charset_len)


cdef char *rand_nuclstr(char* buff, size_t blen):
    """Create a random string of nucleotides as they would appear in a human genomic
    read from Illumina without allocating a new memory buffer.

    See:
        rand_str() as this is just utilizing that with a specific charset for
        convenience.
    """
    return rand_str(buff, blen, nucl_charset, nucl_charset_len)


cdef char *rand_str_alloc(size_t slen, char* charset, size_t cslen):
    """Allocate a string on the heap an initialize it to random chars.
    This function is a wrapper for rand_str, but it follows best practice for
    indicating to the caller about the underlying allocation (thus, the name).

    Arguments:
        slen (size_t): number of character in the string to be returned.
        charset (char*): location of all of the characters we can randomly sample as a
                         C string.
        cslen (size_t): strlen of charset.

    Notes:
        The value returned by this function must be freed to avoid memory leaks!

    Returns:
        A newly allocated and randomly initialized C string in the successful case.
        NULL in the failure case.
    """

    cdef char *s = <char*> malloc(slen + 1)
    if s:
        rand_str(s, slen + 1, charset, cslen)
    return s


cdef char *rand_alphastr_alloc(size_t slen):
    """Create a random string of alphabetical characters (including uppercase and 
    lowercase characters).

    See:
        rand_str_alloc() as this is just utilizing that with a specific charset for
        convenience.
    """

    return rand_str_alloc(slen, alpha_charset, alpha_charset_len)


cdef char *rand_nuclstr_alloc(size_t slen):
    """Create a random string of nucleotides as they would appear in a human genomic
    read from Illumina.

    See:
        rand_str_alloc() as this is just utilizing that with a specific charset for
        convenience.
    """

    return rand_str_alloc(slen, nucl_charset, nucl_charset_len)


cpdef char *rand_alphastr_py(size_t slen):
    "Python wrapper of rand_alphastr_alloc, for testing."
    return rand_alphastr_alloc(slen)


cpdef char *rand_nuclstr_py(size_t slen):
    "Python wrapper of rand_nuclstring_alloc, for testing."
    return rand_nuclstr_alloc(slen)