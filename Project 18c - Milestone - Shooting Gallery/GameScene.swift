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
    var score = 0
  
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "wood-background")
        background.zPosition = -1
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.size = CGSize(width: 1024, height: 768)
        addChild(background)
        
        for i in 0...5 { createTarget(at: CGPoint(x: 100 + (i * 170), y: 210)) }
        for i in 0...5 { createTarget(at: CGPoint(x: 100 + (i * 170), y: 410)) }
        for i in 0...5 { createTarget(at: CGPoint(x: 100 + (i * 170), y: 610)) }

    }
    
    //MARK: - Private Methods
    
    func createTarget(at position: CGPoint) {
        guard let target = possibleTargets.randomElement() else { return }
        let sprite = SKSpriteNode(imageNamed: target)
        
        let scaleSize = Int.random(in: 30...170)
        sprite.scale(to: CGSize(width: scaleSize, height: scaleSize))
        sprite.position = position
        
        sprite.name = target
        
        addChild(sprite)
    }
    
    
    
    func moveTarget() {
//        guard let target = possibleTargets.randomElement() else { return }
        

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
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
