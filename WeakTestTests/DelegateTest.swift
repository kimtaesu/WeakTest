//
//  DelegateTest.swift
//  WeakTestTests
//
//  Created by tskim on 08/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import XCTest

protocol FriendListViewControllerDelegate: class { }

class FriendListViewControllerDelegateMock: FriendListViewControllerDelegate {}

class FriendListViewController: UIViewController {
    // asert fail must be weak
    var delegate: FriendListViewControllerDelegate?
}

class FriendListViewControllerTests: XCTestCase {
    func testDelegateNotRetained() {
        let controller = FriendListViewController()
        
        // Create a strong reference to a delegate object, then
        // assign it as the view controller's delegate
        var delegate = FriendListViewControllerDelegateMock()
        controller.delegate = delegate
        
        // Re-assign the strong reference to a new object, which
        // should cause the original object to be released, thus
        // setting the view controller's delegate to nil
        delegate = FriendListViewControllerDelegateMock()
        XCTAssertNil(controller.delegate)
    }
}
