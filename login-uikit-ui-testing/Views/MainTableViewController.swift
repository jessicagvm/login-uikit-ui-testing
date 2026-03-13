//
//  MainTableViewController.swift
//  login-uikit-ui-testing
//
//  Created by Jessica Vasquez on 26/01/2026.
//

import UIKit

protocol MainTableViewProtocol: AnyObject { // FIXME: - should be renaming 
    func didTapCell(with indexPath: IndexPath)
    func didPullResquest()
}

class MainTableViewController: UITableViewController {
    private(set) var model: [MovieViewModel] = []
    
    weak var delegate: MainTableViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func configure(with model: [MovieViewModel]) {
        self.model = model
        tableView.reloadData()
    }
    
    private func setUp() {
        view.backgroundColor = .black
        tableView.separatorStyle = .none
        // TODO: - those are very import and special points
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        tableView.register(MainHeaderView.self, forHeaderFooterViewReuseIdentifier: MainHeaderView.identifier)
        tableView.estimatedRowHeight = 140
        tableView.sectionHeaderHeight = 152
    }
}

extension MainTableViewController {
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 152
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let item = model.first, let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainHeaderView.identifier) as? MainHeaderView else { return UIView() }

        view.configure(with: item)
        return view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: - this very import and special point reuseIdentifier
        guard let cell: MainTableViewCell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: model[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTapCell(with: indexPath)
    }
}
