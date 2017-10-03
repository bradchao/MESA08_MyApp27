//
//  ViewController.swift
//  MyApp27
//
//  Created by user22 on 2017/10/3.
//  Copyright © 2017年 Brad Big Company. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var labelA: UILabel!
    @IBOutlet weak var ballView: UIImageView!
    
    @IBOutlet weak var ball2View: UIImageView!
    @IBOutlet weak var targetView: UIView!
    
    var anim:UIDynamicAnimator!
    
    @IBOutlet weak var greenView: UIView!
    
    @IBOutlet weak var ball3Image: UIImageView!
    
    @IBAction func doSnap(_ sender: Any) {
        
        let snap = UISnapBehavior(item: ball3Image, snapTo: greenView.center)
        snap.damping = 1
        // 2 - 1 引力
        let g = UIGravityBehavior(items: [ball3Image])
        g.gravityDirection = CGVector(dx: 0.0, dy: 3.0)

        anim.addBehavior(snap)
        anim.addBehavior(g)
        
    }
    
    
    @IBAction func pushBall(_ sender: Any) {
        
        // 2 - 1 引力
        let g = UIGravityBehavior(items: [ball2View])
        g.gravityDirection = CGVector(dx: 1.0, dy: 1.0)
        // 2 - 2 碰撞
        let c = UICollisionBehavior(items: [ball2View])
        c.translatesReferenceBoundsIntoBoundary = true
        
        let push = UIPushBehavior(items: [ball2View], mode: .continuous)
        
        push.magnitude = 1.0 // point / s^2
        push.angle = 70.0 / 180.0 * CGFloat(Double.pi)  // 弧度
        push.pushDirection = CGVector(dx: 0.1, dy: 0.7)
        
        anim.addBehavior(push)
        anim.addBehavior(g)
        anim.addBehavior(c)
        
        
    }
    
    
    @IBAction func doTap(_ sender: UITapGestureRecognizer) {
        // 1.
        // 2 - 1 引力
        let g = UIGravityBehavior(items: [ballView])
        g.gravityDirection = CGVector(dx: 1.0, dy: 1.0)
        // 2 - 2 碰撞
        let c = UICollisionBehavior(items: [ballView])
        c.translatesReferenceBoundsIntoBoundary = true
        
        anim.addBehavior(g)
        anim.addBehavior(c)
        
    }
    @IBAction func doPan(_ sender: UIPanGestureRecognizer) {
        let np = sender.location(in: self.view)
        labelA.center = np
        
        let behavior = anim.behaviors.first as! UIAttachmentBehavior
        behavior.anchorPoint = np
        
        targetView.isHidden = false
        
        if sender.state == UIGestureRecognizerState.ended {
            targetView.isHidden = true
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.
        anim = UIDynamicAnimator(referenceView: view)
        // 2. Dynamic Behavior
        let behavior = UIAttachmentBehavior(item: targetView, offsetFromCenter: UIOffsetMake(0, 0), attachedToAnchor: labelA.center)
        
        anim.addBehavior(behavior)
        
        targetView.isHidden = true;
        
        
    }

}

