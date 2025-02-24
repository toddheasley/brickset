import Foundation

public enum Order: String, CaseIterable, Encodable {
    case Name, Number
    case Pieces, PiecesDESC,
         Minifigs, MinifigsDESC
    case YearFrom, YearFromDESC
    case UKRetailPrice, UKRetailPriceDESC,
         USRetailPrice, USRetailPriceDESC,
         CARetailPrice, CARetailPriceDESC,
         DERetailPrice, DERetailPriceDESC
    case UKPricePerPiece, UKPricePerPieceDESC,
         USPricePerPiece, USPricePerPieceDESC,
         CAPricePerPiece, CAPricePerPieceDESC,
         DEPricePerPiece, DEPricePerPieceDESC
    case Theme, Subtheme
    case QtyOwned, QtyOwnedDESC,
         OwnCount, OwnCountDESC,
         WantCount, WantCountDESC
    case Rating, RatingDESC,
         UserRating, UserRatingDESC,
         Rank, RankDESC
    case CollectionID
    case Random
}
