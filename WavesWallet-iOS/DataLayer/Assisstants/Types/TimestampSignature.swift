//
//  TimestampSignature.swift
//  WavesWallet-iOS
//
//  Created by mefilt on 23.07.2018.
//  Copyright © 2018 Waves Platform. All rights reserved.
//

import Foundation

private enum Constants {
    static let timestamp = "timestamp"
}

struct TimestampSignature: SignatureProtocol {
    typealias Variable = Int64

    private(set) var privateKey: PrivateKeyAccount
    private(set) var variable: Variable

    var variableKey: String {
        return Constants.timestamp
    }
}

extension TimestampSignature {
    init(privateKey: PrivateKeyAccount) {
        self.init(privateKey: privateKey, variable: Date().millisecondsSince1970)
    }
}
