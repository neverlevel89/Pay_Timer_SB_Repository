//
//  Animation.swift
//  Pay_Timer_SB
//
//  Created by Federico Pastormerlo on 26/05/2020.
//  Copyright © 2020 Federico Pastormerlo. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    /// Helper function to update view's alpha with animation
    /// - Parameter alpha: View's alpha
    /// - Parameter animate: Indicate alpha changing with animation or not
    /// - Parameter duration: Indicate time for animation
    /// - Parameter completion: Completion block after alpha changing is finished
    func set(alpha: CGFloat, animate: Bool, duration: TimeInterval = 0.3, completion: ((Bool) -> Void)? = nil) {
        let animation = { (view: UIView) in
            view.alpha = alpha
        }

        if animate {
            UIView.animate(withDuration: duration, animations: {
                animation(self)
            }, completion: { finished in
                completion?(finished)
            })
        } else {
            layer.removeAllAnimations()
            animation(self)
            completion?(true)
        }
    }
}


