//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Marinò, Marco on 12/11/21.
//

import UIKit
import Reusable

protocol HomeViewControllerDelegate: AnyObject {
    func homeViewControllerDidTapNews(_ homeViewController: HomeViewController, news: News)
}

class HomeViewController: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    weak var coordinatorDelegate: HomeViewControllerDelegate?
    
    var news: [News]? {
        didSet {
            guard isViewLoaded, oldValue != news else { return }
            self.newsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Home"
        
        setup()
    }
    
    private func setup() {
        activityIndicator.startAnimating()
        setupTableView()
    }
    
    private func setupTableView() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(cellType: NewsTableViewCell.self)
        newsTableView.separatorStyle = .none
    }
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let mock = news else { return }
        coordinatorDelegate?.homeViewControllerDidTapNews(self, news: mock[indexPath.row])
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (news != nil) ? news!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as NewsTableViewCell
        
        if let mock = news {
            activityIndicator.stopAnimating()
            let row = mock[indexPath.row]
            cell.configure(category: row.section, title: row.title, date: row.date, media: row.media?[0])
        }
        
        return cell
    }
    
    
}

extension HomeViewController: StoryboardSceneBased {
    static let sceneStoryboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
}
