//
//  JoinViewController+PHPickerViewControllerDelegate.swift
//  talk_iOS
//
//  Created by 박지수 on 2023/02/06.
//

import UIKit
import PhotosUI

extension JoinViewController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
//        guard let itemProvider = results.first?.itemProvider else {return}
//        guard itemProvider.canLoadObject(ofClass: UIImage.self) else {return}
        results.first?.itemProvider.loadObject(
            ofClass: UIImage.self,
            completionHandler: { (image, error) in
                DispatchQueue.main.async {
                    guard let image = image as? UIImage, let imageData = image.pngData() else {return}
                    self.profileImageData = imageData
                    self.profileImage.showImage(image)
                }
            }
        )
    }
}

extension JoinViewController:UITextFieldDelegate{
    
    // UIViewController 프로토콜
    // 화면 터치시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // Return 시 TextField 비활성화
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
