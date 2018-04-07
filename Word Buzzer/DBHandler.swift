//
//  DBHandler.swift
//  Word Buzzer
//
//  Created by Abubakr Dar on 4/7/18.
//  Copyright © 2018 Abubakr Dar. All rights reserved.
//

import UIKit

class DBHandler: NSObject {
    func getContentFor(filename: String, ofType fileType: String) -> Array<Dictionary<String, String>> {
        if let path = Bundle.main.path(forResource: filename, ofType: fileType) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Array<Dictionary<String, String>> {
                    return jsonResult
                }
            } catch {
                return Array()
            }
        }
        return Array()
    }
}
