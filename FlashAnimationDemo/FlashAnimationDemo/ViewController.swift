//
//  ViewController.swift
//  FlashAnimationDemo
//
//  Created by Molder on 2021/9/4.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var noFlashButton: UIButton!
    @IBOutlet weak var flashButton: UIButton!
    @IBOutlet weak var flashImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initButton()
    }

    private func initButton() {
        noFlashButton.layer.cornerRadius = 5
        flashButton.layer.cornerRadius = 5
        flashImageView.layer.cornerRadius = 5
        showAnimationsWithButton(targetBtn: flashButton)
    }

    func showAnimationsWithButton(targetBtn: UIButton) {
        // 建立遮罩圖
        let maskLayer = CALayer()
        let maskImage = UIImage(named: "btnLightMask")
        maskLayer.frame = CGRect(x: 0,
                                 y: 0,
                                 width: (maskImage?.size.width)!*2,
                                 height: (maskImage?.size.height)!*2)
        maskLayer.contents = maskImage?.cgImage
        
        // flashImageView 加入遮罩
        flashImageView.layer.mask = maskLayer
        
        // 取得手機螢幕寬度
        let screenWidth = UIScreen.main.bounds.size.width
        
        // 建立動畫物件
        // 指定動畫類型
        let flashAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        let width = maskLayer.frame.size.width > screenWidth ? maskLayer.frame.size.width : screenWidth
        // 動畫從何開始
        flashAnimation.fromValue = -width
        // 動畫到哪結束
        flashAnimation.toValue = screenWidth
        // 動畫開始到結束所需的時間，越長動畫越慢
        flashAnimation.duration = 3
        // 動畫循環次數 .greatestFiniteMagnitude = 最大次數(接近無窮大), .infinity = 無窮大
        flashAnimation.repeatCount = CFloat.greatestFiniteMagnitude
        // 動畫結束時不刪除
        flashAnimation.isRemovedOnCompletion = false
        // 動畫結束時，動畫的停止位置 .forwards = 動畫結束的樣子, .backwards = 動畫開始前的樣子
        flashAnimation.fillMode = CAMediaTimingFillMode.forwards
        maskLayer.add(flashAnimation, forKey: "transform.translation.x")
    }
    
    @IBAction func Action(_ sender: UIButton) {
        print("tag : \(sender.tag)")
    }
}

