import Danger

// fileImport: DangerfileExtensions/BaseRule.swift
// fileImport: DangerfileExtensions/PrRule.swift
// fileImport: DangerfileExtensions/RegexRule.swift
// fileImport: DangerfileExtensions/RuleResult.swift
// fileImport: DangerfileExtensions/RuleRunner.swift
// fileImport: DangerfileExtensions/RulesImplementation.swift


let danger = Danger()

let rules: [RuleRunner.RunnableRule] = [ .bigPullRequest,
                                         .prHasAssignee,
                                         .prHasDescription,
                                         .forceUnwrappedOptional,
                                         .classProtocol ]
let ruleRunner: RuleRunner = .init()
ruleRunner.runRules(from: rules)


danger.utils.diff
