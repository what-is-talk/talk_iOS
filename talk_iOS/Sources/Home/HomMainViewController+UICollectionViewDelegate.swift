//
//  HomMainViewController+UICollectionViewDelegate.swift
//  talk_iOS
//
//  Created by 박상민 on 2023/02/07.
//

import UIKit

extension HomeMainViewController:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMainCollectionViewCell.reuseIdentifier, for: indexPath) as? HomeMainCollectionViewCell else {return UICollectionViewCell()}
        cell.groupImage = groupList[indexPath.row].image
        cell.groupName = groupList[indexPath.row].groupName
        cell.selecting = groupList[indexPath.row].selecting
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
        print("클릭:\(indexPath.row)")
        for i in 0..<groupList.count{
            groupList[i].selecting = false
        }
        groupList[indexPath.row].selecting = true
        collectionView.reloadData()
    }
    
 
}
