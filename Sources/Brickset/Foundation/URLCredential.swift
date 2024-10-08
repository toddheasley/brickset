import Foundation

extension URLCredential {
    typealias UserHash = (username: String, hash: String)
    
    static func api(_ hash: String, username: String, persistence: Persistence = .default) throws -> Self {
        guard !username.isEmpty else {
            throw Error.invalidUsernameOrPassword
        }
        guard !hash.isEmpty else {
            throw Error.invalidUserHash
        }
        return Self(user: username, password: hash, persistence: persistence)
    }
    
    static func api(_ apiKey: String, persistence: Persistence = .default) throws -> Self {
        guard !apiKey.isEmpty else {
            throw Error.invalidAPIKey
        }
        return Self(user: .brickset, password: apiKey, persistence: persistence)
    }
}

extension URLCredential.Persistence {
    static let `default`: Self = .forSession
}

extension URLCredentialStorage {
    var userHash: URLCredential.UserHash? {
        (credentials(for: .brickset) ?? [:]).compactMap {
            $0.value.user != .brickset ? (username: $0.value.user, $0.value.password) : nil
        }.first as?  URLCredential.UserHash
    }
    
    var apiKey: String? {
        (credentials(for: .brickset) ?? [:]).compactMap { $0.value.user == .brickset ? $0.value.password : nil }.first
    }
    
    func setUserHash(_ hash: String?, username: String? = nil, persistence: URLCredential.Persistence = .default) throws {
        removeUserHashes() // Empty or nil hash clears keychain
        guard let hash, !hash.isEmpty else { return }
        set(try .api(hash, username: username ?? "", persistence: persistence), for: .brickset)
    }
    
    func setAPIKey(_ apiKey: String?, persistence: URLCredential.Persistence = .default) throws {
        removeAPIKey() // Empty or nil key clears keychain
        guard let apiKey, !apiKey.isEmpty else { return }
        set(try .api(apiKey, persistence: persistence), for: .brickset)
    }
    
    private func removeUserHashes() {
        for credential in (credentials(for: .brickset) ?? [:]).values {
            guard credential.user != .brickset else { continue }
            remove(credential, for: .brickset)
        }
    }
    
    private func removeAPIKey() {
        for credential in (credentials(for: .brickset) ?? [:]).values {
            guard credential.user == .brickset else { continue }
            remove(credential, for: .brickset)
        }
    }
}

extension URLProtectionSpace {
    static let brickset: URLProtectionSpace = URLProtectionSpace(host: .brickset)
    
    private convenience init(host: String) {
        self.init(host: host, port: 0, protocol: "https", realm: nil, authenticationMethod: nil)
    }
}

extension String {
    static let brickset: Self = "api.brickset"
}
