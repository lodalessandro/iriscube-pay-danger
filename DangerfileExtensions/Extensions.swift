extension String {
    
    func numberOfLines() -> Int {
        return numberOfOccurrencesOf(string: "\n") + 1
    }

    func numberOfOccurrencesOf(string: String) -> Int {
        return components(separatedBy: string).count - 1
    }
}
