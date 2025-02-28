import GetSet

extension Params {
    init?(_ query: String? = nil) {
        guard let query: String = query?.trimmingCharacters(in: .whitespacesAndNewlines), !query.isEmpty else { return nil }
        let number: [Int] = query.components(separatedBy: String.separator).compactMap { Int($0) }
        if [1, 2].contains(number.count) {
            self = .setNumber(number.map { "\($0)" }.joined(separator: .separator))
        } else {
            self = .query(query)
        }
    }
}

private extension String {
    static let separator: Self = "-"
}
