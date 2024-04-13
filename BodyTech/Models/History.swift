//
//  History.swift
//  BodyTech
//
//  Created by Joseph DeWeese on 4/12/24.
//

import Foundation
import RealmSwift

class History: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var dateCompleted: Date?
    @Persisted var woDetails: String?
    @Persisted var exerciseList = List<String>()
    @Persisted var lengthInMinutes: Int = 0
    @Persisted var transcript: String?
    var exercises: [String] { Array(exerciseList) }

    convenience init(dateCompleted: Date = Date(),woDetails: String, exercises: [String], lengthInMinutes: Int, transcript: String? = nil) {
        self.init()
        self.dateCompleted = dateCompleted
        self.woDetails = woDetails
        exerciseList.append(objectsIn: exercises)
        self.lengthInMinutes = lengthInMinutes
        self.transcript = transcript
    }
}
