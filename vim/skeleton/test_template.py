import unittest

class MyTestCaseName(unittest.TestCase):

    def setUp(self):
        pass

    def tearDown(self):
        pass

    def testSomeThing(self):
        self.assertTrue(3 == 3)
        self.assertEquals(3, 2 + 1)
