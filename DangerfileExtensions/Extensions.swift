extension String {
    
    func numberOfLines() -> Int {
        return numberOfOccurrencesOf(string: "\n") + 1
    }

    func numberOfOccurrencesOf(string: Self) -> Int {
        return toArray(separatedBy: string).count - 1
    }
    
    func toArray(separatedBy: Self) -> [Self] {
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
