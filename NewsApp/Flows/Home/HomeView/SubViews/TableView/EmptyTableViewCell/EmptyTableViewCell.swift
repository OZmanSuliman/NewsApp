//
//  EmptyTableViewCell.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import UIKit
import Lottie

class EmptyTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var animatedView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        accessibilityIdentifier = "EmptyTableViewCell"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setupView() {
        titleLabel.text = Strings.noArticle.fullString()
        subtitleLabel.text = Strings.noArticle.fullString()
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        let lottieView = LottieCustomView()
        animatedView.addSubview(lottieView)
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lottieView.leadingAnchor.constraint(equalTo: animatedView.leadingAnchor),
              lottieView.trailingAnchor.constraint(equalTo: animatedView.trailingAnchor),
              lottieView.topAnchor.constraint(equalTo: animatedView.topAnchor),
              lottieView.bottomAnchor.constraint(equalTo: animatedView.bottomAnchor)
        ])
        lottieView.makeUIView(name: Strings.emptyList.fullString())
        lottieView.play()
    }
}
