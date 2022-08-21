//
//  TimerVC.swift
//  petrovskyiGenesisTask
//
//  Created by Mac on 19.08.2022.
//

import UIKit

final class TimerVC: UIViewController {
    
    //MARK: - HalfScreen Properties:
    
    lazy var backdropView: UIView = {
        let bdView = UIView(frame: self.view.bounds)
        bdView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return bdView
    }()

    let menuView = UIView()
    let menuHeight = UIScreen.main.bounds.height / 2
    var isPresenting = false

    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Timer Properties:
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "UIAlarm is generating..."
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let timerNumbersLabel: UILabel = {
        let label = UILabel()
        label.text = "5" // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 84)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var timer = Timer()
    
    private var durationTimer = 5 // !!!!!!!!!!!!!!!!!!!!!!!!!
    
    //MARK: - Circle progressView

    private let shapeLayer = CAShapeLayer()
//    private let progressView: UIProgressView = {
//        let progressView = UIProgressView(progressViewStyle: .bar)
//        progressView.trackTintColor = .white
//        progressView.progressTintColor = .systemPink
//        return progressView
//    }()
    
    
    //MARK: - ViewDidLoad:

override func viewDidLoad() {
    super.viewDidLoad()
    
    
    view.addSubview(backdropView)
    view.addSubview(menuView)
    menuView.backgroundColor = .black
    menuViewConstrains()
    setConstraintsForTimerParts()
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TimerVC.handleTap(_:)))
    backdropView.addGestureRecognizer(tapGesture)
    
    circularStartsSettings()
    circularProgressView()
    timerStarts()
    }
    
    //MARK: - Timer Settings:
    
    
    @objc private func timerStarts() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        

    }
    
    @objc private func timerAction() {
        durationTimer -= 1
        timerNumbersLabel.text = "\(durationTimer)"
        
        if durationTimer == 0 {
            timer.invalidate()
            dismiss(animated: true)
        }
    }
    
    //MARK: - ProgressView:
    
    private func circularProgressView() {
        
        let center = CGPoint(x: view.safeAreaLayoutGuide.accessibilityFrame.minX + 210, y: view.safeAreaLayoutGuide.accessibilityFrame.minY + 650)
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeColor = UIColor.purple.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 20
        
        shapeLayer.strokeEnd = 0
        
        view.layer.addSublayer(shapeLayer)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(circularStartsSettings)))
        
    }

    
    @objc private func circularStartsSettings() {

        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")

        basicAnimation.toValue = 0.8

        basicAnimation.duration = CFTimeInterval(durationTimer)

        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
    
    
    //MARK: - Constrains:

    private func menuViewConstrains() {
        menuView.translatesAutoresizingMaskIntoConstraints = false
        menuView.heightAnchor.constraint(equalToConstant: menuHeight).isActive = true
        menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func setConstraintsForTimerParts() {
        
        view.addSubview(timerNumbersLabel)
        NSLayoutConstraint.activate([
            timerNumbersLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -200),
            timerNumbersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timerNumbersLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -80),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    //MARK: - Dismiss Method
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - Extensions:

extension TimerVC: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        guard let toVC = toViewController else { return }
        isPresenting = !isPresenting
    
            if isPresenting == true {
                containerView.addSubview(toVC.view)
        
                menuView.frame.origin.y += menuHeight
                backdropView.alpha = 0
        
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
            self.menuView.frame.origin.y -= self.menuHeight
            self.backdropView.alpha = 1
            },
                        completion: { (finished) in
                        transitionContext.completeTransition(true)
                        })
            } else {
            UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
                self.menuView.frame.origin.y += self.menuHeight
                self.backdropView.alpha = 0
                },
                            completion: { (finished) in
                            transitionContext.completeTransition(true)
                            })
            }
        }
}
