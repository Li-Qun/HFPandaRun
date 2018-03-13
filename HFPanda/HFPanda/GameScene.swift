//
//  GameScene.swift
//  HFPanda
//
//  Created by HF on 2018/1/30.
//  Copyright © 2018年 HF-Liqun. All rights reserved.
//

import SpriteKit
import GameplayKit
//游戏主界面
class GameScene: SKScene,ProtocolMainScence,SKPhysicsContactDelegate {
    //lazy 指当前变量 在第一次使用的时候才会初始化，即“懒加载”
    lazy var panda = HFPanda()
    lazy var platformFactory = PlatformFactory()
    lazy var background = HFBackground()
    
    //初始化平台移动速度
    var platformMoveSpeed:CGFloat = 10;
    
    var lastDis:CGFloat = 0.0
    
    //物体之间碰撞就会执行beign代理方法
    func didBegin(_ contact: SKPhysicsContact) {
        //🐼和平台
        if (contact.bodyA.categoryBitMask|contact.bodyB.categoryBitMask == (BitMaskType.panda|BitMaskType.platform)) {
            panda.run()
            print("🐼跑")
        }
        //🐼和场景边缘的碰撞检测
        if (contact.bodyA.categoryBitMask|contact.bodyB.categoryBitMask == (BitMaskType.panda|BitMaskType.scene)) {
            print("游戏结束")
        }
    }
    
    override func didMove(to view: SKView) {
        let skyColor = SKColor.init(red:113.0/255.0, green:197.0/255.0, blue:207.0/255.0, alpha:1.0)
        self.backgroundColor = skyColor
        
        //添加背景
        self.addChild(background)
        background.zPosition = 20//值越大 越先渲染
        //
        self.physicsWorld.contactDelegate = self //遵循协议并设置代理是它自身
        self.physicsWorld.gravity = CGVector.init(dx: 0, dy: -5)//设置向下的重力
        self.physicsBody = SKPhysicsBody.init(edgeLoopFrom: self.frame) //设置碰撞体和物理碰撞检测范围
        self.physicsBody?.categoryBitMask = BitMaskType.scene//设置碰撞检测标识
        self.physicsBody?.isDynamic = false//碰撞结束后 设为false 物理就不会因为力的作用飞来飞去
        
        panda.position =  CGPoint.init(x: 0, y: 0)
        self.addChild(panda)
        panda.zPosition = 40
        
        //把平台工厂加入场景中
        self.addChild(platformFactory)
        platformFactory.zPosition = 30
        platformFactory.createPlatform(middlPlatformNum: 4, x: 0, y: -panda.frame.size.height)
        //设置代理
        platformFactory.delegate = self
        platformFactory.mainSceneWidth = self.frame.size.height //竖屏情况的恒定宽度
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        panda.jump()//点击屏幕时执行跳
    }
    //每一帧执行一次的系统update方法
    override func update(_ currentTime: TimeInterval) {
        background.move(speed: platformMoveSpeed/5)
        lastDis -= self.platformMoveSpeed;
        //当前移动平台完全进入场景后 创建新的平台
        if (lastDis <= 0) {
            print("创建新平台")
            platformFactory.createPlatformRandom()
        }
        self.platformFactory.moveWithPlatformSpeed(speed: self.platformMoveSpeed);
    }
    //实现所遵守的协议方法
    func onGetDData(dist:CGFloat) {
        self.lastDis = dist
    }
}

//遵守协议：给PlatformFactory平台工厂类回传数据用
protocol ProtocolMainScence {
    func onGetDData(dist:CGFloat)
}
