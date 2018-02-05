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
class GameScene: SKScene {
    //lazy 指当前变量 在第一次使用的时候才会初始化，即“懒加载”
    lazy var panda = HFPanda()
    
    override func didMove(to view: SKView) {
        let skyColor = SKColor.init(red:113.0/255.0, green:197.0/255.0, blue:207.0/255.0, alpha:1.0)
        self.backgroundColor = skyColor
    
        panda.position =  CGPoint.init(x: 0, y: 0)
        self.addChild(panda)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if panda.status == .run {
            panda.jump()
        } else if panda.status == .jump {
            panda.roll()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
