//
//  UICollectionView+RegisterCell.swift
//  Swifty
//
//  Created by 王荣庆 on 2020/6/18.
//  Copyright © 2020 RyukieSama. All rights reserved.
//

import UIKit

extension UIBezierPath: SwiftyCompatible {}

@objc
public enum PolygonStartType: Int {
    case Pi
    case HalfPi
    case Zero
}

public extension UIBezierPath {
    
    /// 创建多边形Path
    /// - Parameters:
    ///   - rect: 范围
    ///   - sides: 边数
    ///   - lineWidth: 线宽
    ///   - cornerRadius: 连线处夹角
    ///   - startType: 起点
    convenience init(polygonIn rect: CGRect, sides: Int, lineWidth: CGFloat = 1, cornerRadius: CGFloat = 0, startType: PolygonStartType = .Zero) {
        self.init()

        let theta = 2 * .pi / CGFloat(sides)
        let offset = cornerRadius * tan(theta / 2)
        let squareWidth = min(rect.width, rect.height)


        var length = squareWidth - lineWidth
        if sides % 4 != 0 {
            length = length * cos(theta / 2) + offset / 2
        }
        let sideLength = length * tan(theta / 2)

        var point: CGPoint = .zero
        var angle: CGFloat = 0
        
        switch startType {
        case .Pi:
            point = CGPoint(x: rect.midX + sideLength / 2 - offset, y: rect.midY + length / 2)
            angle = CGFloat.pi
        case .HalfPi:
            point = CGPoint(x: rect.midX - length / 2, y: rect.midY + sideLength / 2 - offset)
            angle = -CGFloat.pi / 2.0
        case .Zero:
            point = CGPoint(x: rect.midX - sideLength / 2 + offset, y: rect.midY - length / 2)
            angle = CGFloat(0)
        }

        move(to: point)

        for _ in 0 ..< sides {
            point = CGPoint(x: point.x + (sideLength - offset * 2) * cos(angle), y: point.y + (sideLength - offset * 2) * sin(angle))
            addLine(to: point)

            let center = CGPoint(x: point.x + cornerRadius * cos(angle + .pi / 2), y: point.y + cornerRadius * sin(angle + .pi / 2))
            addArc(withCenter: center, radius: cornerRadius, startAngle: angle - .pi / 2, endAngle: angle + theta - .pi / 2, clockwise: true)

            point = currentPoint
            angle += theta
        }

        close()

        self.lineWidth = lineWidth
        lineJoinStyle = .round
    }

}


