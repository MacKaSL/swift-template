//
//  LoadingView.swift
//
//  Created by Himal Madhushan.
//  Copyright © Himal Madhushan. All rights reserved.
//

import Foundation
import UIKit

class LoadingView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(white: 1, alpha: 0.9)
        self.frame = Helper.rootViewController().view.frame
        
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        spinner.color = AppColor.red
        spinner.center = center
        addSubview(spinner)
        spinner.startAnimating()
        self.alpha = 0
        
        Helper.rootViewController().view.addSubview(self)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
        }) { (done) in
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func hide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { (done) in
            self.removeFromSuperview()
        }
    }
}
