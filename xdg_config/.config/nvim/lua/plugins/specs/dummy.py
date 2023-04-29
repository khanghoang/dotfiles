import pytest

from myapp.app import multiply_by_two, divide_by_two

def outside_function(self):
    res = multiply_by_two(1)
    assert res == 2

class ClassFoo:
    def inside_function_one(self):
        res = multiply_by_two(1)
        assert res == 2

    def test_inside_function_two(self):
        res = divide_by_two(2)
        assert res == 1
