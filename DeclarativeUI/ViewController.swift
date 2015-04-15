//
//  ViewController.swift
//  DeclarativeUI
//
//  Created by Eugene Gubin on 25.03.15.
//  Copyright (c) 2015 SimbirSoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ViewForViewModel {

    let viewModel : SimpleViewModel!
    
    var subviewHook : UILabel!
    
    required init(viewModel: SimpleViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = viewModel.data
    }

    required init(coder aDecoder: NSCoder) {
        viewModel = nil
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        view = UIView() => {
            $0.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            $0.backgroundColor = UIColor.redColor()
            
            $0 => [
                self.subviewHook ~> UILabel() => {
                    $0.backgroundColor = UIColor.greenColor()
                    $0.frame = CGRect(x: 5, y: 5, width: 60, height: 30)
                    $0.text = self.viewModel.data
                }
            ]
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        router.navigate(self.viewModel, id: "next", viewModel: SimpleViewModel(s: "empty"))
    }
    
    func bindToViewModel() {
        
    }
}

