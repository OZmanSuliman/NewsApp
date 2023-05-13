//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import UIKit

protocol HomeDisplayLogic {
    func displayArticles(_ articles: [Article])
    func showLoader()
    func showError(error: String)
}

enum Periods: String {
    case seven = "7"
    case one = "1"
    case thirty = "30"
    
    func displayText() -> String {
        return "\(self.rawValue) \(Strings.day.fullString())"
    }
}

class HomeViewController: UIViewController {
    @IBOutlet weak var mainStack: UIStackView!
    @IBOutlet weak var headerView: HomeHeaderView!
    @IBOutlet weak var ArticlesTableView: UITableView!
    @IBOutlet weak var infoView: UIView!
    var config = HomeConfiguration()
    var interactor: HomeBusinessLogic?
    var articles: [Article] = []
    var router: HomeRoutingLogic?
    let pickerView = UIPickerView()
    var pickerContainerView = UIView()
    var period = Periods.seven.rawValue
    let periodList = [Periods.one, Periods.seven, Periods.thirty]
    let periodTitleLabel = UILabel()
    let refreshControl = UIRefreshControl()

    private var isLoading = true
    private var isShowingError = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupViews()
        self.interactor?.fetchArticles(period: period)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    private func setupViews() {
        self.infoView.isHidden = !isLoading
        self.ArticlesTableView.isHidden = isLoading
    }
    
    func setupTableView() {
        self.ArticlesTableView.dataSource = self
        self.ArticlesTableView.delegate = self
        self.ArticlesTableView.registerNib(ArticleCell.self)
        self.ArticlesTableView.registerNib(EmptyTableViewCell.self)
        self.ArticlesTableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count > 0 ?
        self.articles.count :
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.articles.count <= 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.identifierCell,
                                                           for: indexPath) as? EmptyTableViewCell else {
                return UITableViewCell(style: .default, reuseIdentifier: Strings.identifier.fullString())
            }
            cell.selectionStyle = .none
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.identifierCell,
                                                       for: indexPath) as? ArticleCell else {
            return UITableViewCell(style: .default, reuseIdentifier: Strings.identifier.fullString())
        }
        cell.setupCell(article: self.articles[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: Strings.Delete.fullString()) { (action, view, completionHandler) in
            self.interactor?.removeArticle(self.articles[indexPath.row])
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: Strings.trash.fullString())
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard articles.count > 0 else { return }
        self.router?.navigateToDetails(article: articles[indexPath.row])
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HomeTableViewHeaderView.instanceFromNib()
        headerView.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.articles.count > 0 ?
        107 :
        300
    }
    
    @objc func refreshData(_ sender: UIRefreshControl) {
        refreshControl.isUserInteractionEnabled = false
        DispatchQueue.main.async {
            self.interactor?.fetchArticles(period: self.period)
            sender.endRefreshing()
        }
    }
}

extension HomeViewController: HomeTableViewHeaderProtocol {
    func hideSelector() {
        pickerContainerView.removeFromSuperview()
        periodTitleLabel.removeFromSuperview()
        ArticlesTableView.reloadData()
    }
    
    func showSelector() {
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerContainerView = UIView(frame: view.bounds)
        pickerContainerView.backgroundColor = UIColor.systemBackground
        pickerView.center = pickerContainerView.center
        pickerContainerView.addSubview(pickerView)
        periodTitleLabel.text = Strings.periodTitle.fullString()
        periodTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        periodTitleLabel.textColor = .white
        periodTitleLabel.sizeToFit()
        periodTitleLabel.frame.origin = CGPoint(x: pickerContainerView.bounds.midX - (periodTitleLabel.frame.width / 2),
                                                y: pickerView.frame.origin.y - periodTitleLabel.frame.height - 10)
        self.pickerContainerView.addSubview(periodTitleLabel)
        self.view.addSubview(pickerContainerView)
    }
}

extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return periodList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return periodList[row].displayText()
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        hideSelector()
        self.period = periodList[row].rawValue
        self.interactor?.fetchArticles(period: self.period)
    }

}

extension HomeViewController: HomeDisplayLogic {
    func displayArticles(_ articles: [Article]) {
        self.isShowingError = false
        self.articles = articles
        self.hideLoader()
        DispatchQueue.main.async {
            self.ArticlesTableView.reloadData()
        }
    }

    func showLoader() {
        isLoading = true
        DispatchQueue.main.async {
            let lottieView = LottieCustomView()
            self.infoView.addSubview(lottieView)
            lottieView.translatesAutoresizingMaskIntoConstraints = false
   
            NSLayoutConstraint.activate([
                  lottieView.topAnchor.constraint(equalTo: self.infoView.topAnchor),
                  lottieView.leadingAnchor.constraint(equalTo: self.infoView.leadingAnchor),
                  lottieView.trailingAnchor.constraint(equalTo: self.infoView.trailingAnchor),
                  lottieView.heightAnchor.constraint(equalTo: self.infoView.heightAnchor, multiplier: 1)
              ])
            
            lottieView.makeUIView(name: Strings.loader.fullString())
            lottieView.play()
            self.infoView.isHidden = false
            self.ArticlesTableView.isHidden = true
        }
    }

    private func hideLoader() {
        isLoading = false
        DispatchQueue.main.async {
            self.infoView.isHidden = true
            self.ArticlesTableView.isHidden = false
            self.infoView.subviews.forEach({
                $0.removeFromSuperview()
            })
        }
    }
    
    func showError(error: String) {
        self.hideLoader()
        self.isShowingError = true
        DispatchQueue.main.async {
            self.infoView.isHidden = false
            self.ArticlesTableView.isHidden = true
            let label = UILabel()
            label.text = ("\(error) \n try again")
            label.numberOfLines = 2
            label.font = UIFont.systemFont(ofSize: 18)
            label.textColor = UIColor.systemBlue
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            self.infoView.addSubview(label)
            let lottieView = LottieCustomView()
            self.infoView.addSubview(lottieView)
            lottieView.translatesAutoresizingMaskIntoConstraints = false
   
            NSLayoutConstraint.activate([
                  lottieView.topAnchor.constraint(equalTo: self.infoView.topAnchor),
                  lottieView.leadingAnchor.constraint(equalTo: self.infoView.leadingAnchor),
                  lottieView.trailingAnchor.constraint(equalTo: self.infoView.trailingAnchor),
                  lottieView.heightAnchor.constraint(equalTo: self.infoView.heightAnchor, multiplier: 0.7),
                  
                  label.topAnchor.constraint(equalTo: lottieView.bottomAnchor, constant: 8),
                  label.leadingAnchor.constraint(equalTo: self.infoView.leadingAnchor),
                  label.trailingAnchor.constraint(equalTo: self.infoView.trailingAnchor),
                  label.bottomAnchor.constraint(equalTo: self.infoView.bottomAnchor)
              ])
            
            lottieView.makeUIView(name: Strings.errorFile.fullString())
            lottieView.play()
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.retryGetData(_:)))
            self.infoView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    private func hideError() {
        isShowingError = false
        DispatchQueue.main.async {
            self.infoView.isHidden = true
            self.ArticlesTableView.isHidden = false
            self.infoView.subviews.forEach({
                $0.removeFromSuperview()
            })
        }
    }
    
}

extension HomeViewController {
    @objc private func retryGetData(_ gestureRecognizer: UITapGestureRecognizer) {
        hideError()
        self.interactor?.fetchArticles(period: period)
    }
}
