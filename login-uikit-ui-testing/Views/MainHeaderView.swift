//
//  MainHeaderView.swift
//  login-uikit-ui-testing
//
//  Created by Jessica Vasquez on 27/01/2026.
//

import UIKit

class MainHeaderView: UITableViewHeaderFooterView {
    static let identifier = "MainHeaderView" // TODO: - May this rename ?
  
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with model: MovieViewModel) {
        // FIXME: - use model data
        titleLabel.text = "For U" // model.title
        // posterImageView.image = model.image.withRenderingMode(.alwaysOriginal)
        posterImageView.image = model.placeholderImage.withRenderingMode(.alwaysOriginal)
    }
    
}

private extension MainHeaderView {
    func setUp() {
        self.backgroundColor = .black
        setUpTitleLabel()
        setUpPosterImageView()
        setUpHierarchy()
        setUpConstraints()
    }
    
    func setUpTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .lightGray
    }
    
    func setUpPosterImageView() {
        posterImageView.backgroundColor = .black
        // TODO: - get knowledge about it
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 8
        posterImageView.layer.borderWidth = 1
        posterImageView.layer.borderColor = UIColor.white.cgColor
    }
    
    func setUpHierarchy() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        titleLabel.bringSubviewToFront(posterImageView)
    }
    
    func setUpConstraints() {
        setUpPosterImageViewConstraints()
        setUpTitleLabelConstraints()
    }
    
    func setUpTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func setUpPosterImageViewConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 12),
            posterImageView.widthAnchor.constraint(equalToConstant: 182),
            posterImageView.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: self.titleLabel.topAnchor, constant: -10)
        ])
    }
}
