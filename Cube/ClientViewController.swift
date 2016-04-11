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
        
        IJKFFMoviePlayerController.checkIfFFmpegVersionMatch(true)
        let player = IJKFFMoviePlayerController(contentURL: kRTMPURL, withOptions: IJKFFOptions.optionsByDefault())
        player.scalingMode = IJKMPMovieScalingMode.AspectFit
        player.shouldAutoplay = true
        player.view.frame = CGRectMake(0, 0, kSCREEN_HEIGHT*10/16, kSCREEN_HEIGHT)
        player.view.backgroundColor = UIColor.blackColor()
        view.addSubview(player.view)
        player.prepareToPlay()
        player.play()
        
        let showView = NVActivityIndicatorView(frame:CGRectMake(0, 0, 100, 100))
        showView.color = UIColor.whiteColor()
        showView.type = NVActivityIndicatorType.BallClipRotateMultiple
        view.addSubview(showView)
        showView.startAnimation()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.gestureTap(_:)))
        showView.addGestureRecognizer(tap)
    
        
        let bb = BlueTooth()
        bb.test()
    }
    
    
    
    
    
    
    func gestureTap(gestureRecognizer: UIGestureRecognizer){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
