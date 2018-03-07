//
//  HFBackground.swift
//  HFPanda
//
//  Created by HF on 2018/3/4.
//  Copyright © 2018年 HF-Liqun. All rights reserved.
//

import SpriteKit

class HFBackground:SKNode {
    //近背景数组集合
    var arrBG = [SKSpriteNode]()
    //远处背景数组
    var arrFar = [SKSpriteNode]()
    
    
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //构造器
    override init() {
        super.init()
        //远处树木纹理
        let farTexture = SKTexture.init(imageNamed: "background_f1")
        
        //定义远处树木背景精灵
        let farBg0 = SKSpriteNode.init(texture: farTexture)
        let farBg1 = SKSpriteNode.init(texture: farTexture)
        let farBg2 = SKSpriteNode.init(texture: farTexture)
        
        farBg0.position.y =  -100
        farBg0.zPosition = 9
        //farBg0.anchorPoint = CGPoint.init(x: 0, y: 0)
        farBg0.position.x =  -UIScreen.main.bounds.size.height/2

        farBg1.position.y = -100
        farBg1.zPosition = 9
        //farBg1.anchorPoint = CGPoint.init(x: 0, y: 0)
        farBg1.position.x = farBg0.position.x + farBg0.frame.width
        
        farBg2.position.y = -100
        farBg2.zPosition = 9
        farBg2.anchorPoint = CGPoint.init(x: 0, y: 0)
        farBg2.position.x = farBg1.position.x + farBg0.frame.width
        
        self.addChild(farBg0)
        self.addChild(farBg1)
        self.addChild(farBg2)
        //构建集合
        arrFar.append(farBg0)
        arrFar.append(farBg1)
        arrFar.append(farBg2)
        
        //近处背景纹理
        let nearTure = SKTexture.init(imageNamed:"background_f0")
        //近处背景精灵
        let nearBg0 = SKSpriteNode.init(texture: nearTure)
        nearBg0.zPosition = 10
        //nearBg0.anchorPoint = CGPoint.init(x: 0, y: 0)
        nearBg0.position.y = -130
        nearBg0.position.x = -UIScreen.main.bounds.size.height/2
        
        let nearBg1 = SKSpriteNode.init(texture: nearTure)
        nearBg1.zPosition = 10
        //nearBg1.anchorPoint = CGPoint.init(x: 0, y: 0)
        nearBg1.position.y = -130
        nearBg1.position.x = nearBg0.position.x + nearBg0.frame.width
    
        
        self.addChild(nearBg0)
        self.addChild(nearBg1)
        //构建集合
        arrBG.append(nearBg0)
        arrBG.append(nearBg1)
    }
}
