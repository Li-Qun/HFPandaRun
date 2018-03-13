//
//  Platform.swift
//  HFPanda
//
//  Created by HF on 2018/2/6.
//  Copyright © 2018年 HF-Liqun. All rights reserved.
//

import SpriteKit

class Platform:SKNode {
    var width  = 0.0
    var height = 10.0
    
    //创建平台函数
    //参数是一个平台数组,平台数组包括左中右三种图片，中间的图片数量大于等于0个，中间图片数越长，平台长度越长
    func onCreatePlatform(spriteArray:[SKSpriteNode]) {
        for childPlatform in spriteArray {
            childPlatform.position.x = CGFloat(self.width)
            self.addChild(childPlatform)
            self.width = Double(childPlatform.position.x + childPlatform.size.width)
        }
        //物理实体参数
        self.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize.init(width: CGFloat(self.width), height: CGFloat(self.height)), center: CGPoint.init(x: self.width/2, y: 0)) //设置碰撞体和物理碰撞检测范围
        self.physicsBody?.categoryBitMask = BitMaskType.platform
        self.physicsBody?.isDynamic = false//碰撞结束后 不需要弹开
        self.physicsBody?.allowsRotation = false//碰撞后不产生角度变化eg碰撞和翻滚都不需要产生角度变化
        //摩擦力设置为0
        self.physicsBody?.restitution = 0 //碰撞后不会被黏住
        self.zPosition = 20
    }
}
