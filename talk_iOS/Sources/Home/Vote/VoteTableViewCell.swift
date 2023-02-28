//
//  VoteTableViewCell.swift
//  talk_iOS
//
//  Created by 김희윤 on 2023/02/23.
//

import UIKit

    
    class VoteTableViewCell:UITableViewCell{
        static let identifier = "cell"
        
        // Cell간 간격 조정 메소드
        override func layoutSubviews() {
           super.layoutSubviews()
           contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0))
         }
        
        
        var myView : UIView = {
            let myView = UIView()
            myView.backgroundColor = .white
            myView.frame = CGRect(x: 0, y: 0, width: 375, height: 56)
            myView.layer.cornerRadius = 8.0
            myView.layer.shadowOpacity = 1
            myView.layer.shadowRadius = 8.0
            myView.layer.shadowOffset = CGSize(width: 0, height: 0)
            myView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
            myView.translatesAutoresizingMaskIntoConstraints = false
            return myView
        }()
        
        var profileImage:UIImageView = {
            let profileImage = UIImageView()
            profileImage.backgroundColor = .gray
            profileImage.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
            profileImage.layer.cornerRadius = profileImage.frame.height/2
            profileImage.contentMode = .scaleAspectFill
            profileImage.clipsToBounds = true
            return profileImage
        }()
        
        var memberNameLabel : UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
           return label
        }()
        
        var dateLabel : UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
           return label
        }()
        
        var seeMoreLabel : UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
            label.text = "자세히 보기 >"
           return label
        }()
        
        
        var voteInnerView : UIView = {
            let view = UIView()
            view.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            return view
        }()
        
        var voteName : UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
           return label
        }()
        
        var voteDescription : UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 16)
            label.numberOfLines = 2
            label.sizeToFit()
            // 텍스트에 맞게 조절된 사이즈를 가져와 height만 fit하게 값을 조절.
            let newSize = label.sizeThatFits( CGSize(width: label.frame.width, height: CGFloat.greatestFiniteMagnitude))
            label.frame.size = newSize
            label.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
           return label
        }()
        
        var voteStackView : UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.spacing = 15
            return stackView
        }()
        
        var voteView : UIButton = {
            let view = UIButton()
            view.layer.cornerRadius = 8
            view.backgroundColor = UIColor(red: 0.922, green: 0.184, blue: 0.188, alpha: 1)
            view.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            view.setTitle("투표하기", for: .normal)
            return view
        }()
        
        @objc func buttonTapped(){
            print("버튼 눌렀다")
        }
        
        
        var categories:[VoteStackViewCellClass] = [] {
            didSet{
                self.categories.forEach{
                    voteStackView.addArrangedSubview($0)
                    $0.snp.makeConstraints{ make in
                        make.width.equalToSuperview()
                        make.height.equalTo(35)
                    }
                }
            }
        }
        
        
        override func prepareForReuse() {
            super.prepareForReuse()
            self.categories.forEach{
                $0.removeFromSuperview()
            }
            
        }
        
    }


