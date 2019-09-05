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
    
    var thumbnail: UIImage? { get }
    
    // Provide a way to load images.
    func fetchImage(completion: @escaping ((UIImage?) -> Void))
}

protocol LDNewsFeedCellImageDownload {
    var imageDownloaded: (Bool) -> Void { get }
}

/// News Feed Cell.
class LDNewsFeedCell: UITableViewCell, LDNewsFeedCellImageDownload {
    
    var imageDownloaded: (Bool) -> Void = { _ in }
    
    // MARK: IBOutlets
    @IBOutlet weak var containerView: UIView! {
        didSet {
            self.containerView.layer.cornerRadius = 8
            self.containerView.layer.shadowColor = UIColor.black.cgColor
            self.containerView.layer.shadowOpacity = 0.6
            self.containerView.layer.shadowOffset = .zero
            self.containerView.layer.shadowRadius = 1
        }
    }
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel: LDNewsFeedCellViewModeling?
    
    @IBOutlet private var newsImageView: UIImageView!
    
    @IBOutlet private weak var newsTitleLabel: UILabel!
    
    @IBOutlet private var imageViewConstraints: [NSLayoutConstraint]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
    }
    
    // MARK: Public methods
    
    /**
     Setup Table view cell for model.
     
     - Parameters:
     - viewModel: The LDNewsFeedCellViewModeling type view model.
     
     - Returns: Void.
    */
    func setupTableViewCell(viewModel model: LDNewsFeedCellViewModeling?) {
        if !self.activityIndicator.isHidden {
            self.activityIndicator.startAnimating()
        }
        guard let viewModel = model else { return }
        self.viewModel = viewModel
        self.newsTitleLabel.text = viewModel.title ?? ""
        
        if let image = viewModel.thumbnail {
            self.newsImageView.image = image
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        } else {
            viewModel.fetchImage(completion: { image in
                performOnMain {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    guard let _image = image else {
                        self.removeImage(true)
                        return
                    }
                    self.imageDownloaded(true)
                    self.newsImageView.image = _image
                }
            })
        }
        self.removeImage(viewModel.shouldHideImage)
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
