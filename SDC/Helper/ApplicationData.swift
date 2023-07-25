//
//  ApplicationData.swift
//  SDC
//
//  Created by Razan Barq on 26/07/2023.
//

import Foundation

public typealias AuthData = [Account]

public struct Account: Codable, Equatable {
    let userName: String
    let password: String
}

public class ApplicationData {
    
    public static let shared = ApplicationData()

    private var dataKey = SecuredStore(service: Helper.shared.storingDataKey)
    private static var accountsKey = "accounts"
    
    public func setAccount(with data: Account) {
        var accounts: AuthData = []
        if let accountsList = self.getAccountsList(), !accountsList.isEmpty {
            accounts = accountsList
        }
        if !self.doesAccountExsits(data) {
            accounts.append(data)
        }
        self.saveAccount(with: accounts)
    }
    
    public func updateAccount(with data: Account) {
        self.removeAccount(data)
        self.setAccount(with: data)
    }
    
    public func doesAccountExsits(_ account: Account) -> Bool {
        guard let accountsList = self.getAccountsList(), !accountsList.isEmpty else {
            return false
        }
        return accountsList.contains(where: { $0 == account })
    }
    
    public func doesAccountExsitsWithoutPassword(_ account: Account) -> Bool {
        guard let accountsList = self.getAccountsList(), !accountsList.isEmpty else {
            return false
        }
        return accountsList.contains(where: { $0.userName == account.userName })
    }
    
    private func saveAccount(with data: AuthData) {
        guard let accountData = try? JSONEncoder().encode(data) else {
            return
        }
        dataKey.updateData(accountData, forKey: ApplicationData.accountsKey)
    }
    
    public func removeAccount(_ account: Account){
        guard self.doesAccountExsitsWithoutPassword(account) else {
            return
        }
        var accounts: AuthData = []
        if let accountsList = self.getAccountsList(), !accountsList.isEmpty {
            accounts = accountsList
            accounts.removeAll(where: {($0.userName == account.userName)})
        }
        if accounts.isEmpty {
            dataKey.removeValueForKey(ApplicationData.accountsKey)
        } else {
            self.saveAccount(with: accounts)
        }
    }
    
    public func getAccountsList() -> AuthData? {
        guard let data = dataKey.dataForKey(ApplicationData.accountsKey),
              let accountsList = try? JSONDecoder().decode(AuthData.self, from: data) else {
            return nil
        }
        return accountsList
    }
}
