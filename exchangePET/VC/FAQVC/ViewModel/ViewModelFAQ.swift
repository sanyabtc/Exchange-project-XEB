//
//  ViewModelFAQ.swift
//  exchangePET
//
//  Created by Александр Басалаев on 20.04.2025.
//

import Foundation

final class ViewModelFAQ {
    private(set) var links: LinksProtocol
    
    init(links: LinksProtocol = Links()) {
        self.links = links
    }
    
    func numberOfSections() -> Int {
        return FAQRepository.shared.sections.count
    }
    
    func openTelegram() {
        links.telegramLink()
    }
    
    func openWhatsApp() {
        links.whatsAppLink()
    }
    
    func openEmail() {
        links.mailLink()
    }
    
    func titleForSection(_ index: Int) -> String {
        return FAQRepository.shared.sections[index]
    }
}
