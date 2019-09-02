//
//  DetailViewController.swift
//  Loblaw Digital
//
//  Created by Kunal Kumar on 2019-09-02.
//  Copyright © 2019 Loblaw. All rights reserved.
//

import UIKit

class LDDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var informationView: UIView! {
        didSet {
            self.informationView.layer.cornerRadius = 8
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    var dataModel: LDDataViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    func configureUI() {
        
        if let title = self.dataModel?.title {
            self.titleLabel.text = title
        } else {
            self.titleLabel.removeFromSuperview()
        }
        
        if let subTitle = self.dataModel?.subTitle {
            self.subTitleLabel.text = subTitle
        } else {
            self.subTitleLabel.removeFromSuperview()
        }
        
        _ = self.dataModel?.fetchImage(completion: { image in
            
            performOnMain {
                guard let _image = image else {
                    self.imageView.removeFromSuperview()
                    return
                }
                self.imageView.image = _image
            }
        })
        
    }
    
}
