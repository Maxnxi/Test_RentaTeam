//
//  RealmServices.swift
//  Test_1_RentaTeam
//
//  Created by Maksim Ponomarev on 10.11.2021.
//

import Foundation
import RealmSwift

class RealmServices {
    
    static let shared = RealmServices()
    
    lazy var isPhotosInfoSaved: Bool = {
       return checkIfRealmIsNotEmpty()
    }()
    
    private init() {
        isPhotosInfoSaved = checkIfRealmIsNotEmpty()
    }
    
    private func checkIfRealmIsNotEmpty() -> Bool {
        do {
            let realm = try Realm()
            return realm.isEmpty
        } catch {
            print("Error in RealmServices - checkIfRealmIsNotEmpty")
        }
        return false
    }
   
    public func saveImagesInfo(imagesInfo: [PhotoInfoRealmObject]) {
        do {
            let realm = try Realm()
            try realm.write({
                realm.deleteAll()
                realm.add(imagesInfo)
            })
        } catch let error as NSError {
            print("Error in RealmServices - loadImagesInfo: ", error)
        }
    }
    
    public func loadImagesInfo() -> [PhotoInfoRealmObject]? {
        do {
            let realm = try Realm()
            let result = realm.objects(PhotoInfoRealmObject.self)
            let imagesInfo = Array(result)
            return imagesInfo
        } catch let error as NSError {
            print("Error in RealmServices - loadImagesInfo: ", error)
            return nil
        }
    }
    
}