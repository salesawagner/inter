//
//  ListRow.swift
// inter
//
//  Created by Wagner Sales on 29/01/24.
//

import UIKit

final class ListCell: UITableViewCell {
    static var identifier = String(describing: ListCell.self)

    // MARK: Properties

    private let thumbnail = UIImageView()
    private let officialLabel = UILabel()
    private let nameLabel = UILabel()
    private let capitalLabel = UILabel()

    // MARK: Inits

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnail.image = nil
        thumbnail.backgroundColor = .clear
    }

    // MARK: Private Methods

    private func setupUI() {
        setupThumbnail()
        setupLabels()
        setupStackView()
        accessoryType = .disclosureIndicator
    }

    private func setupThumbnail() {
        let size = 80.0
        thumbnail.contentMode = .scaleAspectFill
        thumbnail.clipsToBounds = true
        thumbnail.layer.cornerRadius = size/2
        thumbnail.layer.borderWidth = 4
        thumbnail.layer.borderColor = UIColor.white.cgColor

        NSLayoutConstraint.activate([
            thumbnail.widthAnchor.constraint(equalToConstant: size),
            thumbnail.heightAnchor.constraint(equalToConstant: size)
        ])
    }

    private func setupLabels() {
        nameLabel.font = UIFont.systemFont(ofSize: 24)
        officialLabel.font = UIFont.systemFont(ofSize: 14)
        capitalLabel.font = UIFont.systemFont(ofSize: 14)
    }

    private func setupStackView() {
        let spacing = 8.0
        let stackViewVertical = UIStackView()
        stackViewVertical.axis = .vertical
        stackViewVertical.alignment = .top
        stackViewVertical.spacing = spacing/2

        stackViewVertical.addArrangedSubview(nameLabel)
        stackViewVertical.addArrangedSubview(officialLabel)
        stackViewVertical.addArrangedSubview(capitalLabel)

        let stackViewHorizontal = UIStackView()
        stackViewHorizontal.axis = .horizontal
        stackViewHorizontal.alignment = .top
        stackViewHorizontal.spacing = 3*spacing
        stackViewHorizontal.addArrangedSubview(thumbnail)
        stackViewHorizontal.addArrangedSubview(stackViewVertical)

        stackViewHorizontal.fill(on: self, insets: .all(constant: 2*spacing))
    }

    // MARK: Internal Methods

    func setup(with viewModel: ListRowViewModel) {
        thumbnail.loadFromUrl(stringURL: viewModel.thumbnailURL)
        nameLabel.text = viewModel.common
        officialLabel.text = viewModel.official
        capitalLabel.text = viewModel.capital
    }
}
