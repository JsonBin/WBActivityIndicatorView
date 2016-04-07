# WBActivityIndicatorView
swift 写的一段 环形加载进度动画视图

使用教程
=======
  
  * 初始化
    
        let aview = WBActivityIndicatorView.init(frame: CGRectMake(0, 0, 100, 100), lineWidth: 2, topColor: UIColor.redColor(), bottomColor: UIColor.greenColor())
        // 显示
        aview.showActivityViw(self.view)
        // 开始动画
        aview.start()
  * 显示进度
   
        // 下载时加入这句表示下载进度 (count 0~1 之间)
        aview.setProgress(count)

  * 移除
  
        // 移除进度条
        aview.stop()

效果图
======
![gif](https://github.com/JsonBin/WBActivityIndicatorView/raw/master/WBActivityIndicatorView/activity.gif "进度条")
