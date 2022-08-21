//
//  CustomCell.swift
//  petrovskyiGenesisTask
//
//  Created by Mac on 16.08.2022.
//

import UIKit

class CustomCell: UICollectionViewCell {
   
    var data: CustomData? {
        didSet {
            guard let data = data else { return }
            bg.image = data.image
        }
    }
    
    fileprivate let bg: UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "0")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        //iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(bg)
        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        bg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
