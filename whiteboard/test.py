from whiteboard import *
# change whiteboard to python file name, you can change * to function name
import unittest

class TidyTest(unittest.TestCase):

    def test_true(self):
        self.assertTrue(is_tidy(12))
        
    def test_false(self):
        self.assertFalse(is_tidy(102))

unittest.main()