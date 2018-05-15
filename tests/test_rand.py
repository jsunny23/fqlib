from nose.tools import *
from fqlib.rand import rand_alpha_str_py, seed

seed()


def test_rand_alpha_str_py():
    s = rand_alpha_str_py(20)
    assert len(s) == 20
    assert s.isalpha()


def test_rand_alpha_str_py_zero_len():
    s = rand_alpha_str_py(0)
    assert len(s) == 0
    assert s == ""


def test_rand_alpha_str_py_neg_len():
    with assert_raises(OverflowError):
        s = rand_alpha_str_py(-1)