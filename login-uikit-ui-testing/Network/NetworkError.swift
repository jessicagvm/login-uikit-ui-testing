//
//  NetworkError.swift
//  login-uikit-ui-testing
//
//  Created by Jessica Vasquez on 11/02/2026.
//


enum NetworkError: Error {
    case invalidURL
    case timeOut
    case invalidData
    case decodeError
    case invalidResponse
    
    // TODO: - 304 and 400 add status code 
    // improve this enum with message switch by the type of case
}
