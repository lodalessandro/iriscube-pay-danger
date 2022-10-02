extension String {
    
    func numberOfLines() -> Int {
        return numberOfOccurrencesOf(string: "\n") + 1
    }

    func numberOfOccurrencesOf(string: String) -> Int {
        return toArray(separatedBy: string).count - 1
    }
    
    func toArray(separatedBy: String) -> [Self] {
        return components(separatedBy: separatedBy)
    }
}


extension Array {
    
    func prettyPrint() {
        self.forEach {
            print($0)
        }
    }
}
