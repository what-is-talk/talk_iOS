//
//  boxLine.swift
//  talk_iOS
//
//  Created by 경유진 on 2023/01/30.
//

import Foundation
import UIKit

struct CustomView {
    let setLine: UIView = {
        let line = UIView()
        line.layer.backgroundColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 0.1).cgColor
        return line
    }()
    
    let setbtnRoundNext: UIButton = {
        let btnRoundNext = UIButton()
        btnRoundNext.setBackgroundImage(UIImage(named: "btnRoundNext"), for: .normal)
        return btnRoundNext
    }()
    
    let setTextLabel: UILabel = {
        let setTextLabel = UILabel()
        setTextLabel.text = "라벨"
        setTextLabel.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
        setTextLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return setTextLabel
    }()
    
    let setTextField: UITextField = {
        let setTextField = UITextField()
        setTextField.placeholder = "입력하세요"
        setTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        return setTextField
    }()
    
    let setSwitch: UISwitch = {
        let setSwitch = UISwitch()
        setSwitch.onTintColor = UIColor.TalkRed
        setSwitch.tintColor = UIColor.TalkRed
        setSwitch.isOn = false
        return setSwitch
    }()
}
