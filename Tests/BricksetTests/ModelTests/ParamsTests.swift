import Testing
@testable import Brickset
import Foundation

struct ParamsTests {
    
    // MARK: Params
    @Test func value() {
        #expect(GetSets(setNumber: "6692-1", extendedData: true).value == "{'extendedData':1,'setNumber':'6692-1'}")
        #expect(GetSets(query: "9v trains", theme: ["city", "town"], year: [1983, 1984, 1987]).value == "{'query':'9v trains','theme':'city,town','year':'1983,1984,1987'}")
        #expect(GetSets(updatedSince: Date(timeIntervalSince1970: 0.0), orderBy: .USRetailPriceDESC).value == "{'orderBy':'USRetailPriceDESC','updatedSince':'1970-01-01'}")
        #expect(GetSets(setID: 567497).value == "{'setID':567497}")
        #expect(GetSets().value == "{}")
        
        #expect(SetCollection(own: true, qtyOwned: 2, notes: "1 factory sealed; 1 open box 🍒").value == "{'notes':'1 factory sealed; 1 open box 🍒','own':1,'qtyOwned':2}")
        #expect(SetCollection(want: true, rating: 4).value == "{'rating':4,'want':1}")
        #expect(SetCollection().value == "{}")
        
        #expect(GetMinifigCollection(owned: true).value == "{'owned':1}")
        #expect(GetMinifigCollection(wanted: true, query: "Star Wars").value == "{'query':'Star Wars','wanted':1}")
        #expect(GetMinifigCollection().value == "{'query':' '}")
        
        #expect(SetMinifigCollection(own: true, qtyOwned: 1).value == "{'own':1,'qtyOwned':1}")
        #expect(SetMinifigCollection(notes: "Part of set #6692-1").value == "{'notes':'Part of set #6692-1'}")
        #expect(SetMinifigCollection().value == "{}")
    }
}
