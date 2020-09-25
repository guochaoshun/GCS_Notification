# GCS_Notification  
遇见过一个面试题,要求模仿系统通知中心,自己实现内部逻辑, 今天找机会写了写.    
写写可以优化的地方：  
    只是简单的实现了NSNotificationCenter，没有实现线程的NSNotificationQueue，queue的可以异步发送通知，可以合并发送通知，参考文章 ： https://www.jianshu.com/p/5c1a60f83ba9 ，https://www.jianshu.com/p/6a05f30cd605 ，参考视频 ： https://ke.qq.com/webcourse/index.html#cid=171725&term_id=100200899&taid=1318516305338061&vid=m14186w8end    
    在上面的视频上还提到了一个NSPort，有机会了解一下。

