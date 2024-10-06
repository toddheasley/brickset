import Foundation

extension URLCredential {
    nonisolated(unsafe) public static var persistence: Persistence = .permanent
    typealias UserHash = (name: String, hash: String)
    
    func userHash() throws -> UserHash {
        guard let user, !user.isEmpty,
              let password, !password.isEmpty else {
            throw Error.invalidUsernameOrPassword
        }
        return (user, password)
    }
    
    convenience init(user name: String, hash: String) throws {
        guard !name.isEmpty, !hash.isEmpty else {
            throw Error.invalidUsernameOrPassword
        }
        self.init(user: "\(name)", password: "\(hash)", persistence: Self.persistence)
    }
}

extension URLCredentialStorage {
    var userHash: URLCredential.UserHash? {
        set {
            removeUserHashes(for: .brickset)
            guard let newValue,
                  let credential: URLCredential = try? URLCredential(user: newValue.name, hash: newValue.hash) else {
                return
            }
            set(credential, for: .brickset)
        }
        get { userHashes(for: .brickset).first }
    }
    
    private func removeUserHashes(for space: URLProtectionSpace) {
        for credential in (credentials(for: space) ?? [:]).values {
            remove(credential, for: space)
        }
    }
    
    private func userHashes(for space: URLProtectionSpace) -> [URLCredential.UserHash] {
        (credentials(for: space) ?? [:]).compactMap { try? $0.value.userHash() }
    }

}

extension URLProtectionSpace {
    static let brickset: URLProtectionSpace = URLProtectionSpace(host: "api.brickset", port: 0, protocol: "https", realm: nil, authenticationMethod: nil)
}
