//
//  ClosureTest.swift
//  WeakTestTests
//
//  Created by tskim on 08/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import XCTest

protocol NetworkManager: class {
    func send()
}
class NetworkManagerMock: NetworkManager {
    func mockResponse(for: URL, with: Data?) -> NetworkManager {
        return self
    }
    func send() {
        
    }
}
class ImageLoader {
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    func loadImage(from url: URL, completionHandler: @escaping (UIImage) -> Void) {
    }
}

class ImageLoaderTests: XCTestCase {
    func testCompletionHandlersRemoved() {
        // Setup an image loader with a mocked network manager
        let networkManager = NetworkManagerMock()
        let loader = ImageLoader(networkManager: networkManager)
        
        // Mock a response for a given URL
        let url = URL(fileURLWithPath: "image")
        let data = UIImage().pngData()
        let response = networkManager.mockResponse(for: url, with: data)
        
        // Create an object (it can be of any type), and hold both
        // a strong and a weak reference to it
        var object = NSObject()
        var weakObject = object
//        weak var weakObject = object
        
        loader.loadImage(from: url) { [object] image in
            // Capture the object in the closure (note that we need to use
            // a capture list like [object] above in order for the object
            // to be captured by reference instead of by pointer value)
            _ = object
        }
        
        // Send the response, which should cause the above closure to be run
        // and then removed & released
        response.send()
        
        // When we re-assign our local strong reference to a new object the
        // weak reference should become nil, since the closure should have been
        // run and removed at this point
        object = NSObject()
        XCTAssertNil(weakObject)
    }
}
