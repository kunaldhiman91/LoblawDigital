//
//  DetailViewController.swift
//  Loblaw Digital
//
//  Created by Kunal Kumar on 2019-09-02.
//  Copyright © 2019 Kunal Kumar. All rights reserved.
//

import UIKit

/// LDDetailViewController: Displaying image, title and subtitle for selected Swift news.
class LDDetailViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var informationView: UIView! {
        didSet {
            self.informationView.layer.cornerRadius = 8
        }
    }
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var imageViewPlaceHolderView: UIView!
    
    @IBOutlet var imageViewPlaceHolderViewConstraints: [NSLayoutConstraint]!
    
    @IBOutlet var informationViewConstraints: [NSLayoutConstraint]!
    
    // MARK: Properties
    var dataModel: LDDataViewModel?
    
    // MARK: ViewController Life Cycles.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    // MARK: Private Methods.
    func configureUI() {
        
        if let title = self.dataModel?.title {
            self.title = title
        }
        
        if let subTitle = self.dataModel?.subTitle, subTitle.count > 0 {
            self.subTitleLabel.text = subTitle
        } else {
            self.informationView.removeFromSuperview()
        self.contentView.removeConstraints(self.informationViewConstraints)
            self.contentView.layoutIfNeeded()
        }
        
        _ = self.dataModel?.fetchImage(completion: { image in
            performOnMain {
                guard let _image = image else {
                    self.imageView.removeFromSuperview()
                    self.contentView.removeConstraints(self.imageViewPlaceHolderViewConstraints)
                    self.contentView.layoutIfNeeded()
                    return
                }
                self.imageView.image = _image
            }
        })
        self.view.layoutIfNeeded()
    }
}
