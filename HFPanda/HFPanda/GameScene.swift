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
class GameScene: SKScene,ProtocolMainScence {
    //lazy 指当前变量 在第一次使用的时候才会初始化，即“懒加载”
    lazy var panda = HFPanda()
    lazy var platformFactory = PlatformFactory()
    
    //初始化平台移动速度
    var platformMoveSpeed:CGFloat = 15;
    
    var lastDis:CGFloat = 0.0
    
    override func didMove(to view: SKView) {
        let skyColor = SKColor.init(red:113.0/255.0, green:197.0/255.0, blue:207.0/255.0, alpha:1.0)
        self.backgroundColor = skyColor
    
        panda.position =  CGPoint.init(x: 0, y: 0)
        self.addChild(panda)
        
        //把平台工厂加入场景中
        self.addChild(platformFactory)
        platformFactory.createPlatform(middlPlatformNum: 2, x: -200, y: -panda.frame.size.height)
        //设置代理
        platformFactory.delegate = self
        platformFactory.mainSceneWidth = self.frame.size.width
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if panda.status == .run {
            panda.jump()
        } else if panda.status == .jump {
            panda.roll()
        }
    }
    //每一帧执行一次的系统update方法
    override func update(_ currentTime: TimeInterval) {
        
        lastDis -= self.platformMoveSpeed;
        //当前移动平台完全进入场景后 创建新的平台
        if (lastDis <= 0) {
            print("创建新平台")
            platformFactory.createPlatform(middlPlatformNum: 1, x: 1500, y: -panda.frame.size.height)
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
