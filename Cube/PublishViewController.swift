//
//  PublishViewController.swift
//  Cube
//
//  Created by doumaaaaaaaa on 16/4/10.
//  Copyright © 2016 doumafang. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import VideoSplashKit
import SnapKit
import TTGEmojiRate
import BubbleTransition

class PublishViewController: UIViewController {
    
    override func viewDidLoad(){
        
        
        let cubeLabel = UILabel()
        cubeLabel.font = UIFont(name: "Museo500-Regular", size: 30)
        cubeLabel.textAlignment = NSTextAlignment.Center
        cubeLabel.textColor = UIColor.blackColor()
        cubeLabel.text = NSLocalizedString("Hello,I'm Cube", comment: "Cube")

        let shimmerView = FBShimmeringView()
        view.addSubview(shimmerView)
        shimmerView.snp_makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).multipliedBy(0.3)
            make.size.equalTo(view)
        }
        shimmerView.contentView = cubeLabel
        shimmerView.shimmering = true
        shimmerView.shimmeringAnimationOpacity = 0.4
        shimmerView.shimmeringPauseDuration = 0.2
        
        
        let backView = NVActivityIndicatorView(frame:CGRectMake(0, 0, 90, 90))
        backView.color = UIColor.blackColor()
        backView.type = NVActivityIndicatorType.SemiCircleSpin
        view.addSubview(backView)
        backView.startAnimation()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.gestureTap(_:)))
        backView.addGestureRecognizer(tap)
        
        
//        let showView = NVActivityIndicatorView(frame:CGRectMake(0, 0, 150, 150))
//        showView.center.x = view.center.x
//        showView.center.y = view.center.y * 0.6
//        showView.color = UIColor.blackColor()
//        showView.type = NVActivityIndicatorType.LineScalePulseOutRapid
//        view.addSubview(showView)
//        showView.startAnimation()
        
        
//        let rateView = EmojiRateView.init(frame: CGRectMake(0, 0, 100, 100) )
//        view.addSubview(rateView)
//        rateView.snp_makeConstraints { (make) in
//            make.centerY.equalTo(view.center.y * 0.6)
//            make.centerX.equalTo(view)
//            make.size.equalTo(CGSizeMake(100, 100))
//        }
        
        
        let rateView = EmojiRateView.init(frame: CGRectMake(0, 0, 150, 150))
        self.view.addSubview(rateView)
        rateView.center.x = view.center.x
        rateView.center.y = view.center.y * 0.7

        let liveViewController = PlayerViewController()
        view.addSubview(liveViewController.view)
        liveViewController.rtmpURL = kRTMPURL
        liveViewController.view.snp_makeConstraints { (make) in
            make.right.left.bottom.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.5)
        }


        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    func gestureTap(gestureRecognizer: UIGestureRecognizer){
        self.dismissViewControllerAnimated(true, completion:{
            
            LiveVideoCoreSDK.sharedinstance().LiveRelease()
            LiveVideoCoreSDK.sharedinstance().disconnect()
  
            })

    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
 
}
