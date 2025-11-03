//
//  login_uikit_ui_testingUITests.swift
//  login-uikit-ui-testingUITests
//
//  Created by Jessica Vasquez on 21/10/2025.
//

import XCTest

final class login_uikit_ui_testingUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

   // @MainActor // lo habia escrito donde no era
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        let usernameTextField = app.textFields["username"] // im geeting all del textfield elements
        XCTAssert(usernameTextField.exists, "Not found usernameTextField") // check in if this exists
        usernameTextField.tap() // This a command to execute in the ui test // gesture and what actually the user does
        usernameTextField.typeText("Pedro") // another command to execute in the ui test .. the system gonna typing this

        
        let passwordTextField = app.secureTextFields["password"] // this particular elements, it is a secureTextfields
        XCTAssert(passwordTextField.exists)
        passwordTextField.tap()
        passwordTextField.typeText("password")
        
        let continueButton = app.buttons["continue"]
        XCTAssertTrue(continueButton.waitForExistence(timeout: 5))
        
//        if continueButton.isHittable {
//            app.swipeUp()
//        }
     // XCTAssertTrue(continueButton.isHittable)
     //   XCTAssert(continueButton.exists)
        continueButton.tap()
        
//        let accountLabel = app.staticTexts["Welcome, Pedro"]
//        XCTAssert(accountLabel.exists)
        
        // this is an example of other way to find the button in the screen - despite, it doesnt look like the right aprroach.
        // this command looks for text label on array of string rended in the view.
 //       app.staticTexts["continue"].press(forDuration: 0.5)
    }

   // @MainActor
//    func testLaunchPerformance() throws {
////        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
////            measure(metrics: [XCTApplicationLaunchMetric()]) {
////                XCUIApplication().launch()
////            }
////        }
//    }
}
