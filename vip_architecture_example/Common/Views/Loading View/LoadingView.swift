//
//  LoadingView.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 27/06/22.
//

import UIKit
import Lottie

class LoadingView: UIView, XibSubscribable {
    
    @IBOutlet weak var animationView: AnimationView!
    weak var parentView: UIView?
    private var observerSet = false
    private var restoreLoading = false
    private var setToRemove = false
    private var viewActive = true
    private var isPlaying = false{
        didSet{
            if isPlaying { animationView.play() }
            else { animationView.stop() }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.zPosition = 100
        animationView.loopMode = .loop
        
        if !observerSet{
            observerSet = true
            NotificationCenter.default.addObserver(self, selector: #selector(stopWhenAppNotActive), name: UIApplication.didEnterBackgroundNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(restoreSpinnerIfNeeded), name: UIApplication.willEnterForegroundNotification, object: nil)
        }
        
    }
    
    var isLoading: Bool{
        animationView.isAnimationPlaying
    }
    
    @objc private func stopWhenAppNotActive(){
        viewActive = false
        if isPlaying{
            restoreLoading = true
            isPlaying = false
        }
    }
    
    @objc private func restoreSpinnerIfNeeded(){
        viewActive = true
        if setToRemove{
            stop()
            return
        }

        if restoreLoading{
            restoreLoading = false
            isPlaying = true
        }
    }
    
    func play(){
        guard let parentView = parentView else {
            return
        }

        parentView.addSubview(self)
        isPlaying = true
    }
    
    func stop(){
        if !viewActive{
            setToRemove = true
            return
        }

        isPlaying = false
        removeFromSuperview()
   
    }
    
    @discardableResult
    static func loadView(into controller: UIViewController, autoPlay: Bool = true) -> LoadingView?{
        
        var parentController: UIViewController? = controller
        while true{
            if let c = parentController?.parent{
                parentController = c
            }else{
                break
            }
        }
        
        guard let parentView = parentController?.view else{
            return nil
        }

        return loadView(into: parentView, autoPlay: autoPlay)
    }
    
    @discardableResult
    static func loadView(into parentView: UIView, autoPlay: Bool = true) -> LoadingView?{
        guard let spinnerView = loadView() else{
            return nil
        }

        spinnerView.parentView = parentView
        spinnerView.frame = parentView.bounds
        spinnerView.layer.zPosition = 100
        
        spinnerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        if autoPlay{
            spinnerView.play()
        }
        
        return spinnerView
    }
}

