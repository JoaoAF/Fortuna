import Foundation
import CoreData


extension Lancamento {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lancamento> {
        return NSFetchRequest<Lancamento>(entityName: "Lancamento")
    }

    @NSManaged public var categoria: Data?
    @NSManaged public var descricao: String?
    @NSManaged public var isGasto: Boolean?
    @NSManaged public var moeda: Data?
    @NSManaged public var valor: Float?

}
