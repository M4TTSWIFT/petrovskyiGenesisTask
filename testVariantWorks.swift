////
////  PageControlVC.swift
////  petrovskyiGenesisTask
////
////  Created by Mac on 11.08.2022.
////
//
//import UIKit
//
//struct CustomData {
//    var title: String
//    var comment: String
//    var image: UIImage
//}
//
//class PageControlVC: UIViewController {
//    
//    let data = [
//        CustomData(title: "Home kit", comment: "White shirt and dark blue shorts", image: #imageLiteral(resourceName: "0")),
//        CustomData(title: "Away kit", comment: "Blue shirt with dark shoulders and black shorts", image: #imageLiteral(resourceName: "1")),
//        CustomData(title: "Thind kit", comment: "Aqua blue set of shirts and shorts", image: #imageLiteral(resourceName: "2"))
//    ]
//    
//    private let primaryColor = UIColor(red: 21/255,
//                                       green: 38/255,
//                                       blue: 80/255,
//                                       alpha: 1)
//    
//    private let secondaryColor = UIColor(red: 130/255,
//                                         green: 69/255,
//                                         blue: 152/255,
//                                         alpha: 1)
//    
//    fileprivate let collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.translatesAutoresizingMaskIntoConstraints = false
//        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
//        return cv
//    }()
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        addSomeGradientToLayer(topUIColor: primaryColor, bottonUIColor: secondaryColor)
//        navigationController?.navigationBar.backgroundColor = .black
//        
//        view.addSubview(collectionView)
//        
//        
//        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        collectionView.heightAnchor.constraint(equalToConstant: 500).isActive = true
//        collectionView.widthAnchor.constraint(equalToConstant: 500).isActive = true
//        
//        collectionView.delegate = self
//        collectionView.dataSource = self
//
//    }
//    
//}
//
//extension PageControlVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width / 1.3, height: collectionView.frame.height / 1.3)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return data.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
//        cell.data = self.data[indexPath.row]
//        return cell
//    }
//
//    
//
//}
//
//class CustomCell: UICollectionViewCell {
//    
//    var data: CustomData? {
//        didSet {
//            guard let data = data else { return }
//            bg.image = data.image
//        }
//    }
//    
//    fileprivate let bg: UIImageView = {
//       let iv = UIImageView()
//        iv.image = #imageLiteral(resourceName: "0")
//        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.contentMode = .scaleAspectFit // RASTAJKA
//        iv.clipsToBounds = true
//        return iv
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        contentView.addSubview(bg)
//        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        bg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        bg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
