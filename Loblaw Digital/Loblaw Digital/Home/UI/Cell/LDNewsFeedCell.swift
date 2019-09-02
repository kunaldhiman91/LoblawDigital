//
//  LDNewsFeedCell.swift
//  Loblaw Digital
//
//  Created by Kunal Kumar on 2019-08-30.
//  Copyright © 2019 Kunal Kumar. All rights reserved.
//

import Foundation
import UIKit.UIImage

/// Protocol Providing interface for ViewModel Interaction
protocol LDNewsFeedCellViewModeling {
    // Title for newsfeed.
    var title: String? { get }
    
    // Show/Hide image view based on data response.
    var shouldHideImage: Bool { get }
    
    // Provide a way to load images.
    func fetchImage(completion: @escaping ((UIImage?) -> Void))
}

/// News Feed Cell.
class LDNewsFeedCell: UITableViewCell {
    // MARK: IBOutlets
    @IBOutlet weak var containerView: UIView! {
        didSet {
            self.containerView.layer.cornerRadius = 8
        }
    }
    
    private var viewModel: LDNewsFeedCellViewModeling?
    
    @IBOutlet private var newsImageView: UIImageView!
    
    @IBOutlet private weak var newsTitleLabel: UILabel!
    
    @IBOutlet private var imageViewConstraints: [NSLayoutConstraint]!
    
    // MARK: Public methods
    
    /**
     Setup Table view cell for model.
     
     - Parameters:
     - viewModel: The LDNewsFeedCellViewModeling type view model.
     
     - Returns: Void.
    */
    func setupTableViewCell(viewModel model: LDNewsFeedCellViewModeling?) {
        guard let viewModel = model else { return }
        self.viewModel = viewModel
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
    
    // MARK: Private methods
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
