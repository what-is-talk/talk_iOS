//
//  CALayer.swift
//  talk_iOS
//
//  Created by 경유진 on 2023/01/23.
//
import Foundation
import UIKit

extension CALayer {
    func drawLineAt(edges:[UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in edges {
            let border = CALayer()
            
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(
                    x: 0,
                    y: 0,
                    width: bounds.width,
                    height: width
                )
            case UIRectEdge.bottom:
                border.frame = CGRect.init(
                    x: 0,
                    y: frame.height-width,
                    width: bounds.width,
                    height: width
                )
            case UIRectEdge.left:
                border.frame = CGRect.init(
                    x: 0,
                    y: 0,
                    width: width,
                    height: bounds.height
                )
            case UIRectEdge.right:
                border.frame = CGRect.init(
                    x: frame.width-width,
                    y: 0,
                    width: width,
                    height: bounds.height
                )
            default:
                break
            }
            
            border.backgroundColor = color.cgColor
            self.addSublayer(border)
        }
    }
}
