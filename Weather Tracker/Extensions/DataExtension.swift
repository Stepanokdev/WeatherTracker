//
//  DataExtension.swift
//  Weather Tracker
//
//  Created by Ivan Stepanok on 15.12.2024.
//

import Foundation

extension Data {
    func convertTo<SomeData: Decodable>(_ dataModel: SomeData.Type) -> SomeData? {
        do {
            let result = try JSONDecoder().decode(dataModel, from: self)
            return result
        } catch let error {
            print(error)
            return nil
        }
    }
}
