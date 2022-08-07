import Danger

class RegexRule: BaseRule {
    var regex: String
    var regexMatchResult: RuleResult
    
    init(name: String,
         message: String? = nil,
         regex: String,
         regexMatchResult: RuleResult) {
        
        self.regex = regex
        self.regexMatchResult = regexMatchResult
        super.init(name: name, message: message)
    }
    
    override func run(on files: [File]?) {
        guard let files = files
        else {
            result = .success
            return
        }
        
        for file in files {
            let regexResult = danger.utils.readFile(file).range(of: regex,
                                                           options: .regularExpression)
            if let _ = regexResult {
                result = regexMatchResult
                return
            }
        }
        
        result = .success
    }
}
