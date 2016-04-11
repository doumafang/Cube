//
//  ViewController.swift
//  Cube
//
//  Created by doumaaaaaaaa on 16/4/10.
//  Copyright © 2016 doumafang. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import VideoSplashKit
import SnapKit
import BubbleTransition


class ViewController: VideoSplashViewController ,UIViewControllerTransitioningDelegate{

    let transition = BubbleTransition()
    let showView = NVActivityIndicatorView(frame:CGRectMake(0, 0, 150, 150))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("Splash", ofType: "mp4")!)
        self.videoFrame = view.frame
        self.fillMode = .ResizeAspectFill
        self.alwaysRepeat = true
        self.sound = true
        self.startTime = 35.0
        self.duration = 10.0
        self.alpha = 0.7
        self.backgroundColor = UIColor.blackColor()
        self.contentURL = url
        self.restartForeground = true
        
        let cubeLabel = UILabel()
        if KIfIPhone() {
            cubeLabel.font = UIFont(name: "Museo500-Regular", size: 40)
        }
        else
        {
            cubeLabel.font = UIFont(name: "Museo500-Regular", size: 55)
        }
        
        cubeLabel.textAlignment = NSTextAlignment.Center
        cubeLabel.textColor = UIColor.whiteColor()
        cubeLabel.text = NSLocalizedString("Cube", comment: "Cube")
        
        let shimmerView = FBShimmeringView()
        view.addSubview(shimmerView)
        shimmerView.snp_makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).multipliedBy(0.5)
            make.size.equalTo(view)
        }
        shimmerView.contentView = cubeLabel
        shimmerView.shimmering = true
        shimmerView.shimmeringAnimationOpacity = 0.4
        shimmerView.shimmeringPauseDuration = 0.2
        
        showView.center.x = view.center.x
        showView.center.y = view.center.y * 1.5
        showView.color = UIColor.whiteColor()
        showView.type = NVActivityIndicatorType.BallScaleRippleMultiple
        view.addSubview(showView)
        showView.startAnimation()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.gestureTap(_:)))
        showView.addGestureRecognizer(tap)
        
    }
    
    
    func gestureTap(gestureRecognizer: UIGestureRecognizer){
        
        if KIfIPhone() {
            let viewController = PublishViewController()
            viewController.transitioningDelegate = self
            viewController.modalPresentationStyle = .Custom
            self.presentViewController(viewController, animated: true, completion: nil)

        }
        else
        {
            let viewController = ClientViewController()
            viewController.transitioningDelegate = self
            viewController.modalPresentationStyle = .Custom
            self.presentViewController(viewController, animated: true, completion: nil)
        }
    }
    // MARK: UIViewControllerTransitioningDelegate
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Present
        transition.startingPoint = showView.center
//        transition.bubbleColor = showView.backgroundColor!
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Dismiss
        transition.startingPoint = showView.center
//        transition.bubbleColor = showView.backgroundColor!
        return transition
    }

    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

