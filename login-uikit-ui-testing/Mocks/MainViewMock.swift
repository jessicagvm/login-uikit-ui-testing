//
//  MainViewMock 2.swift
//  login-uikit-ui-testing
//
//  Created by Jessica Vasquez on 11/02/2026.
//


final class MainViewMock: MainViewProtocol {
    // TODO: -  Check, my understading about it, it all variebles are saved view states. Why ?? - because test func are checking these variable
    var isLoading = false // I'm not sure about this one, because its a state mutable state
    var viewModel: [MovieViewModel] = []
    var message: String = ""
    var isEmptyState = false
    var selectedItem: MovieViewModel?
    
    
    func showMovies(_ viewModel: [MovieViewModel]) {
        self.viewModel = viewModel
    }
    
    func showLoadingView(_ isLoading: Bool) {
        self.isLoading = isLoading
    }
    
    func showErrorView(message: String) {
        self.message = message
    }
    
    func showEmptyStateView() {
        isEmptyState = true
    }
    
    func updateTable(with model: [MovieViewModel]) {
        viewModel = model
    }
    
    func showDetailView(for item: MovieViewModel) {
        selectedItem = item
    }
}
