//
//  ArticleViewController.swift
//  NewsApp
//
//  Created by Marinò, Marco on 14/11/21.
//

import UIKit
import Reusable

protocol ArticleViewControllerDelegate: AnyObject {
    func articleViewControllerWillDismiss(_ articleViewController: ArticleViewController)
}

class ArticleViewController: UIViewController {

    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsImageView: DownloadedImage!
    @IBOutlet weak var newsTextView: UITextView!
    
    var article: News? {
        didSet {
            guard isViewLoaded else { return }
            setupNews()
        }
    }
    
    weak var coordinatorDelegate: ArticleViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        setupNews()
        setupUI()
    }
    
    private func setupUI() {}
    
    private func setupNews() {
        guard let article = article else { return }
        
        newsTitleLabel.text = article.title
        if let media = article.media, let imgURL = URL(string: media[0].imageURL) {
            newsImageView.loadImage(with: imgURL)
        } else {
            newsImageView.backgroundColor = .lightGray
        }
        newsTextView.text = article.abstract
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        coordinatorDelegate?.articleViewControllerWillDismiss(self)
    }

}

extension ArticleViewController: StoryboardSceneBased {
    static let sceneStoryboard: UIStoryboard = UIStoryboard(name: "Article", bundle: nil)
}
