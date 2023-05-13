//
//  ArticleCell.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import UIKit
import Kingfisher

class ArticleCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var articleImage: UIImageView!

    var article: Article?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        descriptionLabel.text = ""
        articleImage.image = nil

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    func setupCell(article: Article) {
        self.article = article
        setupView()
    }
    
    func setupView() {
        articleImage.layer.cornerRadius = 10.0
        articleImage.layer.masksToBounds = true
        guard let article else { return }
        if let title = article.byline, !title.isEmpty {
            titleLabel.text = title
        } else if let title = article.title {
            titleLabel.text = title
        }
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.8
        titleLabel.numberOfLines = 2
        if let section = article.section,
           let byline = article.byline,
           !section.isEmpty,
           !byline.isEmpty {
            descriptionLabel.text = "\(section)  •  \(byline)"
        } else if let section = article.section {
            descriptionLabel.text = "\(section)"
        } else if let byline = article.byline {
            descriptionLabel.text = "\(byline)"
        }
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.minimumScaleFactor = 0.8
        dateLabel.text = article.published_date
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.minimumScaleFactor = 0.8
        let placeHolderImage = UIImage(named: Strings.logo.fullString())
        guard let urlString = article.media.first?.mediaMetadata.first?.url,
        let url = URL(string: urlString) else {
            articleImage.image = placeHolderImage
            return
        }
        articleImage.kf.indicatorType = .activity
        articleImage.kf.setImage(
            with: url,
            placeholder: placeHolderImage,
            options: [
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
            ]
        )
    }
}
