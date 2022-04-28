import Foundation

protocol Fighter {
    var engines: Int { get }
    var sorties: Int { get set }
    
    func launch(fighter: inout Fighter) -> Fighter
}
struct XWing : Fighter {
    var engines: Int
    var sorties: Int

    func launch(fighter: inout Fighter) -> Fighter {
        fighter.sorties = fighter.sorties + 1
        return fighter
    }
}



