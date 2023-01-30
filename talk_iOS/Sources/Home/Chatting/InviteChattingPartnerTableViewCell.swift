//
//  InviteChattingPartnerTableViewCell.swift
//  talk_iOS
//
//  Created by 박지수 on 2023/01/18.
//

import UIKit

class InviteChattingPartnerTableViewCell:UITableViewCell{
    
    static let identifier = "cell"
    
    let rollStackView:UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .equalSpacing
        view.spacing = 7
        return view
    }()
    
    let myView = UIView()
    var profileImage:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
        view.layer.cornerRadius = 18
        return view
    }()
    var name:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .init(rawValue: 590))
        return label
    }()
    var rolls:[TalkRollBox] = []{
        didSet{
            self.rolls.forEach{
                rollStackView.addArrangedSubview($0)
                $0.snp.makeConstraints{ make in
                    make.width.equalTo(53)
                    make.height.equalTo(20)
                }
            }
        }
    }
    var checkBtnSelected = false{
        didSet{
            self.checkBtnSelected ? self.checkBox.select() : self.checkBox.unSelect()
        }
    }
    var index:Int?
    var checkBox:TalkCheckBox = {
        let checkBox = TalkCheckBox(selected: false)
        return checkBox
    }()
//    var checkBox = TalkCheckBox()
    
    // SuperView에서 전달 받은 함수
//    var selectCheckBtnFromSuperView:((_ index:Int, _ selected:Bool) -> Void)?
//
//    @objc func selectCheckBtn(){
//        print("clicked")
//        checkBox.toggleSelect()
//        guard let index = self.index else {return}
//        guard let selectCheckBtnFromSuperView = self.selectCheckBtnFromSuperView else {return}
//        selectCheckBtnFromSuperView(index, self.checkBox.selected)
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: InviteChattingPartnerTableViewCell.identifier)
        self.selectionStyle = .none
        
        // MyView
        self.contentView.addSubview(myView)
        myView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }

        
        // profileImage
        myView.addSubview(profileImage)
        profileImage.snp.makeConstraints{
            $0.width.height.equalTo(36)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        
        // name
        myView.addSubview(name)
        name.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(profileImage.snp.trailing).inset(-15)
        }
        
        // rollStackView
        myView.addSubview(rollStackView)
        rollStackView.snp.makeConstraints{
            $0.leading.equalTo(name.snp.trailing).inset(-8)
            $0.top.bottom.equalToSuperview()
        }
        
        // checkBox
        
//        checkBox.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector( selectCheckBtn)))
        myView.addSubview(checkBox)
        checkBox.snp.makeConstraints{
            $0.width.height.equalTo(22)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        
        
    }
    
    // cell 재사용 시 값을 초기화
    override func prepareForReuse() {
        super.prepareForReuse()
        self.rolls.forEach{
            $0.removeFromSuperview()
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
