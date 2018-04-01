import XCTest

import geodesicTests

var tests = [XCTestCaseEntry]()
tests += geodesicTests.allTests()
XCTMain(tests)
