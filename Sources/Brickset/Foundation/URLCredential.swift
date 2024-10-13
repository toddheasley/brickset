import Foundation

extension URLCredential {
    public typealias UserHash = (username: String, hash: String)
    
    static func api(_ hash: String, username: String, persistence: Persistence = .permanent) throws -> Self {
        guard !username.isEmpty else {
            throw Error.invalidUsernameOrPassword
        }
        guard !hash.isEmpty else {
            throw Error.invalidUserHash
        }
        return Self(user: username, password: hash, persistence: persistence)
    }
    
    static func api(_ apiKey: String, persistence: Persistence = .forSession) throws -> Self {
        guard !apiKey.isEmpty else {
            throw Error.invalidAPIKey
        }
        return Self(user: .api, password: apiKey, persistence: persistence)
    }
}

extension URLCredentialStorage {
    public var userHash: URLCredential.UserHash? {
        (credentials(for: .api) ?? [:]).compactMap {
            $0.value.user != .api ? (username: $0.value.user, $0.value.password) : nil
        }.first as?  URLCredential.UserHash
    }
    
    public var apiKey: String? {
        (credentials(for: .api) ?? [:]).compactMap { $0.value.user == .api ? $0.value.password : nil }.first
    }
    
    public func setUserHash(_ hash: String?, username: String? = nil, persistence: URLCredential.Persistence = .permanent) throws {
        removeUserHashes() // Empty or nil hash clears keychain
        guard let hash, !hash.isEmpty else { return }
        set(try .api(hash, username: username ?? "", persistence: persistence), for: .api)
    }
    
    public func setAPIKey(_ apiKey: String?, persistence: URLCredential.Persistence = .forSession) throws {
        removeAPIKey() // Empty or nil key clears keychain
        guard let apiKey, !apiKey.isEmpty else { return }
        set(try .api(apiKey, persistence: persistence), for: .api)
    }
    
    private func removeUserHashes() {
        for credential in (credentials(for: .api) ?? [:]).values {
            guard credential.user != .api else { continue }
            remove(credential, for: .api)
        }
    }
    
    private func removeAPIKey() {
        for credential in (credentials(for: .api) ?? [:]).values {
            guard credential.user == .api else { continue }
            remove(credential, for: .api)
        }
    }
}

extension URLProtectionSpace {
    static let api: URLProtectionSpace = URLProtectionSpace(host: .api)
    
    private convenience init(host: String) {
        self.init(host: host, port: 0, protocol: "https", realm: nil, authenticationMethod: nil)
    }
}

extension String {
    static let api: Self = "api.brickset"
}
