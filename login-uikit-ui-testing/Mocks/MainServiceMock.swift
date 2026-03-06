//
//  MainServiceMock.swift
//  login-uikit-ui-testing
//
//  Created by Jessica Vasquez on 11/02/2026.
//


final class MainServiceMock: MoviesService {
    var result: Result<Items, Error>?
    var fetchCalled: Bool = false
    // TODO: - check on  this, I believe it all about to avoid multiple calling
    
    func fetchMovies(page: Int, completion: @escaping (Result<Items, any Error>) -> Void) {
        fetchCalled = true
        guard let result = self.result else { return }
        completion(result)
    }
}
