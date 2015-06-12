//
//  ViewController.swift
//  DeclarativeUI
//
//  Created by Eugene Gubin on 25.03.15.
//  Copyright (c) 2015 SimbirSoft. All rights reserved.
//

import UIKit
import ReactiveCocoa
import MVVMKit

class ViewController: UIViewController, ViewForViewModel {

    var viewModel : SimpleViewModel!
    
    var subviewHook : UILabel!
    var doButton: UIButton!
    
    required init() {
        super.init(nibName: nil, bundle: nil)
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
                    $0.frame = CGRect(x: 5, y: 100, width: 60, height: 30)
                    $0.text = self.viewModel.data
                },
                self.doButton ~> UIButton() => {
                    $0.frame = CGRect(x: 40, y: 100, width: 60, height: 30)
                    $0.setTitle("Do!", forState: UIControlState.Normal)
                }
            ]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
    }
    
    var ca: CocoaAction!
    var d: Disposable?
    func bindToViewModel() {
        self.title = viewModel.data
        
        DynamicProperty(object: self.subviewHook, keyPath: "text") <~ viewModel.value.producer |> map { "\($0)" }
        
        ca = CocoaAction(viewModel.increment)
        doButton.addTarget(ca, action: CocoaAction.selector, forControlEvents: UIControlEvents.TouchUpInside)
        
        viewModel.didBecomeActiveSignal |> start(error: nil, completed: nil, interrupted: nil, next: { x in println("Become active!") })
        
        d = viewModel.forwardSignalWhileActive(timer(NSTimeInterval(1), onScheduler: QueueScheduler())).start(error: nil, completed: nil, interrupted: nil) { date in
            //println("\(date)")
        }
    }
    
    deinit {
        println("deinit")
        viewModel.dispose()
    }
    
    override func viewDidAppear(animated: Bool) {
        viewModel.active.value = true
        println("d \(d?.disposed)")
    }
    
    override func viewDidDisappear(animated: Bool) {
        viewModel.active.value = false
    }
    
    override func didMoveToParentViewController(parent: UIViewController?) {
        println("parentVC: \(parent)")
        super.didMoveToParentViewController(parent)
    }
}