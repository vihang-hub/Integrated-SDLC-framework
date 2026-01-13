#!/bin/bash
# Verify SDLC Framework Setup

echo "========================================"
echo "SDLC Framework Setup Verification"
echo "========================================"

errors=0

# Check directories
echo ""
echo "1. Checking directories..."
dirs=(".specify" ".bmad" ".ralph" ".sdlc" "agents" "skills" "docs" "config")
for dir in "${dirs[@]}"; do
    if [ -d "$dir" ]; then
        echo "   ✅ $dir exists"
    else
        echo "   ❌ $dir missing"
        ((errors++))
    fi
done

# Check key files
echo ""
echo "2. Checking key files..."
files=("CLAUDE.md" ".specify/constitution.md" "config/spec-kit/workflow.yaml" "config/bmad/agent-mapping.yaml" ".ralph/config.yaml" "config/12-factors/factors.yaml")
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "   ✅ $file exists"
    else
        echo "   ❌ $file missing"
        ((errors++))
    fi
done

# Check agents
echo ""
echo "3. Checking agent definitions..."
agents=("orchestrator" "requirements" "architecture" "design" "test-manager" "developer" "security" "devops" "documentation" "operations")
for agent in "${agents[@]}"; do
    if [ -d "agents/$agent" ]; then
        echo "   ✅ agents/$agent exists"
    else
        echo "   ❌ agents/$agent missing"
        ((errors++))
    fi
done

# Check skills
echo ""
echo "4. Checking skills..."
skill_count=$(find skills -name "SKILL.md" 2>/dev/null | wc -l)
echo "   Found $skill_count skill files"
if [ "$skill_count" -ge 100 ]; then
    echo "   ✅ Skills populated"
else
    echo "   ⚠️  Expected ~116 skills, found $skill_count"
fi

# Summary
echo ""
echo "========================================"
if [ $errors -eq 0 ]; then
    echo "✅ All checks passed!"
else
    echo "❌ Found $errors issues"
fi
echo "========================================"

exit $errors

