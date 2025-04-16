struct MarketPrice: Codable {
    let resourceType: String
    let price: Double?
    let askPrice: Double
    let bidPrice: Double
    let askOrder: Double?
    let bidOrder: Double?
    
    enum CodingKeys: String, CodingKey {
        case resourceType = "$resourceType"
        case price, askPrice, bidPrice, askOrder, bidOrder
    }
}
