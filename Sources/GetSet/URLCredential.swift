import Foundation

extension URLCredential {
    static func api(_ apiKey: String, persistence: Persistence = .forSession) throws -> Self {
        guard !apiKey.isEmpty else {
            throw Error.invalidAPIKey
        }
        return Self(user: .api, password: apiKey, persistence: persistence)
    }
}

extension URLCredentialStorage {
    public var apiKey: String? {
        (credentials(for: .api) ?? [:]).compactMap { $0.value.user == .api ? $0.value.password : nil }.first
    }
    
    public func setAPIKey(_ apiKey: String?, persistence: URLCredential.Persistence = .forSession) throws {
        removeAPIKey() // Empty or nil key clears keychain
        guard let apiKey, !apiKey.isEmpty else { return }
        set(try .api(apiKey, persistence: persistence), for: .api)
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
