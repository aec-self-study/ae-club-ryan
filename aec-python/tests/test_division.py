import unittest
from calc import aec_divide

class TestDivide(unittest.TestCase):
    def test_divide(self):
        arg_ints = [10, 5]
        div_result = aec_divide(arg_ints)
        self.assertEqual(div_result, 2)

    def test_cant_divide_by_zero(self):
        arg_ints = [10,0]
        div_result = aec_divide(arg_ints)
        self.assertEqual(div_result,  0)
    
    def test_divide_three(self):
        arg_ints = [20, 4, 5]
        with self.assertRaisesRegex(Exception, "More than two args") as context:
            aec_divide(arg_ints)

if __name__ == "__main__":
    unittest.main()