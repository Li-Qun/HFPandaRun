# HFPandaRun
说明来源博客：http://www.cnblogs.com/someonelikeyou/p/8566347.html
前言：想用swift  写个小游戏 慢慢转化 能写出 ARKit来。但是又不能一口吃个胖子，慢慢来，在网络视频教程中撸了视频教学，断断续续看了半个多月，基本实现了

游戏主角🐼在不断移动的平台上跑，二级跳跃，掉出游戏场景打印结束。。。特此做一个小小学习总结，不辜负自己第一个小程序(虽然还有教和苹果碰撞部分都是大同小异了，不再赘述)

一 资源图片

   资源图片是从网友学习成果里面摘出来的，可以用到的图如：🐼跑，跳，平台，背景。

   因为swift语言 一直在不断完善更新，网络教程也好，网友已经完成的项目也好，即使是完全扒代码，也跑步起来，出现一堆错误，这时候靠自己学习Swift4.0 遵守当前的编译规则语法等，还好，多研究揣摩也差不多弄出来了

二 项目的基本架构

 2.1 创建一个新工程HFPanda -->Xcode-->File-->new --> project  -->iOS Application-->Game-->命名HFPanda，语言Swift，游戏技术SpriteKit 即可

2.2 认识SpriteKit

    (1)SpriteKit是在iOS7 SDK中Apple新加入的一个2D游戏引擎框架.SpriteKit展现出的是Apple将Xcode和iOS/Mac SDK打造成游戏引擎的野心，但是同时也确实与IDE有着更好的集成，减少了开发者的工作。

    (2)Sprite 翻译成精灵 。在游戏开发中，精灵指的是以图像方式呈现在屏幕上的一个图像。精灵可以是动态的可以移动，可以和用户交互。也可以只是静止的一个背景等。比如HFPanda项目中，熊猫就是一个精灵，每个移动的平台部分也是精灵，前背景和远处后背景 都是精灵。

2.3 创建swift类

   (1)HFPanda.swift :熊猫类熊猫精灵是整个游戏主角，并有跑，跳，二级跳，滚的动作状态和方法 和 熊猫物理实体参数和物理碰撞检测的相关方法

 

   (2)Platform.swift: 平台类 。

      要点：a 要知道一个完整的平台段是由左中右 三部分精灵拼接而成的，根据中间部分精灵数量 控制整体平台段的长度

               b 平台类作用是传入所有的平台精灵展现一个完整的平台段整体  也需要设置物理实体参数和物理碰撞检测的相关方法
```python
//代码示例：
func onCreatePlatform(spriteArray:[SKSpriteNode])  {
    //code
}    
  ```

   （3）PlatformFactory.swift  ：平台工厂类，用来创造随机长度的平台。平台移动并产生新平台。

       以下说的是平台对象（即完整的一个平台）

        要点：a 平台是从左边到右边移动的，再配合背景，熊猫跑起来就像在一直往前跑（横屏过来右边👉）

                b 平台移动方法根据传进来speed，平台整体全部精灵中心纵坐标不变，恒坐标 减去 speed ，就是往左边移动 speed像素长度 就产生运动效果

                c 从右边到左边移动的平台总有移动完成的时候，当消失在屏幕中的平台（当平台的中心横坐标小于游戏场景左边边界时即屏幕左边边界横坐标），从尤其场景中移除，并从平台队列集合中出队列 

                d 源源不断产生的随机平台，要遵循主场景的ProtocolMainScence代理方法onGetDData，每次产生一个新平台，要告诉主场景，当前创建完的平台在游戏场景中的位置，方便主场景判断何时产生新的平台

    （4）HFBackground.swift：背景类，里面有近背景和远背景 。也需要设置物理实体参数和物理碰撞检测的相关方法

        要点：a 移动方法实施通过外部传进来速度值供给背景 横坐标从右边到左边移动 通过x坐标位移产生动画效果，当背景精灵移动出屏幕后要瞬间归位

                 b 术语：视差滚动技术“视差滚动（Parallax Scrolling）是指让多层背景以不同的速度移动，形成立体的运动效果，带来非常出色的视觉体验。作为今年网页设计的热点趋势，越来越多的网站应用了这项技术。”

      (5)BitMaskType.swift:位运算标识类 ，用来做碰撞检测标识等。每两种二进制位或运算结果唯一，所以使用二进制枚举

 2.4 游戏主场景：GameScene.swift //系统场景

      认识游戏场景中几个方法
 ```python
//系统方法：
override func didMove(to view: SKView) {
     //当切换到这个场景视图后后
     //code:展示背景，平台，熊猫， 并设置场景的物理碰撞相关内容属性
}

override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //响应屏幕点击时间的方法  
    //code:点击屏幕触发的就是🐼熊猫跳，二级跳
}

override func update(_ currentTime: TimeInterval) {
   //每一帧执行一次的系统update方法  
   //code:背景移动，平台是否需要新建？平台移动
}

//遵循SKPhysicsContactDelegate  协议代理方法
func didBegin(_ contact: SKPhysicsContact) {
     //物体之间碰撞就会执行beign代理方法  
     //code:精灵物体之间碰撞就会执行beign代理方法，这里有（🐼和平台之间碰撞-->执行🐼跑）和（🐼和场景-->game over）
}
  ```


参考：

1 http://www.swiftv.cn/secure/course/hxbazkq4/learn?lectureId=hxbazkq40.91211870708502830.13575999299064279#lesson/hxbazkq40.91211870708502830.13575999299064279

2 https://github.com/jakciehoo/KongfuPanda

3 http://blog.csdn.net/jiang314/article/details/53130126
