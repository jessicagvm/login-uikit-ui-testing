//
//  MoviesService.swift
//  login-uikit-ui-testing
//
//  Created by Jessica Vasquez on 11/02/2026.
//
import Foundation

// TODO: - clean this file and desacopled
protocol MoviesService: AnyObject {
    func fetchMovies(
        page: Int,
        completion: @escaping (Result<Items, Error>) -> Void
    )
}

// While this is a genere definition for the network layer
protocol EndpointProtocol {
    func fecth<T: Decodable>(request: URLRequest, completionHandler: @escaping (Result<T, NetworkError>) ->()) // ** check later
}

final class Network: EndpointProtocol {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func fecth<T>(request: URLRequest, completionHandler: @escaping (Result<T, NetworkError>) -> ()) where T : Decodable { // ** check later @escaping
        session.dataTask(with: request) { data, response, error in
            
            guard let error = error as? NetworkError else {
                guard let response = response as? HTTPURLResponse, response.statusCode > 199, response.statusCode < 399 else { // check later
                    let error: NetworkError = .invalidResponse
                    completionHandler(.failure(error))
                    return
                }
                
                guard let data = data else { // use case for must be nil
                    let error: NetworkError = . invalidData
                    completionHandler(.failure(error))
                    return
                }
                
                do {
                    let decoder = JSONDecoder() // ** Check later // jsonDecoder
                    let object = try decoder.decode(T.self, from: data) // check later try , .self
                    // empty object
                    /* - si tiene data, muestra un ui distinta a error
                     - si no tiene data, muestra una ui de error lo decide el presenter */
                    completionHandler(.success(object))
                } catch {
                    let error: NetworkError = .decodeError
                    completionHandler(.failure(error))
                }
                return
            }
            completionHandler(.failure(error))
            // persistent data
        }.resume()
    }
}
