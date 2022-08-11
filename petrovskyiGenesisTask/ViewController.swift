//
//  ViewController.swift
//  petrovskyiGenesisTask
//
//  Created by Mac on 11.08.2022.
//

import UIKit

class ViewController: UIViewController {
    

    private let primaryColor = UIColor(red: 130/255,
                                         green: 69/255,
                                         blue: 152/255,
                                         alpha: 1)
    
    private let secondaryColor = UIColor(red: 21/255,
                                       green: 38/255,
                                       blue: 80/255,
                                       alpha: 1)
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("START", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Setups for view:
    
    private func setupViews() {
        
        // backGround Color is:
        addSomeGradientToLayer(topUIColor: primaryColor,
                                           bottonUIColor: secondaryColor)
        
        // NavigationBar is:
        setupNavigationBar()
        
        // Button added here:
        view.addSubview(startButton)
        setConstrainsforButton()
        
        startButton.addTarget(self,
                              action: #selector(startButtonPressed),
                              for: .touchUpInside)
        
        
    }
    
    // MARK: - setup NavigationBar:
    
    private func setupNavigationBar() {
        
        // Set title for navigation bar
        title = "PETROVSKYI GENESIS"
        
        // Title color
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        // Navigation bar color
        self.navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        
    }
    
// MARK: - CONSTRAINS
    
    private func setConstrainsforButton() {
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
// MARK: - Navigations
    
    @objc private func startButtonPressed() {
        let pageControlVC = PageControlVC()
        navigationController?.pushViewController(pageControlVC, animated: true)
    }
    
}


// MARK: - Extensions

extension ViewController {
    
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

