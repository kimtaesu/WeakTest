//
//  WeakTestTests.swift
//  WeakTestTests
//
//  Created by tskim on 08/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import XCTest

class WeakRef { }
class WeakTestTests: XCTestCase {
    var strongMock: WeakRef? = WeakRef()
    func testWeakVarDeallocation() {
        
        weak var weakMock = strongMock
        
        print("weakMock is \(weakMock)")
        
        let expt = self.expectation(description: "deallocated")
        
        strongMock = nil
        
        print("weakMock is now \(weakMock)")
        
        DispatchQueue.main.async {
            XCTAssertNil(weakMock)      // This assertion fails
            
            print("fulfilling expectation")
            expt.fulfill()
        }
        
        print("waiting for expectation")
        self.waitForExpectations(timeout: 1.0, handler: nil)
        print("expectation fulfilled")
    }
}
