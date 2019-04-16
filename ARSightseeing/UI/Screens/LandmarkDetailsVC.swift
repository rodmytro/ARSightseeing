//
//  LandmarkDetailsVC.swift
//  ARSightseeing
//
//  Created by Dmytro Romaniuk on 7/9/18.
//  Copyright © 2018 rodmytro. All rights reserved.
//

import Foundation
import UIKit
import MIBlurPopup

class LandmarkDetailsVC: UIViewController {
    
    @IBOutlet weak var popup: UIView! {
        didSet {
            popup.layer.cornerRadius = 10
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modalPresentationCapturesStatusBarAppearance = true
    }
}

extension LandmarkDetailsVC: MIBlurPopupDelegate {
    
    var popupView: UIView {
        return popup ?? UIView()
    }
    
    var blurEffectStyle: UIBlurEffectStyle {
        return UIBlurEffectStyle.light
    }
    
    var initialScaleAmmount: CGFloat {
        return 1
    }
    
    var animationDuration: TimeInterval {
        return 0.5
    }
    
}
