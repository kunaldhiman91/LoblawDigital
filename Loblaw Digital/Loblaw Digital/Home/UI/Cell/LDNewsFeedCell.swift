//
//  LDNewsFeedCell.swift
//  Loblaw Digital
//
//  Created by Kunal Kumar on 2019-08-30.
//  Copyright © 2019 Loblaw. All rights reserved.
//

import Foundation
import UIKit.UIImage

protocol LDNewsFeedCellViewModeling {
    
    var title: String? { get }
    var shouldHideImage: Bool { get }
    func fetchImage(completion: @escaping ((UIImage?) -> Void))
    
}

class LDNewsFeedCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            
            self.containerView.layer.cornerRadius = 8
            
        }
    }
    
    @IBOutlet private var newsImageView: UIImageView!
    
    @IBOutlet private weak var newsTitleLabel: UILabel!
    
    @IBOutlet private var imageViewConstraints: [NSLayoutConstraint]!
    
    var viewModel: LDNewsFeedCellViewModeling?
    
    func setupTableViewCell() {
        
        guard let viewModel = self.viewModel else { return }
        
        self.newsTitleLabel.text = viewModel.title ?? ""
        
        viewModel.fetchImage(completion: { image in
            performOnMain {
                guard let _image = image else {
                    self.removeImage(true)
                    return
                }
                self.newsImageView.image = _image
                self.removeImage(viewModel.shouldHideImage)
            }
        })
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        self.newsImageView.image = nil
//        self.newsTitleLabel.text = nil
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func removeImage(_ remove: Bool) {
        if remove {
            self.containerView.removeConstraints(self.imageViewConstraints)
            self.newsImageView.removeFromSuperview()
        } else {
            if self.newsImageView.superview == nil {
                self.containerView.addSubview(self.newsImageView)
                self.containerView.addConstraints(self.imageViewConstraints)
            }
        }
        self.contentView.layoutIfNeeded()
    }
    
}

extension LDNewsFeedCell {
    static let identifier = "LDNewsFeedCellIdentifier"
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self.classForCoder()),
                     bundle: nil)
    }
}
