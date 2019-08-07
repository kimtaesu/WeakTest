//
//  ObserverCorrectTest.swift
//  WeakTestTests
//
//  Created by tskim on 08/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import XCTest

private  protocol UserManagerObserver: class {}
private class UserManagerObserverMock: UserManagerObserver {}
private class UserManager {
    private var observers = [ObserverWrapper]()
    
    func addObserver(_ observer: UserManagerObserver) {
        let wrapper = ObserverWrapper(observer: observer)
        observers.append(wrapper)
    }
}

private extension UserManager {
    struct ObserverWrapper {
        weak var observer: UserManagerObserver?
    }
}

class ObserverCorrectTest: XCTestCase {
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
