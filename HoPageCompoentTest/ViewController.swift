//
//  ViewController.swift
//  HoPageCompoentTest
//
//  Created by Hoa on 2021/3/31.
//

import UIKit
import HoPageComponent

class DemoViewController: UIViewController {

    init(color: UIColor) {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let colors = [UIColor.black, UIColor.blue, UIColor.red]
        let titles = ["好的", "男的", "女的"]
        
        /// 初始化 下标位置
        let dataCenter = HoPageDataCenter.init(1)
        
        /// 菜单栏
        let menus = DemoMenuBar(titles: titles, dataCenter: dataCenter)
        let controllers = titles.enumerated().map { offset, _ -> UIViewController in
            
            let vc = DemoViewController(color: colors[offset])
            return vc
        }
        /// 容器视图
        let contentView = HoPageContentView(controllers, parent: self, dataCenter: dataCenter)
        
        /// 布局
        view.addSubview(menus)
        menus.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
        menus.setupUI()
        
        view.addSubview(contentView)
        contentView.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100)
    }


}

class DemoMenuBar: HoPageBaseMenu {
    
    private var buttons: [UIButton]!
    private var selectedButton: UIButton!
    init(titles: [String], dataCenter: HoPageDataCenter) {
        super.init(dataCenter: dataCenter)
        buttons = titles.map ( buildButton(_:) )
        setTags(buttons)
        buttons.forEach { button in
            button.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        }
        setIndex(index: dataCenter.selectedIndex.value)
    }
    
    func setupUI() {
        
        let buttonWidth: CGFloat = 60
        let buttonHeight: CGFloat = self.bounds.height
        buttons.enumerated().forEach { (offset, button) in
            addSubview(button)
            let x: CGFloat = CGFloat(offset) * buttonWidth
            button.frame = CGRect(x: x, y: 0, width: buttonWidth, height: buttonHeight)
        }
        
    }
    
    override func setIndex(index: Int) {
        
        selectedButton?.isSelected = false
        
        selectedButton = buttons?[index]
        
        selectedButton?.isSelected = true
    }
    
    @objc func buttonClick(_ sender: UIButton) {
        itemClick(sender)
    }
    
    func buildButton(_ title: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.red, for: .selected)
        return button
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

