//
//  Extension + UIViewController.swift
//  petrovskyiGenesisTask
//
//  Created by Mac on 11.08.2022.
//

import UIKit

extension UIViewController {
        
        func addSomeGradientToLayer(topUIColor: UIColor, bottonUIColor: UIColor) {
            let gradient = CAGradientLayer()
            gradient.frame = view.bounds
            gradient.colors = [topUIColor.cgColor, bottonUIColor.cgColor]
            gradient.locations = [0.0, 1.0]
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 0, y: 1)
            view.layer.insertSublayer(gradient, at: 0)
        }    
}
