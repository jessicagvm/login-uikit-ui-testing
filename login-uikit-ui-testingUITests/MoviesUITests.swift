//
//  MoviesUITests.swift
//  login-uikit-ui-testingUITests
//
//  Created by Jessica Vasquez on 21/02/2026.
//

import XCTest

final class MoviesUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    private var table: XCUIElement { app.tables[AccessibilityIdentifiers.MainView.tableViewId].firstMatch }
    private var  cell: XCUIElement { app.cells[AccessibilityIdentifiers.MainView.cellId].firstMatch }
    
    private var  detailStaticText: String { app.staticTexts[AccessibilityIdentifiers.DetailView.titleLabelId].firstMatch.label }
    
    override func setUp()  {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        
        // TODO: - process info is chargering to save launchArguments and there have to be logic to support navigation validation and render state such as success, error, empty state, etc.
        app.launchArguments = [
            "UITests_Authenticated",
            "UITests_MoviesSuccess"
        ]
        
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    func testMovies_RenderCells() {
        XCTAssertTrue(table.waitForExistence(timeout: 1))
        XCTAssertTrue(cell.exists)
    }
    
    func testMovies_WhenDidTapCell_NavigatesToDetail() {
        XCTAssertTrue(cell.waitForExistence(timeout: 1))
        cell.tap()
        
        let expectedDetailTitle = "Selected Item"
        XCTAssertEqual(detailStaticText, expectedDetailTitle)
    }
}
