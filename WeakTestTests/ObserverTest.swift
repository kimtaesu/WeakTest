//
//  Observers.swift
//  WeakTestTests
//
//  Created by tskim on 08/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import XCTest

private  protocol UserManagerObserver {}
private class UserManager {
    private var observers = [UserManagerObserver]()
    
    func addObserver(_ observer: UserManagerObserver) {
        observers.append(observer)
    }
}
private class UserManagerObserverMock: UserManagerObserver {}

class ObserverTest: XCTestCase {
    func testObserversNotRetained() {
        let manager = UserManager()
        
        // Create both a strong and a weak local reference to an
        // observer, which we then add to our UserManager
        var observer = UserManagerObserverMock()
        weak var weakObserver = observer
        manager.addObserver(observer)
        
        // If we re-assign the strong reference to a new object,
        // we expect the weak reference to become nil, since
        // observers shouldn't be retained
        observer = UserManagerObserverMock()
        XCTAssertNil(weakObserver)
    }
}
