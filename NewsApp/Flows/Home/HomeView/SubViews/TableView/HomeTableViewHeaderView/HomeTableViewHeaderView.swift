//
//  HomeTableViewHeaderView.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import UIKit
import Lottie

protocol HomeTableViewHeaderProtocol {
    func showSelector()
}
class HomeTableViewHeaderView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var periodContainer: UIView!
    let lottieView = LottieCustomView()
    var delegate: HomeTableViewHeaderProtocol?
    
    class func instanceFromNib() -> HomeTableViewHeaderView {
        return (UINib(nibName: String(describing: HomeTableViewHeaderView.self),
                      bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? HomeTableViewHeaderView)!
    }

    override  func awakeFromNib() {
        setupView()
    }

    func setupView() {
        setTitleFont()
        setupPeriodSelector()
    }
    
    func setTitleFont() {
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.text = Strings.Articles.fullString()
    }
    
    func setupPeriodSelector() {
        DispatchQueue.main.async {
            self.periodContainer.addSubview(self.lottieView)
            self.lottieView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.lottieView.topAnchor.constraint(equalTo: self.periodContainer.topAnchor),
                self.lottieView.leadingAnchor.constraint(equalTo: self.periodContainer.leadingAnchor),
                self.lottieView.trailingAnchor.constraint(equalTo: self.periodContainer.trailingAnchor),
                self.lottieView.heightAnchor.constraint(equalTo: self.periodContainer.heightAnchor)
              ])
            self.lottieView.makeUIView(name: Strings.filterIcon.fullString())
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.selectPeriod(_:)))
            self.periodContainer.addGestureRecognizer(gesture)
        }
    }
}

extension HomeTableViewHeaderView {
    @objc func selectPeriod(_ gestureRecognizer: UITapGestureRecognizer) {
        changeAnimation(completion: {self.delegate?.showSelector()})
    }
    
    func changeAnimation(completion: (() -> Void)? = nil) {
        self.periodContainer.isUserInteractionEnabled = false
        if lottieView.getProgress() == 0.5 {
            self.lottieView.play(from: 0.5 ,to: 0, loopMode: .playOnce, completion: { finished in
                completion?()
                self.periodContainer.isUserInteractionEnabled = true
            })
        } else {
            self.lottieView.play(from: 0, to: 0.5, loopMode: .playOnce, completion: { finished in
                self.periodContainer.isUserInteractionEnabled = true
                completion?()
            })
        }
    }
}
