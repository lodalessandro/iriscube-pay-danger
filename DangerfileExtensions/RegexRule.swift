import Danger

class RegexRule: BaseRule {    
    var name: String
    var successMessage: String?
    var warnMessage: String?
    var failMessage: String?
    var regex: String
    
    init(name: String,
         successMessage: String? = nil,
         warnMessage: String? = nil,
         failMessage: String? = nil,
         regex: String) {
        self.name = name
        self.successMessage = successMessage
        self.warnMessage = warnMessage
        self.failMessage = failMessage
        self.regex = regex
    }
    
    func run(on files: [File]?) -> RuleResult {
        guard let files = files else { return .success }
        
        for file in files {
            let result = danger.utils.readFile(file).range(of: regex,
                                                           options: .regularExpression)
            if let _ = result {
                return .fail
            }
        }
        
        return .success
    }
}
