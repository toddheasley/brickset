extension String {
    public func redacted(_ redact: Bool = true, with character: Character = "•") -> Self {
        redact ? map { _ in
            "\(character)"
        }.joined() : self
    }
}
