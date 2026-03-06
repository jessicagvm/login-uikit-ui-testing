//
//  MainViewPresenter.swift
//  login-uikit-ui-testing
//
//  Created by Jessica Vasquez on 27/01/2026.
//

import Foundation
import UIKit

enum State {
    case idle(viewModel: Items)
    case load
    case error(message: String)
    case loading
}

class MainViewPresenter: MainViewPresenterProtocol {
    // This is a dependecy, to avoid strong reference we use weak
    private weak var view: MainViewProtocol?
    //  var model: Items? //  Must be change to ViewModel
    private var viewModel: [MovieViewModel] = []
    // this must be change to MoviesService
    private let service: MoviesService
    
    private var currentPage = 1 // this we add pagination
    //  private var isLoading = false - check this later
    //  FIXME: - since i believe handling state can be better.
    
    ///  private var selectedItem: MovieViewModel?
    
    init(view: MainViewProtocol, service: MoviesService) {
        self.service = service
        self.view = view
    }
    
    func viewDidLoad() {
        getItems()
    }
    
    func didPullRefresh() {
        // TODO: - this must be improving after a review
        getItems()
    }
    
    func didTapCell(with indexPath: IndexPath) {
        guard !viewModel.isEmpty else { return }
        let row = indexPath.row
        let item: MovieViewModel = viewModel[row] // ?? nil
        
        //       guard let item = viewModel[row] as? MoviewViewModel else { return }
        view?.showDetailView(for: item)
        // selectedItem = nil ??
    }
    
    private func getItems() { // check later ***
        view?.showLoadingView(true) // check later
        
        //  guard let service = service is MainServiceMock else { return }
        
        self.service.fetchMovies(page: 1) { [weak self] result in // check this later
            self?.view?.showLoadingView(false)
            switch result {
            case .success(let items):
                self?.handleSuccess(for: items)
            case .failure(let error):
                self?.handleError(for: error)
            }
        }
    }
    
    private func getViewModel(for items: Items) -> [MovieViewModel] { // check this later
        guard !items.isEmpty else { return [] }
        var movies: [MovieViewModel] = []
        items.forEach { item in
            guard let url = URL(string: "www.google.com") else { return }
            let movie = MovieViewModel(title: item.title, imageURL: url)
            movies.append(movie)
        }
        return movies
    }
    
    private func handleSuccess(for items: Items) {
        let loadedViewModel = getViewModel(for: items)
        
        if self.viewModel.isEmpty, loadedViewModel.isEmpty {
            view?.showEmptyStateView()
        } else if !viewModel.isEmpty {
            self.viewModel += loadedViewModel
            self.currentPage += 1
            view?.showMovies(viewModel)
            // current page
        } else {
            // update Table
            self.viewModel += loadedViewModel
            self.currentPage = 1 // i'm not sure about tbis number.
            view?.showMovies(viewModel)
        }
    }
    
    private func handleError(for error: Error) {
        guard  self.viewModel.isEmpty, let error = error as? NetworkError else { return }
        var message: String = ""
        switch error {
        case .invalidURL:
            message = "Ops something it's wrong"
        default: break // other view might add a reload
        }
        
        view?.showErrorView(message: message)
    }
}



/*
 func loadMovies() {
 guard !isLoading else { return }
 
 isLoading = true
 view?.showLoading()
 
 service.fetchMovies(page: currentPage) { [weak self] result in
 guard let self = self else { return }
 self.isLoading = false
 
 switch result {
 case .success(let newMovies):
 if newMovies.isEmpty && self.movies.isEmpty {
 self.view?.showEmptyState()
 } else {
 self.movies.append(contentsOf: newMovies)
 self.currentPage += 1
 self.view?.showMovies(self.movies.map(self.mapToViewModel))
 }
 
 case .failure:
 self.view?.showError(message: "Something went wrong")
 }
 }
 } */


