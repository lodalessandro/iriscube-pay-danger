import Danger

// fileImport: DangerfileExtensions/BaseRule.swift
// fileImport: DangerfileExtensions/PrRule.swift
// fileImport: DangerfileExtensions/RegexRule.swift
// fileImport: DangerfileExtensions/RuleResult.swift
// fileImport: DangerfileExtensions/RuleRunner.swift
// fileImport: DangerfileExtensions/RulesImplementation.swift


let danger = Danger()

let rules: [RuleRunner.RunnableRule] = [.bigPullRequest,
                                        .forceUnwrappedOptional,
                                        .prHasAssignee]
let ruleRunner: RuleRunner = .init()
ruleRunner.runRules(from: rules)
