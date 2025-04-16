//
//  ViewController.swift
//  exchangePET
//
//  Created by Александр Басалаев on 02.04.2025.
//

import UIKit

class ViewController: UIViewController, CurrencySeletcionDelegate {
    
    //MARK: OUTLETS
    @IBOutlet weak var labelBackGround: UILabel!
    @IBOutlet weak var topButtonOutlet: UIButton!
    @IBOutlet weak var bottomButtonOutlet: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var topTextfield: UITextField!
    @IBOutlet weak var bottomTextfield: UITextField!
    @IBOutlet weak var labelLastUpdate: UILabel!
    
    //MARK: Data
    let apiService = ApiService()
    var choosedIndexPathTop: IndexPath?
    var choosedIndexPathBot: IndexPath?
    var cachedPrice: Double?
    var timeService: TimeService?
    var isUpdating = false
    let topTextFieldFormatter = CurrencyTextFieldFormatter()
    let bottomTextFieldFormatter = CurrencyTextFieldFormatter()
    private var currentTopCurrency: String = ""
    private var currentBotCurrency: String = ""

    //MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        SettingsForView.settingsForViewController(for: self)
        getPrice()
        lastChoosedCurrency()
        
        self.timeService = TimeService(viewController: self)
        
        TextFieldCoordinator.setupFormattes(
            inputField: topTextfield,
            outputField: bottomTextfield,
            topFormatter: topTextFieldFormatter,
            bottomFormatter: bottomTextFieldFormatter) { [weak self] changeField, value in
                self?.updateTextFields(triggeredBy: changeField, value: value)
            }
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(dissMissKeyBoard))
        view.addGestureRecognizer(tapgesture)
    }

    //MARK: DissMissKeyBoard
    @objc private func dissMissKeyBoard() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
        }
        
    }
    //MARK: ShowCurrencySelector
    private func showCurrencySelector(isTop: Bool, selectedIndex: IndexPath?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "CurrencySelectionViewController") as? CurrencySelectionViewController else {
            return
        }
        vc.delegate = self
        vc.selectedIndex = selectedIndex
        vc.isTopButton = isTop
        if isTop, let index = choosedIndexPathBot?.row {
            vc.blockedCurrency = currenciesModel[index]
        } else if let index = choosedIndexPathTop?.row {
            vc.blockedCurrency = currenciesModel[index]
        }
        vc.modalPresentationStyle = .pageSheet
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        present(vc, animated: true)
    }
    func currencySelected(_ currency: Currency, forTopButton: Bool) {
        guard let index = currenciesModel.firstIndex(of: currency) else {
            return
        }
        if forTopButton {
            currentTopCurrency = currency.code
            topButtonOutlet.setAttributedTitle(SettingsForView.setBoldTitle(text: currency.code), for: .normal)
            CurrencyStorage.saveTopCurrency(index: index)
            choosedIndexPathTop = IndexPath(row: index, section: 0)
        } else {
            currentBotCurrency = currency.code
            bottomButtonOutlet.setAttributedTitle(SettingsForView.setBoldTitle(text: currency.code), for: .normal)
            CurrencyStorage.saveBottomCurrency(index: index)
            choosedIndexPathBot = IndexPath(row: index, section: 0)
        }
        topTextfield.text = ""
        bottomTextfield.text = ""
        self.getPrice()
    }
    func lastChoosedCurrency() {
        let topIndex = CurrencyStorage.loadTopCurrency()
        let bottomIndex = CurrencyStorage.loadBottomCurrency()
        if let index = bottomIndex, index < currenciesModel.count {
            let currency = currenciesModel[index]
            currentBotCurrency = currency.code
            bottomButtonOutlet.setAttributedTitle(SettingsForView.setBoldTitle(text: currency.code), for: .normal)
            choosedIndexPathBot = IndexPath(row: index, section: 0)
        }
        if let index = topIndex, index < currenciesModel.count {
            let currency = currenciesModel[index]
            currentTopCurrency = currency.code
            topButtonOutlet.setAttributedTitle(SettingsForView.setBoldTitle(text: currency.code), for: .normal)
            choosedIndexPathTop = IndexPath(row: index, section: 0)
        }
    }
    
    //MARK: GET PRICE
    func getPrice() {
        apiService.fetchMarketPrice { [weak self] price in
            guard let self, let price else {
                return
            }
            self.cachedPrice = price
            DispatchQueue.main.async {
                let timeStamp = TimeService.getCurrentTime()
                self.labelLastUpdate.text = "Последнее обновление \(timeStamp)"
                self.timeService?.StartTimer()
                self.updatePlaceHolder()
            }
        }
    }

    //MARK: UpdateOutputLabel
    private func updateTextFields(triggeredBy ChangeField: UITextField, value: String) {
        guard !isUpdating else {
            return
        }
        isUpdating = true
        defer { isUpdating = false }
        let trade = TradeCalculator()
        guard let price = cachedPrice,
              !currentBotCurrency.isEmpty,
              !currentTopCurrency.isEmpty,
              let sourceCurrency = trade.mapTitleToCurrency(currentTopCurrency),
              let targetCurrency = trade.mapTitleToCurrency(currentBotCurrency)
        else {
            topTextfield.placeholder = "0"
            bottomTextfield.placeholder = "0"
            return
        }
        if value.isEmpty {
            topTextfield.text = ""
            bottomTextfield.text = ""
            return
        }
        let sourceIsTop: Bool = (ChangeField == topTextfield)
        
        let calculationClosure: (WhichCurrencyChoosed, WhichCurrencyChoosed, String) -> String? = { input, output, amount in
            let result = TradeCalculator.calculateSum(
                sourceCurrency: input,
                targetCurrency: output,
                amountText: amount,
                price: price,
                isSourceIsTopField: sourceIsTop
            )
            return result
        }
        if ChangeField == topTextfield {
            bottomTextfield.text = calculationClosure(sourceCurrency, targetCurrency, value)
        } else {
            topTextfield.text = calculationClosure(targetCurrency, sourceCurrency, value)
        }
    }
    //MARK: UpdatePlaceHolder
    private func updatePlaceHolder(){
        guard let price = cachedPrice,
              !currentTopCurrency.isEmpty,
              !currentBotCurrency.isEmpty,
              let placeHolders = PlaceHoldersService.placeHoldersControl(
                topCurrency: currentTopCurrency,
                bottomCurrency: currentBotCurrency,
                price: price)
        else {
            topTextfield.placeholder = "0"
            bottomTextfield.placeholder = "0"
            return
        }
        topTextfield.placeholder = placeHolders.top
        bottomTextfield.placeholder = placeHolders.bottom
    }
    
    //MARK: Actions
    
    @IBAction func topButton(_ sender: Any) {
        showCurrencySelector(isTop: true, selectedIndex: choosedIndexPathTop)
    }
    
    
    @IBAction func bottomButton(_ sender: Any) {
        showCurrencySelector(isTop: false, selectedIndex: choosedIndexPathBot)
    }
    
    
    @IBAction func buttonSwitch(_ sender: Any) {
        getPrice()
        let temp = currentTopCurrency
        currentTopCurrency = currentBotCurrency
        currentBotCurrency = temp
        topButtonOutlet.setAttributedTitle(SettingsForView.setBoldTitle(text: currentTopCurrency), for: .normal)
        bottomButtonOutlet.setAttributedTitle(SettingsForView.setBoldTitle(text: currentBotCurrency), for: .normal)
        CurrencySwitcher.swtichCurrencies(topIndex: &choosedIndexPathTop, bottomIndex: &choosedIndexPathBot)
        topTextfield.text = ""
        bottomTextfield.text = ""
        updatePlaceHolder()
    }
    
}


