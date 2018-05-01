//
//  ViewController.swift
//  ProgrammaticConstraints
//
//  Created by Michael Duong on 2/21/18.
//  Copyright © 2018 Turnt Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let topLeftButton = UIButton()
    let topRightButton = UIButton()
    let bottomLeftButton = UIButton()
    let bottomRightButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpButtons()
//        setUpConstraints()
        newConstraints()
    }

    func setUpButtons() {
        topLeftButton.backgroundColor = UIColor.red
        topRightButton.backgroundColor = UIColor.blue
        bottomLeftButton.backgroundColor = UIColor.yellow
        bottomRightButton.backgroundColor = UIColor.green
        
        topLeftButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        topRightButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        bottomLeftButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        bottomRightButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        topLeftButton.addTarget(self, action: #selector(buttonExited(_:)), for: .touchDragExit)
        topRightButton.addTarget(self, action: #selector(buttonExited(_:)), for: .touchDragExit)
        bottomLeftButton.addTarget(self, action: #selector(buttonExited(_:)), for: .touchDragExit)
        bottomRightButton.addTarget(self, action: #selector(buttonExited(_:)), for: .touchDragExit)

        
        view.addSubview(topLeftButton)
        view.addSubview(topRightButton)
        view.addSubview(bottomLeftButton)
        view.addSubview(bottomRightButton)
    }
    
    /*
     This is the "old" way to do constraints
     
    func setUpConstraints() {
        // turn off translatesAutoResizingMaskIntoConstraints
        
        topLeftButton.translatesAutoresizingMaskIntoConstraints = false
        topRightButton.translatesAutoresizingMaskIntoConstraints = false
        bottomLeftButton.translatesAutoresizingMaskIntoConstraints = false
        bottomRightButton.translatesAutoresizingMaskIntoConstraints = false
        
        // set height for top left button
        let height = NSLayoutConstraint(item: topLeftButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.5, constant: 0)
        let width = NSLayoutConstraint(item: topLeftButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.5, constant: 0)
        
        // height and width constraints
        let topRightWidth = NSLayoutConstraint(item: topLeftButton, attribute: .width, relatedBy: .equal, toItem: topRightButton, attribute: .width, multiplier: 1.0, constant: 0)
        let bottomLeftWidth = NSLayoutConstraint(item: topLeftButton, attribute: .width, relatedBy: .equal, toItem: bottomLeftButton, attribute: .width, multiplier: 1.0, constant: 0)
        let bottomRightWidth = NSLayoutConstraint(item: topLeftButton, attribute: .width, relatedBy: .equal, toItem: bottomRightButton, attribute: .width, multiplier: 1.0, constant: 0)
        
        let topRightHeight = NSLayoutConstraint(item: topLeftButton, attribute: .height, relatedBy: .equal, toItem: topRightButton, attribute: .height, multiplier: 1.0, constant: 0)
        let bottomLeftHeight = NSLayoutConstraint(item: topLeftButton, attribute: .height, relatedBy: .equal, toItem: bottomLeftButton, attribute: .height, multiplier: 1.0, constant: 0)
        let bottomRightHeight = NSLayoutConstraint(item: topLeftButton, attribute: .height, relatedBy: .equal, toItem: bottomRightButton, attribute: .height, multiplier: 1.0, constant: 0)
        
        // add height and width constraints to view
        view.addConstraints([height, width, topRightWidth, bottomLeftWidth, bottomRightWidth, topRightHeight, bottomLeftHeight, bottomRightHeight])
        
        // topLeft Constraints
        let topLeftLeadingConstraint = NSLayoutConstraint(item: topLeftButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0)
        
         let topLeftTopConstraint = NSLayoutConstraint(item: topLeftButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0)
        
        // top Contraints
        let topLeftToTopRightConstraint = NSLayoutConstraint(item: topLeftButton, attribute: .right, relatedBy: .equal, toItem: topRightButton, attribute: .left, multiplier: 1.0, constant: 0)
        
        // left Constraints
        let bottomLeftToTopLeftConstraint = NSLayoutConstraint(item: bottomLeftButton, attribute: .top, relatedBy: .equal, toItem: topLeftButton, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        // bottom Constraints
        let bottomRightToBottomLeftXConstraint = NSLayoutConstraint(item: bottomRightButton, attribute: .left, relatedBy: .equal, toItem: bottomLeftButton, attribute: .right, multiplier: 1.0, constant: 0)
        let bottomRightToBottomLeftYConstraint = NSLayoutConstraint(item: bottomRightButton, attribute: .top, relatedBy: .equal, toItem: bottomLeftButton, attribute: .top, multiplier: 1.0, constant: 0)
        
        view.addConstraints([topLeftLeadingConstraint, topLeftTopConstraint, topLeftToTopRightConstraint, bottomLeftToTopLeftConstraint, bottomRightToBottomLeftXConstraint, bottomRightToBottomLeftYConstraint])
        
    }
 */
    
    @objc func buttonTapped() {
        let colors = [UIColor.red, UIColor.blue, UIColor.yellow, UIColor.orange]
        
        UIView.animate(withDuration: 1.0) {
            self.topLeftButton.backgroundColor = colors[Int(arc4random_uniform(UInt32(colors.count)))]
            self.topRightButton.backgroundColor = colors[Int(arc4random_uniform(UInt32(colors.count)))]
            self.bottomLeftButton.backgroundColor = colors[Int(arc4random_uniform(UInt32(colors.count)))]
            self.bottomRightButton.backgroundColor = colors[Int(arc4random_uniform(UInt32(colors.count)))]
            
        }
    }
    
    @objc func buttonExited(_ button: UIButton) {
        view.bringSubview(toFront: button)
        
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [button.frame.origin.x + button.frame.width / 2,
                            button.frame.origin.x + button.frame.width / 2 - 15,
                            button.frame.origin.x + button.frame.width / 2,
                            button.frame.origin.x + button.frame.width / 2 + 15,
                            button.frame.origin.x + button.frame.width / 2]
        
        animation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
        animation.duration = 0.5
        animation.repeatCount = 3
        
        button.layer.add(animation, forKey: "shake")
    }
    
    func newConstraints() {
        
        topLeftButton.anchor(top: view.topAnchor, left: view.leftAnchor, right: nil, bottom: nil, width: view.frame.width/2, height: view.frame.height/2)
        
        topRightButton.anchor(top: view.topAnchor, left: nil, right: view.rightAnchor, bottom: nil, width: view.frame.width/2, height: view.frame.height/2)
        
        bottomLeftButton.anchor(top: nil, left: view.leftAnchor, right: nil, bottom: view.bottomAnchor, width: view.frame.width/2, height: view.frame.height/2)
        
        bottomRightButton.anchor(top: nil, left: nil, right: view.rightAnchor, bottom: view.bottomAnchor, width: view.frame.width/2, height: view.frame.height/2)
    }
    


}

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, width: CGFloat, height: CGFloat) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
    }
}

