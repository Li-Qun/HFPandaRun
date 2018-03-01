//
//  PlatformFactory.swift
//  HFPanda
//
//  Created by HF on 2018/2/6.
//  Copyright © 2018年 HF-Liqun. All rights reserved.
//

import SpriteKit

class PlatformFactory: SKNode {
    //三种平台纹理常量 左中右
    let textureLeft = SKTexture.init(imageNamed:"platform_l")
    let textureRight = SKTexture.init(imageNamed:"platform_r")
    let textureMiddle = SKTexture.init(imageNamed:"platform_m")
    //存放创建平台的数组集
    var platformsArray = [Platform]();
    
    //接收主场景长度
    var mainSceneWidth:CGFloat = 0
    //主场景代理
    var delegate:ProtocolMainScence?
    
    //创建随机长度的平台
    func createPlatformRandom () {
        //中间平台的数量随机
        let midNum:Int = Int(arc4random() % 4 + 1)  // 1到4的随机数
        //平台间距随机
        let padding:CGFloat = CGFloat(arc4random() % 8 + 1) // 1到8的随机数
        //横坐标x
        let x:CGFloat = self.mainSceneWidth + CGFloat(midNum * 50) + padding + 100
        //纵坐标y
        let y:CGFloat = -CGFloat(arc4random() % UInt32(80))
        //创建平台
        createPlatform(middlPlatformNum: midNum, x: x, y: y)
    }
    
    //根据传进来的中间平台数目，搭建完整平台条 （L = 1，R = 1，M >= 1,所以只需要控制M）
    //根据 坐标x,y 得知创建平台的位置高低
    func createPlatform(middlPlatformNum:Int,x:CGFloat,y:CGFloat)   {
        //创建一个平台
        let platform = Platform()
        platform.position = CGPoint.init(x: x, y: y)
        
        let leftPlatformTexture = SKSpriteNode.init(texture: textureLeft)
        let rightPlatformTexture = SKSpriteNode.init(texture: textureRight)
        //左边中心锚点
        leftPlatformTexture.anchorPoint = CGPoint.init(x: 0, y: 0.9)
        //右边中心锚点
        rightPlatformTexture.anchorPoint = CGPoint.init(x: 0, y: 0.9)
        
        //平台中间部分
        var middlePlatformTexturesArray = [SKSpriteNode]()
        middlePlatformTexturesArray.append(leftPlatformTexture)
        for _ in 0...middlPlatformNum {
            let middlePlatformTexture = SKSpriteNode.init(texture: textureMiddle)
            middlePlatformTexture.anchorPoint = CGPoint.init(x: 0, y: 0.9)
            middlePlatformTexturesArray.append(middlePlatformTexture)
        }
        middlePlatformTexturesArray.append(rightPlatformTexture)
        
        //通过数组创建这个平台
        platform.onCreatePlatform(spriteArray: middlePlatformTexturesArray)
        self.addChild(platform)
        
        //平台加入集合
        platformsArray.append(platform)
        
        //每次产生新平台，要告知主场景
        //通用公式：平台长度+ x坐标 - 主场景宽度
        delegate?.onGetDData(dist: CGFloat(platform.width) + x - self.mainSceneWidth )
    }
    
    //平台移动
    func moveWithPlatformSpeed(speed:CGFloat)  {
        for obj in self.platformsArray {
            obj.position.x -= speed
        }
    }
    
}
