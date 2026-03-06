//
//  SessionManager.swift
//  login-uikit-ui-testing
//
//  Created by Jessica Vasquez on 04/03/2026.
//
import Foundation
import UIKit

final class SessionManager {
    var isAuthenticated: Bool = false
    static let shared = SessionManager() // TODO: - Singleton - how i can desacopled ?
    
    private init() {}
    
    func setAuthenticated(_ isAuthenticated: Bool) {
        self.isAuthenticated = isAuthenticated
    }
}

enum LaunchArguments: String {
    case uiTestsAuthenticated = "UITests_Authenticated"
    case uiTestsMovieSuccess = "UITests_MoviesSuccess"
}

//TODO: - should move to another file
final class AppCoordinator {
    
    func showMainView() -> MainViewController {
        let items: Items = [Item(title: "item 1", image: UIImage()),
                            Item(title: "item 2", image: UIImage()),
                            Item(title: "item 3", image: UIImage()),
                            Item(title: "item 4", image: UIImage())]
        
        let vc = MainViewController()
        
        let service: MoviesService = configureMoviesServiceIfNeeded()
        
        let presenter = MainViewPresenter(view: vc, service: service)
        
        vc.presenter = presenter
        
        return vc
    }
    
    func loginView() -> UIViewController {
        configureLoginServiceIfNeeded()
        if !SessionManager.shared.isAuthenticated {
            return LoginViewController()
        } else {
            return showMainView()
        }
    }
    
    func showDetailView() {}
    
    func configureMoviesServiceIfNeeded() -> MoviesService {
        let items: Items = [Item(title: "item 1", image: UIImage()),
                            Item(title: "item 2", image: UIImage()),
                            Item(title: "item 3", image: UIImage()),
                            Item(title: "item 4", image: UIImage())]
        if ProcessInfo.processInfo.arguments.contains(LaunchArguments.uiTestsMovieSuccess.rawValue) {
            let service = MainServiceMock()
            service.result = .success(items)
            return service
        }
        
        let mock = MainServiceMock()
        mock.result = .success(items)
        return mock //  FIXME: change to real service
    }
    
    func configureLoginServiceIfNeeded() {
        let uiTestAuthenticatedArgument: String = LaunchArguments.uiTestsAuthenticated.rawValue
        if ProcessInfo.processInfo.arguments.contains(uiTestAuthenticatedArgument) {
            SessionManager.shared.setAuthenticated(true)
        }
    }
}
