//
//  ClientViewController.swift
//  Cube
//
//  Created by doumaaaaaaaa on 16/4/10.
//  Copyright © 2016 doumafang. All rights reserved.
//

import UIKit
import IJKMediaFramework
import NVActivityIndicatorView
import TTGEmojiRate
import SnapKit


class ClientViewController: UIViewController {
    override func viewDidLoad(){
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        let bb = BlueTooth()
        bb.openBB()

        IJKFFMoviePlayerController.checkIfFFmpegVersionMatch(true)
        let player = IJKFFMoviePlayerController(contentURL: kRTMPURL, withOptions: IJKFFOptions.optionsByDefault())
        player.scalingMode = IJKMPMovieScalingMode.AspectFit
        player.shouldAutoplay = true
        player.view.frame = CGRectMake(0, 0, kSCREEN_HEIGHT*10/16, kSCREEN_HEIGHT)
        player.view.backgroundColor = UIColor.blackColor()
        view.addSubview(player.view)
        player.prepareToPlay()
        player.play()

        let starView = StarsOverlay()
        starView.frame = CGRectMake(0, 0, kSCREEN_HEIGHT*10/16, kSCREEN_HEIGHT)
        view.addSubview(starView)
        
        let starbutton = ProfileButton()
        starbutton.backgroundColor = UIColor.whiteColor()
        starbutton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        starbutton.titleLabel?.font = UIFont(name: "Museo500-Regular", size: 30)
        starbutton.setTitle("Start", forState: UIControlState.Normal)
        view.addSubview(starbutton)
        starbutton.layer.borderWidth = 2
        starbutton.layer.masksToBounds = true
        starbutton.layer.cornerRadius = 40
        starbutton.layer.borderColor = UIColor.blackColor().CGColor
        starbutton.snp_makeConstraints { (make) in
            make.center.equalTo(player.view)
        }
        
//        let showView = NVActivityIndicatorView(frame:CGRectMake(0, 0, 120, 120))
//        showView.center = CGPointMake(kSCREEN_HEIGHT*5/16, kSCREEN_HEIGHT/2)
//        showView.color = UIColor.whiteColor()
//        showView.type = NVActivityIndicatorType.BallSpinFadeLoader
//        view.addSubview(showView)
//        showView.startAnimation()
    
        let closeView = UIImageView(image:UIImage(named: "closeB"))
        closeView.userInteractionEnabled = true
        view.addSubview(closeView)
        closeView.snp_makeConstraints { (make) in
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(view).offset(20)
            make.size.equalTo(CGSizeMake(40, 40))
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.gestureTap(_:)))
        closeView.addGestureRecognizer(tap)
    
        let iphoneImage = UIImageView(image: UIImage(named:"iphone"))
        iphoneImage.center = CGPointMake((kSCREEN_HEIGHT * 5/8 + kSCREEN_WIDTH)/2 , (kSCREEN_HEIGHT * 5/8 + kSCREEN_WIDTH)/2 - kSCREEN_HEIGHT * 6/8)
        iphoneImage.bounds.size = CGSizeMake(100, 100)
        iphoneImage.contentMode = UIViewContentMode.ScaleAspectFit
        view.addSubview(iphoneImage)
        
        let iphoneView = NVActivityIndicatorView(frame:CGRectMake(0, 0, 300, 300))
        iphoneView.center = iphoneImage.center
        iphoneView.color = UIColor.blackColor()
        iphoneView.type = NVActivityIndicatorType.BallScaleRippleMultiple
        view.addSubview(iphoneView)
        iphoneView.startAnimation()
        
        let array = ["F","L","B","R"];
        for i in 0  ..< array.count
        {
            let button = ProfileButton()
            button.backgroundColor = UIColor.whiteColor()
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button.titleLabel?.font = UIFont(name: "Museo500-Regular", size: 30)
            button.setTitle(array[i], forState: UIControlState.Normal)
            view.addSubview(button)
            button.layer.borderWidth = 2
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 40
            button.layer.borderColor = UIColor.blackColor().CGColor
            button.snp_makeConstraints { (make) in
                if i == 0
                {
                    make.centerX.equalTo(iphoneImage)
                    make.bottom.equalTo(view).offset(-140)
                }
                else{
                    make.centerX.equalTo(iphoneImage).offset((i-2)*120)
                    make.bottom.equalTo(view).offset(-20)
                }
                    make.size.equalTo(CGSizeMake(100, 100))
            }
            button.addTarget(self, action:#selector(self.setupYourProfileTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    
    
    func setupYourProfileTapped(sender: ProfileButton) {
        sender.animateTouchUpInside {
            
        }
    }

    
    func gestureTap(gestureRecognizer: UIGestureRecognizer){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
