//
//  CoreDataClient.swift
//  talk_iOS
//
//  Created by 박지수 on 2023/02/10.
//

import Foundation

class CoreDataClient{
    let ctx = CoreDataStack.shared.viewContext
    
    enum CoreDataError:Error{
        case validationError(message:String) // 유효성 검사와 관련된 에러
        case mappingModelError(message: String) // 두 개체간의 데이터 변환할 때
        case persistentStoreCoordinatorError(message:String) // 저장소와 상호작용
        case coreDataError(message: String) // 다른 범주에 속하지 않음
        var errorMessage: String {
            switch self {
            case .validationError(let message):
              return message
            case .mappingModelError(let message):
              return message
            case .persistentStoreCoordinatorError(let message):
              return message
            case .coreDataError(let message):
              return message
            }
          }
    }
    
}



