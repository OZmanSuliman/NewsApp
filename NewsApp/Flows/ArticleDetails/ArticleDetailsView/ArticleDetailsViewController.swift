//
//  ArticleDetailsViewController.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import UIKit
import WebKit

protocol ArticleDetailsDisplayLogic {
    func updateArticle(_ article: NSAttributedString)
}

class ArticleDetailsViewController: UIViewController {
    @IBOutlet weak var banner: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var webview: WKWebView!
    
    
    var interactor: ArticleDetailsBusinessLogic?
    var config = ArticleDetailsConfig()
    var router: ArticleDetailsRouterLogic?
    var article: Article?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let article {
            self.interactor?.fetchArticle(article)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ArticleDetailsViewController {
    private func setupView() {
        let backButtonImage = UIImage(named: Strings.backButton.fullString())
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton

        guard let article else { return }
        if let urlString = article.url, let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webview.load(request)
        }
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
        let placeHolderImage = UIImage(named: Strings.HeaderBg.fullString())
        guard let urlString = article.media.first?.mediaMetadata.last?.url,
        let url = URL(string: urlString) else {
            banner.image = placeHolderImage
            return
        }
        banner.kf.indicatorType = .activity
        banner.kf.setImage(
            with: url,
            placeholder: placeHolderImage,
            options: [
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
            ]
        )
    }
}


extension ArticleDetailsViewController: ArticleDetailsDisplayLogic {
    func updateArticle(_ article: NSAttributedString) {
//        textView.attributedText = article
    }
}
