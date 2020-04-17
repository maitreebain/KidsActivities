//
//  Data+ConvertToURL.swift
//  Test
//
//  Created by Bienbenido Angeles on 4/16/20.
//  Copyright © 2020 Bienbenido Angeles. All rights reserved.
//
import Foundation

extension Data {


    public func convertToURL() -> URL?{
        
        let tempURL = URL(fileURLWithPath:  NSTemporaryDirectory()).appendingPathComponent("video").appendingPathExtension("mp4")
        
        do {
            // .atomic means all at once
            try self.write(to: tempURL, options: [.atomic])
            return tempURL
        } catch {
            print("fialed to write (save) video data to temporary files with error: \(error)")
        }
        return nil
    }
}
