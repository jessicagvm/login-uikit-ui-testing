//
//  MainTableViewCell.swift
//  login-uikit-ui-testing
//
//  Created by Jessica Vasquez on 26/01/2026.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    static let identifier = "MainTableViewCellIdentifier"
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with model: MovieViewModel) {
        //FIXME: - real data
        titleLabel.text = model.title
        //  posterImageView.image = model.imageURL.withRenderingMode(.alwaysOriginal)
        posterImageView.image = model.placeholderImage.withRenderingMode(.alwaysOriginal)
    }
}
private extension MainTableViewCell {
    func setUp() {
        self.backgroundColor = .black
        self.contentView.backgroundColor = .black
        self.accessibilityIdentifier = AccessibilityIdentifiers.MainView.cellId
        setUpTitleLabel()
        setUpPosterImageView()
        setUpHierarchy()
        setUpConstraints()
    }
    
    func setUpTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .lightGray
    }
    
    func setUpPosterImageView() {
        posterImageView.backgroundColor = .black
        posterImageView.clipsToBounds = true
    }
    
    func setUpHierarchy() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
    }
    
    func setUpConstraints() {
        setUpPosterImageViewConstraints()
        setUpTitleLabelConstraints()
    }
    
    func setUpTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -4),
            titleLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func setUpPosterImageViewConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor),
            posterImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 4),
            posterImageView.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 91/57)
            // TODO: - aspect ratio i beleive i search in a website 
        ])
    }
}
