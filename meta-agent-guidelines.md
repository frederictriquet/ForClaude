# Meta-Agent Guidelines: Creating Effective AI Agents

## Purpose
This document provides guidelines for creating clear, concise, and effective AI agent definitions. Use these principles when designing new agents to ensure consistency, clarity, and optimal performance.

---

## Core Principles

### 1. Clarity Above All
- **Be explicit**: State exactly what the agent does, not what it might do
- **Avoid ambiguity**: Use precise language that leaves no room for interpretation
- **Single responsibility**: Each agent should have one clear, well-defined purpose
- **Clear boundaries**: Define what the agent does AND what it doesn't do

### 2. Conciseness
- **Get to the point**: The first sentence should clearly state the agent's primary function
- **No fluff**: Avoid marketing language, superlatives, or unnecessary adjectives
- **Bullet points over paragraphs**: Use lists for capabilities and features
- **Length target**: Agent descriptions should be 3-10 sentences for core purpose, plus structured details

### 3. Actionable Definition
- **Verbs matter**: Start with action verbs (Analyze, Build, Optimize, Debug, etc.)
- **Concrete examples**: Include 2-3 specific use cases
- **Clear triggers**: Specify when the agent should be activated
- **Expected outcomes**: Define what success looks like

---

## Agent Definition Structure

### Required Components

```markdown
## Agent Name
[Clear, descriptive name using 1-3 words]

### Purpose
[One sentence describing the primary function]

### Core Capabilities
- [Capability 1: Specific action or skill]
- [Capability 2: Specific action or skill]
- [Capability 3: Specific action or skill]

### When to Use
[2-3 specific scenarios where this agent should be activated]

### Tools Available
[List of tools this agent can use, or "All tools" if applicable]

### Success Criteria
[How to measure if the agent accomplished its task]
```

---

## Writing Guidelines

### DO:
- ✓ Use active voice ("Analyzes code" not "Code is analyzed")
- ✓ Be specific about technologies/frameworks when relevant
- ✓ Include concrete examples in context
- ✓ Define clear activation conditions
- ✓ Specify skill level (beginner-friendly, expert, specialized)
- ✓ Mention any prerequisites or dependencies

### DON'T:
- ✗ Use vague terms like "helps with" or "assists in"
- ✗ Over-promise capabilities
- ✗ Create overlapping agents with similar purposes
- ✗ Use jargon without explanation
- ✗ Make assumptions about user knowledge
- ✗ Include marketing language or hype

---

## Clarity Checklist

Before finalizing an agent definition, verify:

- [ ] Can someone understand the agent's purpose in 10 seconds?
- [ ] Is it clear when to use this agent vs. others?
- [ ] Are all technical terms either common or explained?
- [ ] Could a developer use this without additional context?
- [ ] Is the scope narrow enough to be manageable?
- [ ] Are the capabilities measurable and testable?
- [ ] Is there a clear difference from existing agents?

---

## Example: Good vs. Bad

### ❌ Bad Example
```
Code Helper Agent
This amazing agent helps you with all your coding needs! It's super
powerful and can do lots of things to make your code better. Use it
whenever you need coding assistance.
```
**Problems:** Vague, no specific purpose, overpromises, no clear activation

### ✅ Good Example
```
Performance Profiler Agent

Purpose: Identifies and resolves performance bottlenecks in applications
through systematic analysis and optimization.

Core Capabilities:
- Profile runtime execution and memory usage
- Analyze database query performance
- Identify inefficient algorithms and data structures
- Recommend specific optimizations with benchmarks

When to Use:
- Application response time exceeds acceptable thresholds
- Memory usage grows unexpectedly
- User reports of slow features or operations

Tools: All tools (profiling, code analysis, benchmarking)

Success Criteria:
- Bottlenecks identified with supporting metrics
- Optimization recommendations provided with expected impact
- Performance improvement measurable through benchmarks
```

---

## Common Patterns

### Specialist Agents
- **Focus**: One technology, framework, or domain
- **Depth**: Deep expertise in narrow area
- **Example**: "Redis Caching Specialist", "OAuth2 Security Expert"

### Task-Based Agents
- **Focus**: One type of operation across technologies
- **Breadth**: Works with multiple languages/frameworks
- **Example**: "API Documentation Generator", "Test Coverage Analyzer"

### Lifecycle Agents
- **Focus**: One phase of development
- **Scope**: Multiple activities within that phase
- **Example**: "Deployment Orchestrator", "Debug Session Manager"

---

## Versioning and Evolution

### When to Update an Agent:
- Technology stack changes significantly
- User feedback indicates confusion
- Success rate drops below acceptable threshold
- New tools become available that enhance capabilities

### When to Create a New Agent:
- Scope creeps beyond single responsibility
- User needs don't fit existing agent categories
- Technology requires specialized knowledge
- Workflow differs significantly from existing agents

---

## Quality Metrics

Track these metrics for each agent:

1. **Activation Rate**: How often is the agent selected?
2. **Success Rate**: How often does it complete tasks successfully?
3. **Clarity Score**: User confusion or misuse incidents
4. **Efficiency**: Average time to task completion
5. **User Satisfaction**: Direct feedback quality

---

## Template for New Agents

```markdown
# [Agent Name]

## One-Line Purpose
[Single sentence: What does this agent do?]

## Detailed Description
[2-3 sentences: Why does this agent exist? What problem does it solve?]

## Core Capabilities
- [Specific capability 1 with context]
- [Specific capability 2 with context]
- [Specific capability 3 with context]
- [Additional capabilities as needed]

## Activation Triggers
Use this agent when:
1. [Specific scenario 1]
2. [Specific scenario 2]
3. [Specific scenario 3]

## Tools Available
[List specific tools or "All tools"]

## Prerequisites
[Any required knowledge, setup, or dependencies]

## Example Interactions
**Scenario 1:**
- User Request: "[Example request]"
- Agent Action: "[What the agent does]"
- Expected Output: "[What the user receives]"

## Success Metrics
- [Measurable outcome 1]
- [Measurable outcome 2]
- [Measurable outcome 3]

## Limitations
- [What this agent doesn't do]
- [Edge cases or constraints]
- [When to use a different agent]

## Related Agents
- [Similar agent 1]: Use instead when [condition]
- [Complementary agent 2]: Use together for [scenario]
```

---

## Final Notes

**Remember**: An agent is only as good as its definition. Invest time in crafting clear, concise descriptions that enable both the AI and users to understand exactly what the agent does and when to use it.

**The test**: If you can't explain the agent's purpose in one sentence, the agent needs refinement.

**Iterate**: Agent definitions should evolve based on usage patterns and feedback. Review and update regularly.
