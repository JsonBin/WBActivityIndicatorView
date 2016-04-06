//
//  ViewController.swift
//  WBActivityIndicatorView
//
//  Created by Zwb on 16/4/5.
//  Copyright © 2016年 zwb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 初始化
        let aview = WBActivityIndicatorView.init(frame: CGRectMake(0, 0, 100, 100), lineWidth: 2, topColor: UIColor.redColor(), bottomColor: UIColor.greenColor())
        // 显示
        aview.showActivityViw(self.view)
        // 开始动画
        aview.start()
        
        // 显示数字变化
        var count = CGFloat()
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        let timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
        dispatch_source_set_timer(timer,dispatch_walltime(nil, 0), 1 * NSEC_PER_SEC, 0)
        dispatch_source_set_event_handler(timer, {
            if(count >= 1){
                dispatch_source_cancel(timer);
            }else{
                dispatch_async(dispatch_get_main_queue(), {
                    // 下载时加入这句表示下载进度
                    aview.setProgress(count)
                });
                count += 0.2;
            }
            });
        dispatch_resume(timer)
 
        // 延时5s后消失
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue(), {
            // 移除进度条
            aview.stop()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

