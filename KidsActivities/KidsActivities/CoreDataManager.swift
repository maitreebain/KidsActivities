//
//  CoreDataManager.swift
//  AVFoundation-MediaFeed
//
//  Created by Maitree Bain on 4/14/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    
    private init() { }
    static let shared = CoreDataManager()
    
    private var mediaObjects = [ActivityData]()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func create(_ imageData: Data, videoURL: URL?) -> ActivityData {
        let mediaObject = ActivityData(entity: ActivityData.entity(), insertInto: context)
        mediaObject.id = UUID().uuidString
        mediaObject.imageData = imageData
        if let videoURL = videoURL {
            do{
                mediaObject.videoData = try Data(contentsOf: videoURL)
            } catch {
                print("failed to convert data to url: \(error)")
            }
        }
        
        do {
            try context.save()
        } catch {
            print("failed to save newly created media object with error: \(error)")
        }
        
        return mediaObject
    }
    
    func fetchMediaObjects() -> [ActivityData]{
        do {
            mediaObjects = try context.fetch(ActivityData.fetchRequest())
            
        } catch {
            print("could not fetch mediaObjects")
        }
        
        return mediaObjects
    }
    
}
