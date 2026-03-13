//
//  MainViewProtocol.swift
//  login-uikit-ui-testing
//
//  Created by Jessica Vasquez on 11/02/2026.
//


protocol MainViewProtocol: AnyObject {
    // use case
    // TODO: - add state to handle configure view
    // func configure(with model: Items) // ** check later
    func showMovies(_ viewModel: [MovieViewModel])
    func showLoadingView(_ isLoading: Bool) // check this
    func showErrorView(message: String)
    func showEmptyStateView()
    func updateTable(with model: [MovieViewModel])
    func showDetailView(for item: MovieViewModel)
}
