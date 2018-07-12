//
//  tool.swift
//  EmPrototype
//
//  Created by alan on 2018/6/29.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

extension CALayer{
    func addBorder(edge:UIRectEdge, color:UIColor, thickness:CGFloat){
        
        let borders = CALayer()
        
        switch edge {
        case .top:
            borders.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness);
            break
        case .bottom:
            borders.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness);
        case .left:
            borders.frame = CGRect(x: 0, y: 0 + thickness, width: thickness, height: frame.height - thickness * 2);
        case .right:
            borders.frame = CGRect(x: frame.width - thickness, y: 0 + thickness, width: thickness, height: frame.height - thickness * 2);
        default:
            break
        }
        
        borders.backgroundColor = color.cgColor;
        
        self.addSublayer(borders);
    }
}

//UITextField Placeholder 置中
extension String {
    func attributedString(aligment: NSTextAlignment) -> NSAttributedString {
        return NSAttributedString(text: self, aligment: aligment)
    }
}

extension NSAttributedString {
    convenience init(text: String, aligment: NSTextAlignment) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = aligment
        self.init(string: text, attributes: [NSAttributedStringKey.paragraphStyle: paragraphStyle])
    }
}
extension String {
    
    //将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    //将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
}


//抖動方向
public enum ShakeDirection: Int {
    case horizontal  //水平抖
    case vertical  //垂直抖
}

extension UIView {
    /**
     擴展UIView增加抖動方法
     
     @param direction：抖動方向（默認是水平方向）
     @param times：抖動次數（默認5次）
     @param interval：每次抖動時間（默認0.1秒）
     @param delta：抖動偏移量（默認2）
     @param completion：抖動動畫结束後的回調
     */
    public func shake(direction: ShakeDirection = .horizontal, times: Int = 5,
                      interval: TimeInterval = 0.1, delta: CGFloat = 10,
                      completion: (() -> Void)? = nil) {
        //播放動畫
        UIView.animate(withDuration: interval, animations: { () -> Void in
            switch direction {
            case .horizontal:
                self.layer.setAffineTransform( CGAffineTransform(translationX: delta, y: 0))
                break
            case .vertical:
                self.layer.setAffineTransform( CGAffineTransform(translationX: 0, y: delta))
                break
            }
        }) { (complete) -> Void in
            //如果當前是最後一次抖動，則將位置還原，並調用完成回調函數
            if (times == 0) {
                UIView.animate(withDuration: interval, animations: { () -> Void in
                    self.layer.setAffineTransform(CGAffineTransform.identity)
                }, completion: { (complete) -> Void in
                    completion?()
                })
            }
                //如果當前不是最後一次抖動，則繼續播放動畫（總次數减1，偏移位置變成相反的）
            else {
                self.shake(direction: direction, times: times - 1,  interval: interval,
                           delta: delta * -1, completion:completion)
            }
        }
    }
}
