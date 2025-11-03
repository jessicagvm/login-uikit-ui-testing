//
//  ViewModel.swift
//  login-uikit-ui-testing
//
//  Created by Jessica Vasquez on 27/10/2025.
//

import Foundation

// the aim is to use combine in the future due to it's right tool to work with uikit

enum InputError: Error {
    case empty
    case invalid
   // case other
}

enum TextFieldType { // where do these structs should be ?
    case username
    case password
}



class ViewModel {
    private(set) var isLoginEnabled = false
    private(set) var isUsernameValide = false // naming
    private(set) var isPasswordValide = false
    
    func didFinishEnterTextfield(_ input: String, type: TextFieldType) {
        // show alert
        // TODO: - thing to make a note
        // (try? or try!) got it the function doesnt return a value (Int/ Bool, etc) due to or the fuction may be marked such as a throwing function or to handle error
        
        // do catch in this case.
        
        switch type {
        case .username:
            handleUsernameTextFieldEnter(with: input)
        case .password:
            handlePasswordTextFieldEnter(with: input)
        }
    }
}


// TODO: - private control access make this function untestable, what is right approach to handle ?
 
extension ViewModel {
    func handleUsernameTextFieldEnter(with input: String) { // ???
        do {
            try didFinishEnterUsername(input)
            updateLoginButtonStatusIfNeeed()
            return
        } catch InputError.empty {
        } catch InputError.invalid {
        } catch _ {
        }
        
        updateLoginButtonStatusIfNeeed() // ? **
    }
    
    func handlePasswordTextFieldEnter(with input: String) { // ???
        do {
            try didFinishEnterPassword(input)
            updateLoginButtonStatusIfNeeed()
            return //**
        } catch InputError.empty {
            
        } catch InputError.invalid {
            
        } catch _ {
            
        }
       
        updateLoginButtonStatusIfNeeed()
    }
    
    func didFinishEnterUsername(_ username: String) throws {
        isUsernameValide = false
        guard !username.isEmpty else {
            throw InputError.empty
        }
        
        guard username.count > 5 else { // validacion formatte
            throw InputError.invalid
        }
        
//        guard username == "" else { // validacion formatte
//            throw InputError.invalid
//        }
       
        isUsernameValide.toggle() // capaz esto es true directamente 
    }
    
    func didFinishEnterPassword(_ password: String) throws {
        isPasswordValide = false
        
        guard !password.isEmpty else {
            throw InputError.empty
        }
        
        guard password.count > 8 else { // validacion formatte
            throw InputError.invalid
        }
        
//        guard password == "" else { // validacion
//            throw InputError.invalid
//        }
        
        isPasswordValide.toggle()
    }
    
    func updateLoginButtonStatusIfNeeed() {
        guard isUsernameValide && isPasswordValide else {
            isLoginEnabled = false
            return
        }
       
        isLoginEnabled.toggle() // revisar
        // ui should update as well
    }
}
