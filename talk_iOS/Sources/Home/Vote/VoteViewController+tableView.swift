//
//  VoteViewController+tableView.swift
//  talk_iOS
//
//  Created by 김희윤 on 2023/02/20.
//

import UIKit

    extension VoteViewController : UITableViewDelegate, UITableViewDataSource{
        

        @objc func tapSpecifyButton(_ sender: UITapGestureRecognizer){
            print("클릭했다.")
            let indexPathRow = sender.view?.tag
            let vote = self.voteData[indexPathRow!]

            guard let vc = self.storyboard?.instantiateViewController(identifier: "VoteSpecifyViewController") as? VoteSpecifyViewController else {
                    return
                }
            vc.memberNameLabelValue = vote.creator
            vc.dateLabelValue = vote.createDate
            vc.voteNameValue = vote.title
            vc.voteDescriptionValue = vote.desc ?? ""

            vc.voteID = vote.voteId
            vc.multiSelectionValue = vote.multiSelection
            

            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        @objc func tapVoteButton(){
            print("투표했다.")
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.voteData.count
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: VoteTableViewCell.identifier, for:indexPath) as? VoteTableViewCell else {return UITableViewCell()}
            
            table.rowHeight = 450
            
            //tableView 구분선 없애기
            table.separatorStyle = .none
            
            //cell의 선택(터치이벤트)를 허용하지 않음
            cell.selectionStyle = .none

            let vote = self.voteData[indexPath.row]
            
            var participants : Int = 0

            for countNum in vote.categories {
                participants = participants + countNum.memberCount
            }
                    
            let categorData:[VoteStackViewCellClass] = vote.categories.map{
                return VoteStackViewCellClass.init(voteCategoryLabel: $0.name, selectCount: $0.memberCount, participants : participants, multiSelection: vote.multiSelection)
            }
            
            cell.categories = categorData
            
            cell.voteName.text = vote.title
            cell.voteDescription.text = vote.desc
            cell.memberNameLabel.text = vote.creator
    //        let dateFormatter = DateFormatter()
    //        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" // 2020-08-13 16:30
    //        let str = dateFormatter.string(from: vote.createDate)
            cell.dateLabel.text = vote.createDate
    //        cell.voteCategoryLabel.text = self.voteData[0].categories[indexPath.row].name
    //        cell.selectCount.text = String(self.voteData[0].categories[indexPath.row].memberCount)
            
            cell.contentView.addSubview(cell.myView)
            cell.myView.snp.makeConstraints{
                    $0.top.bottom.equalToSuperview()
                    $0.leading.trailing.equalToSuperview().inset(8)
                }

            [cell.profileImage,cell.memberNameLabel,cell.dateLabel,cell.seeMoreLabel, cell.voteInnerView].forEach{
                cell.myView.addSubview($0)
                }
            cell.profileImage.snp.makeConstraints{
                    $0.width.height.equalTo(32)
                    $0.leading.equalToSuperview().inset(25)
                    $0.top.equalToSuperview().inset(32)
                }

            cell.memberNameLabel.snp.makeConstraints{
                $0.top.equalTo(cell.profileImage)
                $0.leading.equalTo(cell.profileImage.snp.trailing).inset(-16)
                }
            cell.dateLabel.snp.makeConstraints{
                $0.bottom.equalTo(cell.profileImage.snp.bottom)
                $0.leading.equalTo(cell.memberNameLabel)
                }
            cell.seeMoreLabel.snp.makeConstraints{
                $0.centerY.equalTo(cell.profileImage)
                    $0.trailing.equalToSuperview().inset(25)
                }
            
            //seeMoreLabel 이 사용자와 상호작용(터치이벤트 인시식)하는 것을 허용한다.
            cell.seeMoreLabel.isUserInteractionEnabled = true
            cell.seeMoreLabel.tag = indexPath.row
            cell.seeMoreLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapSpecifyButton)))

            cell.voteInnerView.snp.makeConstraints{
                $0.top.equalTo(cell.profileImage.snp.bottom).inset(-19)
                    $0.bottom.equalToSuperview().inset(32)
                    $0.leading.equalToSuperview().inset(25)
                    $0.trailing.equalToSuperview().inset(25)
                }
            
            [cell.voteName,cell.voteDescription,cell.voteStackView, cell.voteView].forEach{
                cell.voteInnerView.addSubview($0)
                }
                
            cell.voteName.snp.makeConstraints{
                    $0.top.equalToSuperview()
                    $0.leading.equalToSuperview()
                }
            cell.voteDescription.snp.makeConstraints{
                $0.top.equalTo(cell.voteName.snp.bottom).inset(-10)
                $0.leading.trailing.equalToSuperview()
                }
            cell.voteStackView.snp.makeConstraints{
                $0.top.equalTo(cell.voteDescription.snp.bottom).inset(-19)
                $0.leading.trailing.equalToSuperview()
            }
            cell.voteView.snp.makeConstraints{
                $0.top.equalTo(cell.voteStackView.snp.bottom).inset(-30)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(160)
                $0.height.equalTo(40)
            }
            cell.voteView.addTarget(self, action: #selector(tapVoteButton), for: .touchUpInside)
                    
           return cell
        }

    }
