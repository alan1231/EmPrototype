//
//  EmPrototypeTests.swift
//  EmPrototypeTests
//
//  Created by alan on 2018/6/28.
//  Copyright © 2018年 alan. All rights reserved.
//

import XCTest
@testable import EmPrototype

class EmPrototypeTests: XCTestCase {
    override func setUp() {
        super.setUp()
  
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        print("tearDown... ")

    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testAdd(){
        XCTAssert(true)
    }
}
