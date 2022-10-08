//
//  AlcoholMeter+CoreDataProperties.swift
//  AlcoholMeter
//
//  Created by Natalia De Biasio on 17/11/2021.
//
//

import Foundation
import CoreData


extension AlcoholMeter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AlcoholMeter> {
        return NSFetchRequest<AlcoholMeter>(entityName: "Note")
    }

    @NSManaged public var bac: String?
    @NSManaged public var brac: String?
    @NSManaged public var des: String?
    @NSManaged public var fecha: Date?
    @NSManaged public var id: Int32
    @NSManaged public var memoria: String?
    @NSManaged public var title: String?
    @NSManaged public var nombre: String?
    @NSManaged public var nacimiento: Date?
    @NSManaged public var altura: String?
    @NSManaged public var peso: String?
    @NSManaged public var memoria2: String?
    @NSManaged public var score: String?


}

extension AlcoholMeter : Identifiable {

}
