//
//  BackgroundShapes.swift
//  PingPong
//
//  Created by David Grau Beltrán  on 25/02/24.
//

import SpriteKit

class BShapes: SKNode {
    
    var circle = SKShapeNode()
    let radius: CGFloat = 125
    
    override init() {
        super.init()
        
        circle = SKShapeNode(circleOfRadius: radius)
        circle.lineWidth = 1
        circle.strokeColor = .white
        addChild(circle)
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: -1000, y: 0))
        path.addLine(to: CGPoint(x: 1000, y: 0))
        
        let line = SKShapeNode(path: path)
        line.strokeColor = .white
        line.lineWidth = 1
        
        addChild(line)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
