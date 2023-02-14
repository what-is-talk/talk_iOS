//
//  HomeMainViewController+Delegate.swift
//  talk_iOS
//
//  Created by User on 2023/02/13.
//

import UIKit

extension HomeMainViewController:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return meetingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMainCollectionViewCell.reuseIdentifier, for: indexPath) as? HomeMainCollectionViewCell else {return UICollectionViewCell()}
        let meeting = meetingList[indexPath.row]
//        self.currentMeetingId = meeting.id
        cell.imageUrl = URL(string: meeting.profileImage) 
        cell.groupName = meeting.name
        cell.selecting = meeting.id == self.currentMeetingId
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let vInset = (COLLECTIONVIEW_HEIGHT - COLLECTIONVIEW_CELL_SIZE.width) / 2
        return UIEdgeInsets(top: vInset, left: 0, bottom: vInset, right: 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return COLLECTIONVIEW_CELL_SIZE
    }
    
    // cell 선택되었을 때 동작할 함수
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMeeting = meetingList[indexPath.row]
        self.currentMeetingId = selectedMeeting.id
        collectionView.reloadData()
    }
    
 
}


