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
    
    let rateView = EmojiRateView.init(frame: CGRectMake(0, 0, 150, 150))

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.getSmileInfo), name: "IAMSMILE", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.getNoSmileInfo(_:)), name: "NOSMILE", object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "IAMSMILE", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "NOSMILE", object: nil)
    }

    override func viewDidLoad(){
        
        super.viewDidLoad()
        
        let cubeLabel = UILabel()
        cubeLabel.font = UIFont(name: "Museo500-Regular", size: 30)
        cubeLabel.textAlignment = NSTextAlignment.Center
        cubeLabel.textColor = UIColor.blackColor()
        cubeLabel.text = NSLocalizedString("Hello,I'm Cube", comment: "Cube")

        let shimmerView = FBShimmeringView()
        view.addSubview(shimmerView)
        shimmerView.snp_makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).multipliedBy(0.2)
            make.size.equalTo(view)
        }
        shimmerView.contentView = cubeLabel
        shimmerView.shimmering = true
        shimmerView.shimmeringAnimationOpacity = 0.4
        shimmerView.shimmeringPauseDuration = 0.2
        
        
        let closeView = UIImageView(image:UIImage(named: "closeB"))
        closeView.userInteractionEnabled = true
        view.addSubview(closeView)
        closeView.snp_makeConstraints { (make) in
            make.right.equalTo(view).offset(-10)
            make.top.equalTo(view).offset(10)
            make.size.equalTo(CGSizeMake(30, 30))
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.gestureTap(_:)))
        closeView.addGestureRecognizer(tap)
        
        self.view.addSubview(rateView)
        rateView.center.x = view.center.x
        rateView.center.y = view.center.y * 0.6

        let liveViewController = PlayerViewController()
        view.addSubview(liveViewController.view)
        liveViewController.rtmpURL = kRTMPURL
        liveViewController.view.snp_makeConstraints { (make) in
            make.right.left.bottom.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.5)
        }
        
        let showView = NVActivityIndicatorView(frame:CGRectMake(0, 0, 80, 80))
        showView.color = UIColor.whiteColor()
        showView.type = NVActivityIndicatorType.LineScalePulseOut
        view.addSubview(showView)
        showView.snp_makeConstraints { (make) in
            make.right.equalTo(view).offset(10)
            make.top.equalTo(liveViewController.view).offset(-10)
            make.size.equalTo(CGSizeMake(80, 80))
        }
        showView.startAnimation()
        
    }
    
    func getSmileInfo(){
        dispatch_async(dispatch_get_main_queue(), {
            self.rateView.rateValue = 5
        })
        print("SMILE")
    }
    
    func getNoSmileInfo(sender:NSNotification){
        print("NO-SMILE")
        dispatch_async(dispatch_get_main_queue(), {
            self.rateView.rateValue = 0
        })

    }

    func gestureTap(gestureRecognizer: UIGestureRecognizer){
        self.dismissViewControllerAnimated(true, completion:{
            LiveVideoCoreSDK.sharedinstance().LiveRelease()
        })
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
 
}
