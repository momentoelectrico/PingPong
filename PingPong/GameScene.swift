//
//  GameScene.swift
//  PingPong
//
//  Created by David Grau Beltrán  on 24/02/24.
//

import SpriteKit
import GameplayKit

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ball = SKSpriteNode()
    var enemyPaddle = SKSpriteNode()
    var playerPaddle = SKSpriteNode()
    
    var topLbl = SKLabelNode()
    var btmLbl = SKLabelNode()
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        
        startGame()
        
        let bshapes = BShapes()
        bshapes.position = CGPoint(x: 0, y: 0)
        addChild(bshapes)
        
        topLbl = self.childNode(withName: "topLbl") as! SKLabelNode
        btmLbl = self.childNode(withName: "btmLbl") as! SKLabelNode
        
        self.physicsWorld.contactDelegate = self
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemyPaddle = self.childNode(withName: "enemyPaddle") as! SKSpriteNode
        playerPaddle = self.childNode(withName: "playerPaddle") as! SKSpriteNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
    }
    
    func startGame() {
        score = [0,0]
        topLbl.text = "\(score[1])"
        btmLbl.text = "\(score[0])"
    }
    
    func checkGameEnd() {
        if score[1] == 5 || score[0] == 5 {
            let gameOverLabel = SKLabelNode(text: "Game Over")
            gameOverLabel.fontName = "Helvetica-Bold" // Change the font name here
            gameOverLabel.fontSize = 50
            gameOverLabel.position = CGPoint(x: 0, y: 0)
            addChild(gameOverLabel)
            
            // Pause the game
            self.isPaused = true
            
            
            // Restart the game after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.isPaused = false
                gameOverLabel.removeFromParent()
                self.startGame()
                self.score[1] = 0
                self.score[0] = 0
                self.resetGame()
                
            }
        }
    }

    func resetGame() {
           ball.position = CGPoint(x: 0, y: 0)
           ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
           ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
           
       }
    
    func addScore(playerWhoWon : SKSpriteNode){
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == playerPaddle{
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        }
        else if playerWhoWon == enemyPaddle{
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
            
        }
        
        topLbl.text = "\(score[1])"
        btmLbl.text = "\(score[0])"
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self) //move acourding touching finger
            
            playerPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
       
       
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self) //move acourding touching finger
            
            playerPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }

        
    }
    
    override func update(_ currentTime: TimeInterval) {
        enemyPaddle.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
        
        if ball.position.y <= playerPaddle.position.y - 70 {
            addScore(playerWhoWon: enemyPaddle)
        }
        else if ball.position.y >= enemyPaddle.position.y + 70 {
            addScore(playerWhoWon: playerPaddle)
            
        }
        
        checkGameEnd()
    }
}
