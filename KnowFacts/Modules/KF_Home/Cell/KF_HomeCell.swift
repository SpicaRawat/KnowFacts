//
//  KF_HomeCell.swift
//  KnowFacts
//
//  Created by Spica Rawat on 20/09/20.
//  Copyright © 2020 spicarawat. All rights reserved.
//

import UIKit
import SDWebImage

class KF_HomeCell: UITableViewCell {

    let borderVw: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2.0
        view.clipsToBounds = true
        return view
    }()
    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        return lbl
    }()
    
    let descLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.textColor = .black
        return lbl
    }()
    
    let factImage: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFit
        return img
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        //borderVw
        addSubview(borderVw)
        let cornerConstraintForborderVw = ConrnerAnchor(top: (topAnchor, 10), bottom: (bottomAnchor, 10), left: (leftAnchor, 10), right: (rightAnchor, 10))
        borderVw.addConstraints(cornerConstraints: cornerConstraintForborderVw, centerY: nil, centerX: nil, height: 0, width: 0)
        
        borderVw.addSubview(titleLbl)
        borderVw.addSubview(factImage)
        borderVw.addSubview(descLbl)

        //titleLbl
        let cornerConstraintFortitleLbl = ConrnerAnchor(top: (borderVw.topAnchor, constantPadding), bottom: (factImage.topAnchor, constantPadding), left: (borderVw.leftAnchor, constantPadding), right: (borderVw.rightAnchor, constantPadding))
        titleLbl.addConstraints(cornerConstraints: cornerConstraintFortitleLbl, centerY: nil, centerX: nil, height: 0, width: 0)
        titleLbl.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true

        //factImage
        let cornerConstraintForItemImg = ConrnerAnchor(top: (titleLbl.bottomAnchor, constantPadding), bottom: (descLbl.topAnchor, constantPadding), left: (borderVw.leftAnchor, constantPadding), right: (nil,0))
        factImage.addConstraints(cornerConstraints: cornerConstraintForItemImg, centerY: nil, centerX: nil, height: 100, width: 100)

        //descLbl
        let cornerConstraintFordescLbl = ConrnerAnchor(top: (factImage.bottomAnchor, constantPadding), bottom: (borderVw.bottomAnchor, constantPadding), left: (borderVw.leftAnchor, constantPadding), right: (borderVw.rightAnchor, constantPadding))
        descLbl.addConstraints(cornerConstraints: cornerConstraintFordescLbl, centerY: nil, centerX: nil, height: 0, width: 0)
        descLbl.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - BIND DATA
    func bindData(fact: Fact, cache: NSCache<NSString,UIImage>) {
        titleLbl.text = fact.title ?? ""
        descLbl.text = fact.description ?? ""
        if let url = fact.imageHref {
            factImage.image = cache.object(forKey: url as NSString) ?? UIImage(named: "placeholder.png")
        } else {
            factImage.image = UIImage(named: "placeholder.png")
        }
    }
}
