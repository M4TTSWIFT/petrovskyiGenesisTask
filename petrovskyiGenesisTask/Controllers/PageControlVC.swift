//
//  PageControlVC.swift
//  petrovskyiGenesisTask
//
//  Created by Mac on 11.08.2022.
//

import UIKit

class PageControlVC: UIViewController {
    
    //MARK: - Properties:
    
    let data = [
        CustomData(title: "Home kit",
                   comment: "White shirt and dark blue shorts",
                   image: #imageLiteral(resourceName: "0")),
        CustomData(title: "Away kit",
                   comment: "Blue shirt with dark shoulders and black shorts",
                   image: #imageLiteral(resourceName: "1")),
        CustomData(title: "Thind kit",
                   comment: "Aqua blue set of shirts and shorts",
                   image: #imageLiteral(resourceName: "2"))
    ]
    
    private let primaryColor = UIColor(red: 21/255,
                                       green: 38/255,
                                       blue: 80/255,
                                       alpha: 1)
    
    private let secondaryColor = UIColor(red: 130/255,
                                         green: 69/255,
                                         blue: 152/255,
                                         alpha: 1)
    
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]

    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    fileprivate let continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate var kitsLabel = UILabel()
    
    fileprivate var pageControl = UIPageControl()
    
    private var currentPage = 0
    
    //MARK: - ViewDidLoad:

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        addSomeGradientToLayer(topUIColor: primaryColor, bottonUIColor: secondaryColor)
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        view.addSubview(collectionView)
        setupCollectionView()
        
        
        view.addSubview(kitsLabel)
        setupKitsLabel()
        
        view.addSubview(continueButton)
        continueButton.addTarget(self,
                                 action: #selector(continueButtonPressed),
                                 for: .touchUpInside)
        
        view.addSubview(pageControl)
        initPageControl()
        setConstraints()

    }
    
    //MARK: - Private Methods:
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    private func setupKitsLabel() {
        kitsLabel.numberOfLines = 1
        kitsLabel.contentMode = .center
        kitsLabel.textAlignment = .center
        kitsLabel.textColor = UIColor.white
        kitsLabel.backgroundColor = .clear
        kitsLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func initPageControl() {
        pageControl.numberOfPages = data.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.purple
        pageControl.pageIndicatorTintColor = UIColor.black
        pageControl.currentPageIndicatorTintColor = UIColor.cyan
        pageControl.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func continueButtonPressed() {
        let collectionBounds = self.collectionView.bounds
        let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x + collectionBounds.size.width))
        self.moveCollectionToFrame(contentOffset: contentOffset)
        
        if contentOffset >= 1350.0 && UserData.shared.isFirstRun == true  {
            continueButtonSegue()
            UserDefaults.standard.set(false, forKey: "isFirstRun")
            
        } else if UserData.shared.isFirstRun == false && continueButton.title(for: .normal) == "CONTINUE" {
                showAlert(title: "The next view",
                          message: "Has been already opened once")
            }
        }
        
    func moveCollectionToFrame(contentOffset : CGFloat) {
            let frame: CGRect = CGRect(x: contentOffset,
                                       y: self.collectionView.contentOffset.y,
                                       width: self.collectionView.frame.width,
                                       height: self.collectionView.frame.height)
        
            self.collectionView.scrollRectToVisible(frame, animated: true)
        }
    
    //MARK: - Constraints:
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            kitsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            kitsLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 450),
            collectionView.widthAnchor.constraint(equalToConstant: 450),
            
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.centerYAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 50),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            continueButton.widthAnchor.constraint(equalToConstant: 150),
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.centerYAnchor.constraint(equalTo: continueButton.topAnchor, constant: -10),
            pageControl.heightAnchor.constraint(equalToConstant: 50),
            pageControl.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}

//MARK: - Extensions

extension PageControlVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.data = data[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    // pageControl statement:
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let indexPage = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
        currentPage = indexPage
        pageControl.currentPage = indexPage
        navigationItem.title = data[indexPage].title
        kitsLabel.text = data[indexPage].comment
        if indexPage == 2 {
                continueButton.setTitle("CONTINUE", for: .normal)
        } else if indexPage != 2 {
            continueButton.setTitle("NEXT", for: .normal)
        }
      }
    
    //MARK: - Navigation:
    
    @objc private func continueButtonSegue() {
        let vc = TimerVC()
            vc.modalPresentationStyle = .custom
            present(vc, animated: true, completion: nil)
    }
    
    //MARK: - setAlarm:
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(
                        title: title,
                        message: message,
                        preferredStyle: .alert)
        
        let okeyAction = UIAlertAction(title: "OK", style: .default)
            
    alert.addAction(okeyAction)
    present(alert, animated: true)
    }
}
