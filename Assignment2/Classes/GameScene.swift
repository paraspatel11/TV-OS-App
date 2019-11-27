//
//  GameScene.swift
//  W5Game
//
//  Created by Xcode User on 2019-10-03.
//  Copyright © 2019 Xcode User. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory{
    static let None: UInt32 = 0;
    static let All: UInt32 = UInt32.max;
    static let Baddy: UInt32 = 0b1;
    static let Hero: UInt32 = 0b10;
    
    static let Projectile:UInt32 = 0b11
}

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    private var sportNode:SKSpriteNode?
    private  var score: Int?
    let scoreIncrement = 10
    private var lbScore : SKLabelNode?
    
    
    override func didMove(to view: SKView) {
        sportNode=SKSpriteNode(imageNamed: "SuperGuy.png")
        sportNode?.position=CGPoint(x:10,y:10)
        addChild(sportNode!)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        sportNode?.physicsBody = SKPhysicsBody(circleOfRadius: (sportNode?.size.width)!/2)
        sportNode?.physicsBody?.isDynamic = true
        sportNode?.physicsBody?.categoryBitMask = PhysicsCategory.Hero
        sportNode?.physicsBody?.contactTestBitMask = PhysicsCategory.Baddy
        sportNode?.physicsBody?.collisionBitMask = PhysicsCategory.None
        sportNode?.physicsBody?.usesPreciseCollisionDetection = true
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addBaddy),SKAction.wait(forDuration: 0.5)])))
        
        score = 0
        self.lbScore = self.childNode(withName: "//score") as! SKLabelNode
        self.lbScore?.text = "Score: \(score!)"
        
        if let slabel = self.lbScore{
            slabel.alpha = 0
            slabel.run(SKAction.fadeIn(withDuration: 1.0))
        }
    }
    
    func heroDidCollideWithBody(hero: SKSpriteNode, baddy:SKSpriteNode){
        print("Hit")
        
        score = score! + scoreIncrement
        self.lbScore?.text = "Score: \(score!)"
        if let slabel = self.lbScore{
            slabel.alpha = 0
            slabel.run(SKAction.fadeIn(withDuration: 1.0))
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if(contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if((firstBody.categoryBitMask & PhysicsCategory.Baddy != 0) && (secondBody.categoryBitMask & PhysicsCategory.Hero != 0)){
            heroDidCollideWithBody(hero: firstBody.node as! SKSpriteNode, baddy: secondBody.node as! SKSpriteNode)
        }
    }
    
    func random()->CGFloat{
        return CGFloat(Float(arc4random())/0xFFFFFFFF)
    }
    
    func random(min:CGFloat,max:CGFloat)->CGFloat{
        return random() * (max-min) + min
    }
    
    func addBaddy(){
        let baddy = SKSpriteNode(imageNamed: "BadGuy.png")
        baddy.xScale = baddy.xScale * -1
        
        let actualY = random(min: baddy.size.height/2, max: size.height-baddy.size.height/2)
        
        baddy.position = CGPoint(x:size.width,y:actualY)
        addChild(baddy)
        
        // adding physics
        baddy.physicsBody = SKPhysicsBody(rectangleOf: baddy.size)
        baddy.physicsBody?.isDynamic = true;
        baddy.physicsBody?.categoryBitMask = PhysicsCategory.Baddy
        baddy.physicsBody?.contactTestBitMask = PhysicsCategory.Hero
        baddy.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        let actualDuration = random(min: 2.0, max: 4.0)
        
        let actionMove = SKAction.move(to: CGPoint(x: baddy.size.width/2,y: actualY), duration: TimeInterval(actualDuration))
        
        let actionMoveDone = SKAction.removeFromParent()
        
        baddy.run(SKAction.sequence([actionMove,actionMoveDone]))
    }
    
    func moveGoodBoy(toPoint pos: CGPoint){
        let actionMove = SKAction.move(to: pos, duration: 1.0)
        let actionMoveDone = SKAction.rotate(byAngle: 360.0, duration: 1.0)
        sportNode?.run(SKAction.sequence([actionMove,actionMoveDone]))
    }
    
    func touchDown(atPoint pos : CGPoint) {
        moveGoodBoy(toPoint: pos)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        moveGoodBoy(toPoint: pos)
    }
    
    func touchUp(atPoint pos : CGPoint) {
        moveGoodBoy(toPoint: pos)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
