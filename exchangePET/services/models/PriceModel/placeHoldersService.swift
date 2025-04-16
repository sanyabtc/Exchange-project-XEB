struct PlaceHoldersService {
    static func placeHoldersControl(
        topCurrency: String,
        bottomCurrency: String,
        price: Double
    ) -> (top: String, bottom: String)? {
        let trade = TradeCalculator()
        guard let top = trade.mapTitleToCurrency(topCurrency),
              let bottom = trade.mapTitleToCurrency(bottomCurrency) else {
            return nil
        }
        guard let placeHolders = TradeCalculator.placeHolderCourse(
            topCurrency: top,
            bottomCurrency: bottom,
            price: price) else {
            return nil
        }
        return (placeHolders.topPlaceHolder, placeHolders.bottomPlaceHolder)
    }
}
