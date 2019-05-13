//
//  ResultTableViewCell.swift
//  SearchApp
//
//  Created by Anna Cherkes on 5/12/19.
//  Copyright © 2019 AnnaCherkes. All rights reserved.
//

import UIKit

public class ResultTableViewCell: UITableViewCell {

    private var gifImageView: UIImageView?
    private var title: UILabel?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }

    public func setup(_ url: String?, title: String?) {
        
        addContent()
        
        if let urlString = url {
            setGif(with: urlString)
        }
        
        if let textTile = title {
            guard let titleLabel = self.title else { return }
            titleLabel.text = textTile
        }
    }
    
    private func setGif(with url: String) {
        DispatchQueue.global(qos: .userInitiated).async {
            let imageURL = UIImage.gifImageWithURL(gifUrl: url)
            DispatchQueue.main.async {
                guard let gifImageView = self.gifImageView else { return }
                gifImageView.image = imageURL
            }
        }
    }

    private func addContent() {
        
        gifImageView?.removeFromSuperview()
        title?.removeFromSuperview()
        
        gifImageView = nil
        title = nil
    
        title = UILabel(frame: CGRect.zero)
        guard let title = title else { return }
        contentView.addSubview(title)
        let margin = contentView.layoutMarginsGuide
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: margin.topAnchor, constant: 0).isActive = true
        title.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: -16).isActive = true
        title.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: 16).isActive = true
        title.heightAnchor.constraint(equalToConstant: 30).isActive = true
    
        gifImageView = UIImageView(frame: CGRect.zero)
        guard let gifImageView = gifImageView else { return }
        
        contentView.addSubview(gifImageView)
        gifImageView.layer.cornerRadius = 8
        let marginOfTitle = title.layoutMarginsGuide
        gifImageView.translatesAutoresizingMaskIntoConstraints = false
        gifImageView.topAnchor.constraint(equalTo: marginOfTitle.bottomAnchor, constant: 10).isActive = true
        gifImageView.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: -16).isActive = true
        gifImageView.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: 16).isActive = true
        gifImageView.bottomAnchor.constraint(equalTo: margin.bottomAnchor, constant: 0).isActive = true
        gifImageView.contentMode = .scaleAspectFill
        gifImageView.clipsToBounds = true
    }
}
