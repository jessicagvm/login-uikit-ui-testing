//
//  Login_testingPerfomanceTests.swift
//  login-uikit-ui-testingTests
//
//  Created by Jessica Vasquez on 31/10/2025.
//

import XCTest
@testable import login_uikit_ui_testing

final class LoginPerformanceTests: XCTestCase {

//    func testPerformanceLaunch() throws { // TODO: - should go in a different file - error
////        let app = XCUIApplication()
////        self.measure(metrics: [XCTApplicationLaunchMetric()]) {
////            XCUIApplication().launch()
////        }
//        
//        measure(metrics: [XCTApplicationLaunchMetric()]) {
//            XCUIApplication().launch()
//        }
//    }
    
    func testPerfomanceValidationLoginBehavior() { // TODO: - is about a function ? or the ovarall integration of the behavior. computation value right ?
        
        let sut = ViewModel()
        self.measure(metrics: [XCTCPUMetric()]) { // TODO: - need something else ? check this implementation
            for _ in 0..<100000 {
                sut.didFinishEnterTextfield("Username", type: .username)
            }
        }
    }
}
