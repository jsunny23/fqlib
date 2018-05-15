# cython: infertypes=True
# cython: language_level=3
# cython: c_string_type=unicode
# cython: c_string_encoding=ascii
# distutils: language=c++

cdef char *ALPHA_CHARSET = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
cdef char *ALPHA_UPPER_CHARSET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
cdef char *NUCL_CHARSET = "ACGT"
cdef char* QUAL_CHARSET = "@ABCDEFGHIJ"

# Clay: for now, we'll stick with with the higher quality symbols
#       since the character is chosen from a uniform distribution. This
#       is primarily to ensure that the data is not distracting.
# cdef char* QUAL_CHARSET = "!\"#$%&'(*+,-./0123456789:;<=>?@ABCDEFGHIJ"

cdef size_t ALPHA_CHARSET_LEN = strlen(ALPHA_CHARSET)
cdef size_t ALPHA_UPPER_CHARSET_LEN = strlen(ALPHA_UPPER_CHARSET)
cdef size_t NUCL_CHARSET_LEN = strlen(NUCL_CHARSET)
cdef size_t QUAL_CHARSET_LEN = strlen(QUAL_CHARSET)


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


cdef char *rand_alpha_str(char *buff, size_t blen):
    return rand_str(buff, blen, ALPHA_CHARSET, ALPHA_CHARSET_LEN)


cdef char *rand_alpha_upper_str(char *buff, size_t blen):
    return rand_str(buff, blen, ALPHA_UPPER_CHARSET, ALPHA_UPPER_CHARSET_LEN)


cdef char *rand_nucl_str(char *buff, size_t blen):
    return rand_str(buff, blen, NUCL_CHARSET, NUCL_CHARSET_LEN)


cdef char *rand_qual_str(char *buff, size_t blen): 
    return rand_str(buff, blen, QUAL_CHARSET, QUAL_CHARSET_LEN)


cpdef char *rand_alpha_str_py(size_t slen):
    "Python wrapper of rand_str_alloc, for testing."
    return rand_str_alloc(slen, ALPHA_CHARSET, ALPHA_CHARSET_LEN)


cpdef char *rand_nucl_str_py(size_t slen):
    "Python wrapper of rand_str_alloc, for testing."
    return rand_str_alloc(slen, NUCL_CHARSET, NUCL_CHARSET_LEN)