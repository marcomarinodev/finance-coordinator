//
//  ViewController.swift
//  NewsApp
//
//  Created by Marinò, Marco on 11/11/21.
//

import UIKit
import Reusable

protocol TourViewControllerDelegate: AnyObject {
    func tourViewControllerDidTapNext(_ tourViewController: TourViewController)
}

class TourViewController: UIViewController {

    var nextButton: CustomButton?
    
    weak var coordinatorDelegate: TourViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setup() {
        
        setupUI()
        
    }

    private func setupUI() {
        
        let size = CGSize(width: view.frame.width - 100, height: 50)
        let origin = CGPoint(x: (view.frame.width / 2) - (size.width / 2), y: (view.frame.height / 2) - (size.height / 2))
        nextButton = CustomButton(frame: CGRect(origin: origin, size: size))
        nextButton!.titleText = "Next"
        nextButton?.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
        
        view.addSubview(nextButton!)
    }
    
    @objc func nextPressed() {
        coordinatorDelegate?.tourViewControllerDidTapNext(self)
    }
    
}

extension TourViewController: StoryboardSceneBased {
    static let sceneStoryboard: UIStoryboard = UIStoryboard(name: "Tour", bundle: nil)
}
