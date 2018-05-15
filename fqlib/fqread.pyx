# cython: infertypes=True
# cython: language_level=3
# cython: c_string_type=unicode
# cython: c_string_encoding=ascii
# distutils: language=c++

DEF NUM_INTERLEAVES = 2
DEF INTERLEAVE_LEN = 2
cdef char *POSSIBLE_INTERLEAVES[NUM_INTERLEAVES]
POSSIBLE_INTERLEAVES[:] = [<char*> "/1",<char*> "/2"]

cdef void fqread_init_empty(FastQRead &read):
    read.name = NULL
    read.sequence = NULL
    read.plusline = NULL
    read.quality = NULL
    read.interleave = NULL
    read.secondary_name = NULL


cdef void fqread_init(
    FastQRead &read, 
    char* name, 
    char* sequence, 
    char* plusline,
    char* quality
):
    """Initialize a FastQRead object based on the values passed in."""

    cdef char* interleave
    cdef char* suffix
    cdef char* tmp_name = NULL
    cdef char* tmp_secondary = NULL
    cdef int i = 0

    read.name = name
    read.sequence = sequence
    read.plusline = plusline
    read.quality = quality

    # optional fields
    read.interleave = <char*> ""
    read.secondary_name = <char*> "" 

    # parse secondary name
    tmp_name = strtok(name, " ")
    tmp_secondary = strtok(NULL, "")

    if tmp_name != NULL:
        read.name = tmp_name 
    if tmp_secondary != NULL:
        read.secondary_name = tmp_secondary

    # parse interleave
    cdef size_t name_len = strlen(read.name)
    cdef size_t suffix_offset = name_len - INTERLEAVE_LEN
    while i < NUM_INTERLEAVES:
        interleave = POSSIBLE_INTERLEAVES[i]
        if strcmp(read.name + suffix_offset, interleave) == 0:
            read.name[suffix_offset] = b'\0'
            read.interleave = interleave
        i += 1

cdef void fqread_populate_paired_reads(
    FastQRead &read_one, 
    FastQRead &read_two, 
    char* instrument,
    char* run_number,
    char *flowcell,
    char *interleave
):
    """Generate values emulating an Illumina-based FastQ read."""

    cdef char[1024] readname
    cdef char[64] lane 
    cdef char[64] tile
    cdef char[64] x_pos
    cdef char[64] y_pos
    cdef char[101] sequence_one
    cdef char[101] sequence_two
    cdef char *plusline = b"+"
    cdef char[101] quality_one
    cdef char[101] quality_two

    # Common fields

    sprintf(lane, "%d", <int> (rand() % 8 + 1)) # 8 lanes.
    sprintf(tile, "%d", <int> (rand() % 60 + 1)) # 60 tiles.
    sprintf(x_pos, "%d", <int> (rand() % 10000 + 1)) # 10,000 x-pos.
    sprintf(y_pos, "%d", <int> (rand() % 10000 + 1)) # 10,000 y-pos.

    strcpy(readname, b"@")
    strcat(readname, instrument)
    strcat(readname, b":")
    strcat(readname, run_number)
    strcat(readname, b":")
    strcat(readname, flowcell)
    strcat(readname, b":")
    strcat(readname, lane)
    strcat(readname, b":")
    strcat(readname, tile)
    strcat(readname, b":")
    strcat(readname, x_pos)
    strcat(readname, b":")
    strcat(readname, y_pos)
    strcat(readname, interleave)

    rand_nucl_str(sequence_one, 101)
    rand_qual_str(quality_one, 101)
    rand_nucl_str(sequence_two, 101)
    rand_qual_str(quality_two, 101)

    fqread_init(
        read_one,
        readname,
        sequence_one,
        plusline,
        quality_one
    )

    fqread_init(
        read_two,
        readname,
        sequence_two,
        plusline,
        quality_two
    )


cdef void fqread_write_to_file(FastQRead &read, FILE *f):
    fputs(read.name, f)
    if strcmp(read.interleave, "") != 0:
        fputs(read.interleave, f)
    if strcmp(read.secondary_name, "") != 0:
        fputs(" ", f)
        fputs(read.secondary_name, f)
    fputs(b"\n", f)
    fputs(read.sequence, f)
    fputs(b"\n", f)
    fputs(read.plusline, f)
    fputs(b"\n", f)
    fputs(read.quality, f)
    fputs(b"\n", f)


cdef void fqread_write_to_file_add_interleave(FastQRead &read, FILE *f, char* interleave):
    fputs(read.name, f)
    fputs(interleave, f)
    if strcmp(read.secondary_name, "") != 0:
        fputs(" ", f)
        fputs(read.secondary_name, f)
    fputs(b"\n", f)
    fputs(read.sequence, f)
    fputs(b"\n", f)
    fputs(read.plusline, f)
    fputs(b"\n", f)
    fputs(read.quality, f)
    fputs(b"\n", f)


cpdef str fqread_repr(FastQRead &read):
    cdef char[0x400] buff
    strcpy(buff, "FastQRead(name='")
    strcat(buff, read.name)
    strcat(buff, "', sequence='")
    strcat(buff, read.sequence)
    strcat(buff, "', plusline='")
    strcat(buff, read.plusline)
    strcat(buff, "', quality='")
    strcat(buff, read.quality)
    strcat(buff, "', interleave='")
    strcat(buff, read.interleave)
    strcat(buff, "', secondary_name='")
    strcat(buff, read.secondary_name)
    strcat(buff, "')")
    return buff