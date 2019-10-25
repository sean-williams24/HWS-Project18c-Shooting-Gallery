//
//  GameScene.swift
//  Project 18c - Milestone - Shooting Gallery
//
//  Created by Sean Williams on 25/10/2019.
//  Copyright © 2019 Sean Williams. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var possibleTargets = ["target0", "target1", "target2", "target3"]
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var allTargets: [SKNode] = []
    var timer: Timer?
    var gameTimer: Timer?
    var timeLeft = 20 {
        didSet {
            timeLeftLabel.text = "Time: \(timeLeft)"
        }
    }
    var timeLeftLabel: SKLabelNode!
    
    
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "wood-background")
        background.zPosition = -1
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.size = CGSize(width: 1024, height: 768)
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.position = CGPoint(x: 10, y: 10)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        
        timeLeftLabel = SKLabelNode(fontNamed: "Chalkduster")
        timeLeftLabel.text = "Time: 60"
        timeLeftLabel.position = CGPoint(x: 900, y: 10)
        addChild(timeLeftLabel)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(createRowsOfTargets), userInfo: nil, repeats: true)
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
    }
    
    //MARK: - Private Methods
    
    @objc func countdown() {
        timeLeft -= 1
    }
    
    @objc func createRowsOfTargets() {
        let xPos1 = Int.random(in: 780...1000)
        let xPos2 = Int.random(in: 780...1000)
        let xPos3 = Int.random(in: 780...1000)
        
        createTarget(at: CGPoint(x: xPos1, y: 210))
        createTarget(at: CGPoint(x: xPos2, y: 410))
        createTarget(at: CGPoint(x: xPos3, y: 610))
    }
    
    
    func createTarget(at position: CGPoint) {
        guard let target = possibleTargets.randomElement() else { return }
        let sprite = SKSpriteNode(imageNamed: target)
        
        let scaleSize = Int.random(in: 30...170)
        sprite.scale(to: CGSize(width: scaleSize, height: scaleSize))
        sprite.position = position
        
        sprite.name = target
        sprite.run(SKAction.moveBy(x: -1000, y: 0, duration: 5))
        
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.categoryBitMask = 1
        sprite.physicsBody?.velocity = CGVector(dx: -100, dy: 0)
        sprite.physicsBody?.linearDamping = 0
        
        
        allTargets.append(sprite)
        
        addChild(sprite)
    }
    
    
    
    
    //MARK: - Touch Methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappedNodes = nodes(at: location)
        
        for target in tappedNodes {
            
            if target.name == "target0" {
                score -= 40
                
            } else if target.name == "target1" {
                targetHit(target: target)
                
            } else if target.name == "target2" {
                targetHit(target: target)
                
            } else if target.name == "target3" {
                targetHit(target: target)
                
            }
        }
        
        print(score)
    }
    
    
    func targetHit(target: SKNode) {
        target.removeFromParent()
        
        if target.frame.height < 80 {
            score += 30
        } else if target.frame.height >= 80 && target.frame.height < 140 {
            score += 20
        } else {
            score += 10
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        for node in children {
            if node.position.x < -100 {
                node.removeFromParent()
            }
        }
        
        if timeLeft == 0 {
            timer?.invalidate()
            gameTimer?.invalidate()
            
            let gameOver = SKSpriteNode(imageNamed: "game-over")
            gameOver.position = CGPoint(x: 512, y: 384)
            gameOver.zPosition = 1
            addChild(gameOver)
            
            let finalScore = SKLabelNode(fontNamed: "Chalkduster")
            finalScore.text = "Final Score: \(score)"
            finalScore.position = CGPoint(x: 512, y: 280)
            finalScore.horizontalAlignmentMode = .center
            finalScore.zPosition = 1
            addChild(finalScore)
        }
    }
}
