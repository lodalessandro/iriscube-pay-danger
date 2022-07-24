import Danger

class RegexRule: BaseRule {    
    var name: String
    var message: String?
    var regex: String
    
    init(name: String,
         message: String? = nil,
         regex: String) {
        self.name = name
        self.message = message
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
