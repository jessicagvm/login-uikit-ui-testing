//
//  login_uikit_ui_testingTests.swift
//  login-uikit-ui-testingTests
//
//  Created by Jessica Vasquez on 21/10/2025.
//

import XCTest
@testable import login_uikit_ui_testing // Ok
// concepto de handle error and throwing function

final class LoginTests: XCTestCase {
    
    func testDidFinishEnterTextField_whenUsenameTextFieldType() { //TODO: - ** what does it must be testing here ?
   
    }
    
    
    func testHandleUsernameTextFieldEnter_whenValidUsernameInputAndValidPassword_thenEnabledButton() { // TODO: - spelling
        // Given
        let input = "Username"
        let sut = ViewModel()
        // sut.isPasswordValide = true // TODO: -  is it correct ? the system does allowed because it is private
        
        // When
        sut.handleUsernameTextFieldEnter(with: input)
       
        // Then
        XCTAssertTrue(sut.isUsernameValide) // TODO: - what's else ? 
    }
    

    func testDidFinishEnterUsername_whenEmptyStringInput_thenthrowEmptyInputError_andDisableIsUsernameValide() throws { //**
        // TODO:- check function naming, and should check the button status boolean ?
        // Given
        let input = ""
        let expectedError: InputError = .empty
        let sut = ViewModel()
        
        // When
        // try sut.didFinishEnterUsername(input) **
        // TODO: - what suposed to be a the When ?? how especific check
      
        // Then
        // TODO: - check on this
        XCTAssertFalse(sut.isUsernameValide)
        XCTAssertThrowsError(try sut.didFinishEnterPassword(input), "", { error in
            let outputError: InputError? = error as? InputError
            XCTAssertNotNil(outputError)
            XCTAssertEqual(outputError, expectedError)
        })
      
        XCTAssertEqual(sut.isUsernameValide, false) // ** tiene sentido ??
      //  XCTAssertFalse(sut.isLoginEnabled) // ** this should be check in on the global function when the error is handling it
    }
    
    func testDidFinishEnterUsername_withInvalidStringInput_thenThrowInvalidInputError_andDisableIsUsernameValide() throws {
        // Given
        let input = "test" // too short username
        let expectedOutput = InputError.invalid
        let sut = ViewModel()
        
        // When
        // Then
        XCTAssertThrowsError(try sut.didFinishEnterUsername(input), "", { error in
            let output: InputError? = error as? InputError
            
            XCTAssertNotNil(output)
            XCTAssertEqual(output, expectedOutput)
        })
      
        XCTAssertFalse(sut.isUsernameValide)
       // XCTAssertFalse(sut.isLoginEnabled) // este valor deberia ser inicial de username
    }
    
    // TODO: - both got validate value **
    func testDidFinishEnterUsername_whenValidStringInput_thenNoThrowError_andEnableUsernameBoolean() throws {
        // Given
        let input = "Username"
      //  let expectedError = nil
        let sut = ViewModel()
        
        // When
        
        
        // Then
        XCTAssertNoThrow(try sut.didFinishEnterUsername(input))
        XCTAssertTrue(sut.isUsernameValide) // TODO: - check this validation
    }
    
    func testDidFinishEnterPassword_whenEmptyStringInput_thenThrowsEmptyInputError_andDisabledPasswordBoolean() throws {}
    
    func testDidFinishEnterPassword_whenInvalidStringInput_thenThrowsInvalidInputError_andDisabledPasswordBoolean() throws {}
    
    func testDidFinishEnterPassword_whenValidInput_thenNoThrowsError_andEnabledPasswordBoolean() throws {}
    
    func testUpdateLoginButtonStateIfNeeded_whenOneInvalidInput_thenDisabledLogin() {
//        // Given
//        let invalidUsernameInput = ""
//        let validPasswordInput = "password"
//        let sut = ViewModel()
//        
//        // When
////        try sut.didFinishEnterUsername(invalidUsernameInput) // revisar esto
////        try sut.didFinishEnterPassword(validPasswordInput)
//
//        sut.updateLoginButtonStatusIfNeeed()
//       
//        // Then
//        XCTAssertFalse(sut.isUsernameValide)
//        XCTAssertTrue(sut.isPasswordValide)
//        XCTAssertFalse(sut.isLoginEnabled)
    }
  
    func testUpdateLoginButtonStateIfNeeeded_whenBothInvalidInput_thenDisabledLogin() {}
    
    func testUpdateLoginButtonStateIfNeeded_whenBothValideInput_thenEnabledLogin() {}

}
