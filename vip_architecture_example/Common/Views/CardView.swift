//
//  CardView.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 27/06/22.
//

import UIKit

@IBDesignable public class CardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 5{
        didSet{
            redraw()
        }
    }
    @IBInspectable var shadowOffsetWidth: CGFloat = 0{
        didSet{
            redraw()
        }
    }
    @IBInspectable var shadowOffsetHeight: CGFloat = 0{
        didSet{
            redraw()
        }
    }
    @IBInspectable public var shadowDepth: CGFloat = 0{
        didSet{
            redraw()
        }
    }
    @IBInspectable var shadowColor: UIColor = .black{
        didSet{
            redraw()
        }
    }
    @IBInspectable var shadowOpacity: Int = 50{
        didSet{
            redraw()
        }
    }
    @IBInspectable var isRounded: Bool = false{
        didSet{
            redraw()
        }
    }
    @IBInspectable public var borderWidth: CGFloat = 0.0{
        didSet{
            redraw()
        }
    }
    @IBInspectable public var borderColor: UIColor = UIColor.clear{
        didSet{
            redraw()
        }
    }
    
    
    func redraw(){
        setNeedsLayout()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        let cRadius = isRounded ? frame.height/2 : cornerRadius
        layer.cornerRadius = cRadius
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = Float(shadowOpacity) / 100.0
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        
        let shadowContainer = CGRect(x: bounds.minX - shadowDepth, y: bounds.minY - shadowDepth, width: bounds.width + 2*shadowDepth, height: bounds.height + 2*shadowDepth)
        let shadowPath = UIBezierPath(roundedRect: shadowContainer, cornerRadius: cRadius)
        layer.shadowPath = shadowPath.cgPath
        
    }

}

