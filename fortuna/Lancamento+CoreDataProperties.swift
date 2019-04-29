//
//  Lancamento+CoreDataProperties.swift
//  fortuna
//
//  Created by Rafael Parente on 27/04/19.
//  Copyright © 2019 João Paulo de Araújo Ferreira. All rights reserved.
//
//

import Foundation
import CoreData


extension Lancamento {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lancamento> {
        return NSFetchRequest<Lancamento>(entityName: "Lancamento")
    }

    @NSManaged public var descricao: String?
    @NSManaged public var categoria: String
    @NSManaged public var valor: Float
    @NSManaged public var moeda: String
    @NSManaged public var isGasto: Bool

}
