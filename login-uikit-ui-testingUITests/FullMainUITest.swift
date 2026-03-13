//
//  FullMainUITest.swift
//  login-uikit-ui-testingUITests
//
//  Created by Jessica Vasquez on 21/02/2026.
//

import XCTest

final class FullMainUITest: XCTestCase {
    
    private var app: XCUIApplication!
    
    private var userTextField: XCUIElement { app.textFields[AccessibilityIdentifiers.LoginView.usernameTextFieldId].firstMatch }
    
    private var passwordTextField: XCUIElement { app.secureTextFields[AccessibilityIdentifiers.LoginView.passwordextFielId].firstMatch }
    
    private var continueButton: XCUIElement { app.buttons[AccessibilityIdentifiers.LoginView.continueButtonId].firstMatch }
    
    private var cell: XCUIElement { app.cells[AccessibilityIdentifiers.MainView.cellId].firstMatch }
    
    private var detailTitle: String { app.staticTexts[AccessibilityIdentifiers.DetailView.titleLabelId].firstMatch.label }
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    func testFromLoginToDetail() {
        // TODO: - aseert to know if exist
        userTextField.tap()
        userTextField.typeText("Jake\n")
        
        passwordTextField.tap()
        passwordTextField.typeText("password\n")
        
        XCTAssertTrue(continueButton.isHittable)
        continueButton.tap()
        
        XCTAssertTrue(cell.waitForExistence(timeout: 1))
        cell.tap()
        
        let expectedDetailTitle = "Selected Item"
        XCTAssertEqual(detailTitle, expectedDetailTitle)
    }
}
