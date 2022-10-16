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
    
    override func run(created: [File]?, modified: [File]?, deleted: [File]? = nil) {
        guard let created = created,
              let modified = modified else { return }
        
        for file in created + modified {
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
