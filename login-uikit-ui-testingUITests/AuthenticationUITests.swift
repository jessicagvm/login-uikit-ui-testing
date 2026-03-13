//
//  AuthenticationUITests.swift
//  login-uikit-ui-testingUITests
//
//  Created by Jessica Vasquez on 19/02/2026.
//

import XCTest

final class AuthenticationUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    private var usernameTextField: XCUIElement {
        // TODO: - lazy
        app.textFields[AccessibilityIdentifiers.LoginView.usernameTextFieldId].firstMatch
    }
    
    private var passwordTextField: XCUIElement { app.secureTextFields[AccessibilityIdentifiers.LoginView.passwordextFielId].firstMatch
    }
    
    // TODO: - first match is a good practice
    // TODO: -  this es a good practice also "private var continueButton: XCUIElement { app.buttons.element(id: AccessibilityIdentifiers.LoginView.continueButtonId, label: "continue").firstMatch }"
    private var continueButton: XCUIElement { app.buttons[AccessibilityIdentifiers.LoginView.continueButtonId].firstMatch }
    
    private var table: XCUIElement { app.tables[AccessibilityIdentifiers.MainView.tableViewId].firstMatch
    }
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        //  super.tearDownWithError()
        // TODO: - throws error  and super.init
        app = nil
        // TODO: - what it happens with the computed properties
        // usernameTextField = nil, tendria que ser let
    }
    
    func testLoginScreen_IsVisible_WhenNotAuthenticated() {
        XCTAssertTrue(usernameTextField.exists)
        XCTAssertTrue(passwordTextField.exists)
        XCTAssertTrue(continueButton.exists)
    }
    
    func testLoginScreen_SuccessLogin_NavigateToMovies() {
        usernameTextField.tap()
        usernameTextField.typeText("Peter\n")
        
        passwordTextField.tap()
        // MARK: - this was a conflict since the keyboard key has hidden the button view and they frames was changed -- the following line hides the keyboard
        passwordTextField.typeText("password\n")
        
        // TODO: -  delete this
        //print(app.debugDescription)
        XCTAssertTrue(continueButton.isHittable)
        continueButton.tap()
        
        XCTAssertTrue(table.waitForExistence(timeout: 1))
    }
}


// TODO: - this should be placed in another file
struct AccessibilityIdentifiers {
    struct LoginView {
        static let usernameTextFieldId: String = "loginView.usernameTextField.id"
        static let passwordextFielId: String = "loginView.passwordTextField.id"
        static let continueButtonId: String = "loginView.continueButton.id"
    }
    
    struct MainView {
        static let tableViewId: String = "mainView.tableView.id"
        static let cellId: String = "mainView.cellView.id"
    }
    
    struct DetailView {
        static let titleLabelId: String =
        "detailView.titleLabel.id"
    }
}

// TODO: - what is this ?
extension XCUIElementQuery {
    func element(id identifier: String, label: String) -> XCUIElement {
        let predicate = NSPredicate(format: "identifier == %@ AND label == %@", identifier, label)
        return element(matching: predicate)
    }
}
