from nose.tools import *
from fqlib.rand import rand_alphastr_py, seed

seed()


def test_rand_alphastr_py():
    s = rand_alphastr_py(20)
    assert len(s) == 20
    assert s.isalpha()


def test_rand_alphastr_py_zero_len():
    s = rand_alphastr_py(0)
    assert len(s) == 0
    assert s == ""


def test_rand_alphastr_py_neg_len():
    with assert_raises(OverflowError):
        s = rand_alphastr_py(-1)