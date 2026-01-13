#!/usr/bin/env python3
"""
Skill Content Population Script
Populates all 116 skill template files with detailed content from the master content documents.

Usage:
    python3 populate-skills.py --content-dir /path/to/content --skills-dir /path/to/skills

The script reads content files and matches SKILL_ID markers to populate the correct files.

Ownership Pattern:
    - Each skill has a single 'owner' (primary responsible agent)
    - Cross-cutting skills list 'collaborators' who may invoke the skill
    - collaboration_rules explain when/why other agents invoke the skill
"""

import os
import re
import sys
import argparse
from pathlib import Path
from typing import Dict, List, Tuple, Optional

# Skill ID to path mapping
SKILL_PATHS = {
    # Orchestrator (8 skills)
    "ORCH-001": "skills/orchestration/workflow-management/SKILL.md",
    "ORCH-002": "skills/orchestration/task-decomposition/SKILL.md",
    "ORCH-003": "skills/orchestration/progress-tracking/SKILL.md",
    "ORCH-004": "skills/orchestration/gate-validation/SKILL.md",
    "ORCH-005": "skills/orchestration/conflict-resolution/SKILL.md",
    "ORCH-006": "skills/orchestration/priority-management/SKILL.md",
    "ORCH-007": "skills/orchestration/communication-routing/SKILL.md",
    "ORCH-008": "skills/orchestration/risk-assessment/SKILL.md",
    
    # Requirements (10 skills)
    "REQ-001": "skills/requirements/elicitation/SKILL.md",
    "REQ-002": "skills/requirements/user-stories/SKILL.md",
    "REQ-003": "skills/requirements/classification/SKILL.md",
    "REQ-004": "skills/requirements/ambiguity-detection/SKILL.md",
    "REQ-005": "skills/requirements/prioritization/SKILL.md",
    "REQ-006": "skills/requirements/dependency-mapping/SKILL.md",
    "REQ-007": "skills/requirements/change-impact/SKILL.md",
    "REQ-008": "skills/requirements/traceability/SKILL.md",
    "REQ-009": "skills/requirements/acceptance-criteria/SKILL.md",
    "REQ-010": "skills/requirements/nfr-quantification/SKILL.md",
    
    # Architecture (12 skills)
    "ARCH-001": "skills/architecture/architecture-pattern-selection/SKILL.md",
    "ARCH-002": "skills/architecture/technology-evaluation/SKILL.md",
    "ARCH-003": "skills/architecture/database-design/SKILL.md",
    "ARCH-004": "skills/architecture/api-architecture/SKILL.md",
    "ARCH-005": "skills/architecture/infrastructure-design/SKILL.md",
    "ARCH-006": "skills/architecture/security-architecture/SKILL.md",
    "ARCH-007": "skills/architecture/scalability-planning/SKILL.md",
    "ARCH-008": "skills/architecture/integration-architecture/SKILL.md",
    "ARCH-009": "skills/architecture/cost-estimation/SKILL.md",
    "ARCH-010": "skills/architecture/adr-writing/SKILL.md",
    "ARCH-011": "skills/architecture/diagram-generation/SKILL.md",
    "ARCH-012": "skills/architecture/environment-design/SKILL.md",
    
    # Design (10 skills)
    "DES-001": "skills/design/module-design/SKILL.md",
    "DES-002": "skills/design/api-contracts/SKILL.md",
    "DES-003": "skills/design/ui-ux/SKILL.md",
    "DES-004": "skills/design/components/SKILL.md",
    "DES-005": "skills/design/data-flow/SKILL.md",
    "DES-006": "skills/design/error-handling/SKILL.md",
    "DES-007": "skills/design/state-management/SKILL.md",
    "DES-008": "skills/design/integration-design/SKILL.md",
    "DES-009": "skills/design/validation/SKILL.md",
    "DES-010": "skills/design/wireframing/SKILL.md",
    
    # Testing (13 skills)
    "TEST-001": "skills/testing/test-strategy/SKILL.md",
    "TEST-002": "skills/testing/test-case-design/SKILL.md",
    "TEST-003": "skills/testing/test-data/SKILL.md",
    "TEST-004": "skills/testing/coverage-analysis/SKILL.md",
    "TEST-005": "skills/testing/traceability-management/SKILL.md",
    "TEST-006": "skills/testing/impact-analysis/SKILL.md",
    "TEST-007": "skills/testing/prioritization/SKILL.md",
    "TEST-008": "skills/testing/defect-analysis/SKILL.md",
    "TEST-009": "skills/testing/reporting/SKILL.md",
    "TEST-010": "skills/testing/regression-management/SKILL.md",
    "TEST-011": "skills/testing/environment-management/SKILL.md",
    "TEST-012": "skills/testing/performance-test/SKILL.md",
    "TEST-013": "skills/testing/security-test/SKILL.md",
    
    # Development (14 skills)
    "DEV-001": "skills/development/code-implementation/SKILL.md",
    "DEV-002": "skills/development/unit-testing/SKILL.md",
    "DEV-003": "skills/development/api-implementation/SKILL.md",
    "DEV-004": "skills/development/database-integration/SKILL.md",
    "DEV-005": "skills/development/frontend-development/SKILL.md",
    "DEV-006": "skills/development/authentication/SKILL.md",
    "DEV-007": "skills/development/integration-implementation/SKILL.md",
    "DEV-008": "skills/development/error-handling/SKILL.md",
    "DEV-009": "skills/development/refactoring/SKILL.md",
    "DEV-010": "skills/development/bug-fixing/SKILL.md",
    "DEV-011": "skills/development/code-review/SKILL.md",
    "DEV-012": "skills/development/code-documentation/SKILL.md",
    "DEV-013": "skills/development/migration-writing/SKILL.md",
    "DEV-014": "skills/development/performance-optimization/SKILL.md",
    
    # Security (13 skills)
    "SEC-001": "skills/security/security-architecture-review/SKILL.md",
    "SEC-002": "skills/security/threat-modeling/SKILL.md",
    "SEC-003": "skills/security/vulnerability-scanning/SKILL.md",
    "SEC-004": "skills/security/dependency-auditing/SKILL.md",
    "SEC-005": "skills/security/code-security-review/SKILL.md",
    "SEC-006": "skills/security/authentication-testing/SKILL.md",
    "SEC-007": "skills/security/authorization-testing/SKILL.md",
    "SEC-008": "skills/security/input-validation-testing/SKILL.md",
    "SEC-009": "skills/security/security-configuration/SKILL.md",
    "SEC-010": "skills/security/compliance-checking/SKILL.md",
    "SEC-011": "skills/security/penetration-testing/SKILL.md",
    "SEC-012": "skills/security/security-reporting/SKILL.md",
    "SEC-013": "skills/security/incident-analysis/SKILL.md",
    
    # DevOps (14 skills)
    "OPS-001": "skills/devops/cicd-pipeline/SKILL.md",
    "OPS-002": "skills/devops/containerization/SKILL.md",
    "OPS-003": "skills/devops/infrastructure-as-code/SKILL.md",
    "OPS-004": "skills/devops/deployment-strategy/SKILL.md",
    "OPS-005": "skills/devops/environment-configuration/SKILL.md",
    "OPS-006": "skills/devops/database-operations/SKILL.md",
    "OPS-007": "skills/devops/monitoring-setup/SKILL.md",
    "OPS-008": "skills/devops/log-management/SKILL.md",
    "OPS-009": "skills/devops/auto-scaling/SKILL.md",
    "OPS-010": "skills/devops/load-balancing/SKILL.md",
    "OPS-011": "skills/devops/ssl-management/SKILL.md",
    "OPS-012": "skills/devops/backup-recovery/SKILL.md",
    "OPS-013": "skills/devops/performance-tuning/SKILL.md",
    "OPS-014": "skills/devops/cost-optimization/SKILL.md",
    
    # Documentation (10 skills)
    "DOC-001": "skills/documentation/technical-writing/SKILL.md",
    "DOC-002": "skills/documentation/api-documentation/SKILL.md",
    "DOC-003": "skills/documentation/code-documentation/SKILL.md",
    "DOC-004": "skills/documentation/user-guides/SKILL.md",
    "DOC-005": "skills/documentation/architecture-documentation/SKILL.md",
    "DOC-006": "skills/documentation/runbook-writing/SKILL.md",
    "DOC-007": "skills/documentation/changelog-management/SKILL.md",
    "DOC-008": "skills/documentation/onboarding-documentation/SKILL.md",
    "DOC-009": "skills/documentation/compliance-documentation/SKILL.md",
    "DOC-010": "skills/documentation/diagram-creation/SKILL.md",
    
    # Operations/Monitoring (12 skills)
    "MON-001": "skills/operations/system-monitoring/SKILL.md",
    "MON-002": "skills/operations/alerting-management/SKILL.md",
    "MON-003": "skills/operations/incident-response/SKILL.md",
    "MON-004": "skills/operations/capacity-planning/SKILL.md",
    "MON-005": "skills/operations/sla-management/SKILL.md",
    "MON-006": "skills/operations/security-monitoring/SKILL.md",
    "MON-007": "skills/operations/performance-monitoring/SKILL.md",
    "MON-008": "skills/operations/log-analysis/SKILL.md",
    "MON-009": "skills/operations/availability-management/SKILL.md",
    "MON-010": "skills/operations/change-management/SKILL.md",
    "MON-011": "skills/operations/disaster-recovery/SKILL.md",
    "MON-012": "skills/operations/reporting/SKILL.md",
}

# Skill ID prefix to owner agent mapping
SKILL_OWNERS = {
    "ORCH": "orchestrator",
    "REQ": "requirements",
    "ARCH": "architecture",
    "DES": "design",
    "TEST": "test-manager",
    "DEV": "developer",
    "SEC": "security",
    "OPS": "devops",
    "DOC": "documentation",
    "MON": "operations",
}

# Cross-cutting skills with their collaborators
# Format: skill_id -> (collaborators_list, collaboration_rules)
CROSS_CUTTING_SKILLS = {
    "DEV-011": {
        "collaborators": ["security", "architecture"],
        "collaboration_rules": """  - security-agent: Invokes for security-focused reviews (auth, data handling, input validation)
  - architecture-agent: Invokes for architectural compliance reviews (API design, patterns)"""
    },
    "DEV-012": {
        "collaborators": ["documentation"],
        "collaboration_rules": """  - documentation-agent: Invokes when generating API docs or user guides from code comments"""
    },
    "TEST-005": {
        "collaborators": ["requirements"],
        "collaboration_rules": """  - requirements-agent: Invokes when verifying requirement coverage or updating traceability matrix"""
    },
    "TEST-006": {
        "collaborators": ["requirements", "developer"],
        "collaboration_rules": """  - requirements-agent: Invokes when requirement changes need test impact assessment
  - developer-agent: Invokes when code changes need affected test identification"""
    },
    "SEC-005": {
        "collaborators": ["developer"],
        "collaboration_rules": """  - developer-agent: Invokes for security guidance during implementation of auth/data handling code"""
    },
    "DOC-002": {
        "collaborators": ["developer", "design"],
        "collaboration_rules": """  - developer-agent: Invokes when API implementation needs documentation updates
  - design-agent: Invokes when OpenAPI spec changes require doc regeneration"""
    },
    "ARCH-010": {
        "collaborators": ["developer", "security"],
        "collaboration_rules": """  - developer-agent: Invokes when implementation decisions require ADR documentation
  - security-agent: Invokes when security decisions need formal ADR record"""
    },
    "REQ-007": {
        "collaborators": ["test-manager", "developer"],
        "collaboration_rules": """  - test-manager-agent: Invokes when analyzing test impacts from requirement changes
  - developer-agent: Invokes when estimating code changes needed for requirement modifications"""
    },
}


def get_skill_owner(skill_id: str) -> str:
    """Get the owner agent for a skill based on its ID prefix."""
    prefix = skill_id.split('-')[0]
    return SKILL_OWNERS.get(prefix, "unknown")


def get_skill_collaborators(skill_id: str) -> Tuple[List[str], str]:
    """Get collaborators and collaboration rules for a skill."""
    if skill_id in CROSS_CUTTING_SKILLS:
        info = CROSS_CUTTING_SKILLS[skill_id]
        return info["collaborators"], info["collaboration_rules"]
    return [], ""


def parse_content_files(content_dir: str) -> Dict[str, str]:
    """
    Parse all content files and extract skill content keyed by SKILL_ID.
    """
    skills_content = {}
    content_path = Path(content_dir)
    
    # Find all content files (both patterns)
    content_files = list(content_path.glob("skills-content-*.md"))
    content_files += list(content_path.glob("all-skills-content.md"))
    
    if not content_files:
        print(f"Warning: No content files found in {content_dir}")
        print(f"  Looking for: skills-content-*.md or all-skills-content.md")
        return skills_content
    
    print(f"Found {len(content_files)} content file(s)")
    
    for content_file in content_files:
        print(f"  Processing: {content_file.name}")
        with open(content_file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Split content by SKILL_ID markers
        # Pattern matches: ---\nSKILL_ID: XXX-NNN\n
        skill_blocks = re.split(r'\n---\nSKILL_ID:\s*', content)
        
        for block in skill_blocks[1:]:  # Skip first block (before any SKILL_ID)
            lines = block.split('\n')
            if lines:
                skill_id = lines[0].strip()
                
                # Find the start of actual content (after the SKILL_PATH line and ---)
                content_start = 0
                for i, line in enumerate(lines):
                    if line.strip() == '---' and i > 1:
                        content_start = i + 1
                        break
                
                if content_start > 0:
                    skill_content = '\n'.join(lines[content_start:]).strip()
                    
                    # Clean up: remove any trailing skill markers
                    if '\n---\nSKILL_ID:' in skill_content:
                        skill_content = skill_content.split('\n---\nSKILL_ID:')[0].strip()
                    
                    skills_content[skill_id] = skill_content
                    
    return skills_content


def extract_metadata_from_block(block: str) -> Dict[str, str]:
    """Extract metadata (name, description, etc.) from the block header."""
    metadata = {}
    lines = block.split('\n')

    for line in lines:
        if ':' in line and not line.startswith('#'):
            key, _, value = line.partition(':')
            key = key.strip()
            value = value.strip()
            if key in ['name', 'description', 'skill_id', 'owner', 'agent', 'collaborators',
                       'collaboration_rules', 'project', 'version', 'when_to_use']:
                # Map 'agent' to 'owner' for backward compatibility
                if key == 'agent':
                    metadata['owner'] = value
                else:
                    metadata[key] = value

    return metadata


def generate_skill_file_content(skill_id: str, content: str) -> str:
    """
    Generate the complete SKILL.md file content with proper YAML frontmatter.
    Includes ownership pattern with owner and collaborators fields.

    Uses CROSS_CUTTING_SKILLS config to populate collaborators for known cross-cutting skills.
    """
    # Extract metadata from the content block
    lines = content.split('\n')

    # Try to extract metadata from the beginning of content
    metadata = {}
    content_start = 0
    in_collaboration_rules = False
    collaboration_rules_lines = []

    for i, line in enumerate(lines):
        # Handle multi-line collaboration_rules
        if in_collaboration_rules:
            if line.strip().startswith('-') or line.strip().startswith(' '):
                collaboration_rules_lines.append(line)
                continue
            else:
                in_collaboration_rules = False
                metadata['collaboration_rules'] = '\n'.join(collaboration_rules_lines)

        if line.strip().startswith('name:'):
            metadata['name'] = line.split(':', 1)[1].strip()
        elif line.strip().startswith('description:'):
            metadata['description'] = line.split(':', 1)[1].strip()
        elif line.strip().startswith('skill_id:'):
            metadata['skill_id'] = line.split(':', 1)[1].strip()
        elif line.strip().startswith('owner:'):
            metadata['owner'] = line.split(':', 1)[1].strip()
        elif line.strip().startswith('agent:'):
            # Legacy support: map 'agent' to 'owner'
            metadata['owner'] = line.split(':', 1)[1].strip()
        elif line.strip().startswith('collaborators:'):
            metadata['collaborators'] = line.split(':', 1)[1].strip()
        elif line.strip().startswith('collaboration_rules:'):
            in_collaboration_rules = True
            first_part = line.split(':', 1)[1].strip()
            if first_part:
                collaboration_rules_lines.append(first_part)
        elif line.strip().startswith('when_to_use:'):
            metadata['when_to_use'] = line.split(':', 1)[1].strip()
        elif line.strip().startswith('dependencies:'):
            metadata['dependencies'] = line.split(':', 1)[1].strip()
        elif line.strip().startswith('#') or line.strip().startswith('## '):
            content_start = i
            break

    # Build the actual content (everything from the first header onwards)
    actual_content = '\n'.join(lines[content_start:]).strip()

    # If no actual content found, use the whole thing
    if not actual_content:
        actual_content = content

    # Get owner - use metadata if present, otherwise derive from skill_id
    owner = metadata.get('owner') or get_skill_owner(skill_id)

    # Get collaborators - check metadata first, then CROSS_CUTTING_SKILLS config
    collaborators_str = metadata.get('collaborators', '[]')
    if collaborators_str == '[]' and skill_id in CROSS_CUTTING_SKILLS:
        collaborators, _ = get_skill_collaborators(skill_id)
        collaborators_str = str(collaborators)

    # Generate YAML frontmatter with ownership pattern
    frontmatter = f"""---
name: {metadata.get('name', skill_id.lower())}
description: {metadata.get('description', 'Skill description')}
skill_id: {skill_id}
owner: {owner}
collaborators: {collaborators_str}
project: studyabroad-v1
version: 1.0.0
when_to_use: {metadata.get('when_to_use', 'As needed')}
dependencies: {metadata.get('dependencies', '[]')}
---

"""

    return frontmatter + actual_content


def populate_skill_files(content_dir: str, skills_dir: str, dry_run: bool = False) -> Tuple[int, int, List[str]]:
    """
    Populate skill files with content from the master documents.
    
    Returns: (success_count, skip_count, errors)
    """
    skills_content = parse_content_files(content_dir)
    
    print(f"\nFound content for {len(skills_content)} skills")
    
    success_count = 0
    skip_count = 0
    errors = []
    
    skills_path = Path(skills_dir)
    
    for skill_id, content in skills_content.items():
        if skill_id not in SKILL_PATHS:
            errors.append(f"Unknown skill ID: {skill_id}")
            continue
        
        rel_path = SKILL_PATHS[skill_id]
        full_path = skills_path / rel_path.replace('skills/', '')
        
        # Ensure directory exists
        if not dry_run:
            full_path.parent.mkdir(parents=True, exist_ok=True)
        
        # Generate the file content
        file_content = generate_skill_file_content(skill_id, content)
        
        if dry_run:
            print(f"Would write: {full_path} ({len(file_content)} bytes)")
            success_count += 1
        else:
            try:
                with open(full_path, 'w', encoding='utf-8') as f:
                    f.write(file_content)
                print(f"✓ {skill_id}: {rel_path}")
                success_count += 1
            except Exception as e:
                errors.append(f"Error writing {skill_id}: {e}")
    
    # Report skills without content
    missing = set(SKILL_PATHS.keys()) - set(skills_content.keys())
    if missing:
        print(f"\nSkills without detailed content ({len(missing)}):")
        for skill_id in sorted(missing):
            print(f"  - {skill_id}")
            skip_count += 1
    
    return success_count, skip_count, errors


def create_placeholder_for_missing(skills_dir: str) -> int:
    """Create placeholder files for any skills without content.

    Uses the ownership pattern with owner, collaborators, and collaboration_rules.
    """
    count = 0
    skills_path = Path(skills_dir)

    for skill_id, rel_path in SKILL_PATHS.items():
        full_path = skills_path / rel_path.replace('skills/', '')

        if not full_path.exists():
            full_path.parent.mkdir(parents=True, exist_ok=True)

            # Extract name from path
            name = full_path.parent.name.replace('-', ' ').title()

            # Get ownership information
            owner = get_skill_owner(skill_id)
            collaborators, collaboration_rules = get_skill_collaborators(skill_id)
            collaborators_str = str(collaborators) if collaborators else "[]"

            # Build ownership section content
            if collaborators:
                ownership_section = f"""## Ownership
- **Owner:** {owner}-agent (primary responsibility)
- **Collaborators:** {', '.join(f'{c}-agent' for c in collaborators)}
- **Delegation Rules:**
{collaboration_rules}"""
            else:
                ownership_section = f"""## Ownership
- **Owner:** {owner}-agent (primary responsibility)
- **Collaborators:** None
- **Delegation Rules:** This skill is not typically invoked by other agents."""

            placeholder = f"""---
name: {name}
description: {name} skill for {owner} agent
skill_id: {skill_id}
owner: {owner}
collaborators: {collaborators_str}
project: studyabroad-v1
version: 1.0.0
when_to_use: TBD
dependencies: []
---

# {name}

## Purpose
[To be documented]

{ownership_section}

## When to Use
- [Scenario 1]
- [Scenario 2]

## Prerequisites
- [Prerequisite 1]

## Process

### Step 1: [First Step]
[Description]

### Step 2: [Second Step]
[Description]

## Inputs
| Input | Type | Required | Description |
|-------|------|----------|-------------|
| TBD | TBD | TBD | TBD |

## Outputs
| Output | Type | Description |
|--------|------|-------------|
| TBD | TBD | TBD |

## StudyAbroad-Specific Considerations
- [To be documented]

## Integration Points
- [To be documented]

## Examples
[To be added]

## Validation
- [Validation criteria to be defined]
"""
            with open(full_path, 'w', encoding='utf-8') as f:
                f.write(placeholder)
            print(f"Created placeholder: {skill_id}")
            count += 1

    return count


def verify_ownership_config() -> None:
    """Verify the ownership configuration is complete and consistent."""
    print("\nOwnership Configuration Verification:")
    print("-" * 40)

    # Check all skill prefixes are mapped
    all_prefixes = set(skill_id.split('-')[0] for skill_id in SKILL_PATHS.keys())
    mapped_prefixes = set(SKILL_OWNERS.keys())

    missing_prefixes = all_prefixes - mapped_prefixes
    if missing_prefixes:
        print(f"  ⚠️  Missing owner mapping for prefixes: {missing_prefixes}")
    else:
        print(f"  ✓ All {len(mapped_prefixes)} skill prefixes have owner mappings")

    # Report cross-cutting skills
    print(f"  ✓ {len(CROSS_CUTTING_SKILLS)} cross-cutting skills configured:")
    for skill_id, info in CROSS_CUTTING_SKILLS.items():
        owner = get_skill_owner(skill_id)
        collabs = ', '.join(info['collaborators'])
        print(f"      {skill_id}: {owner} → [{collabs}]")


def main():
    parser = argparse.ArgumentParser(
        description='Populate skill files from master content documents'
    )
    parser.add_argument(
        '--content-dir',
        required=True,
        help='Directory containing skills-content-*.md files'
    )
    parser.add_argument(
        '--skills-dir',
        required=True,
        help='Target directory for skill files (e.g., ~/projects/studyabroad-v1/skills)'
    )
    parser.add_argument(
        '--dry-run',
        action='store_true',
        help='Show what would be done without making changes'
    )
    parser.add_argument(
        '--create-placeholders',
        action='store_true',
        help='Create placeholder files for skills without content'
    )
    parser.add_argument(
        '--verify-ownership',
        action='store_true',
        help='Verify ownership configuration before processing'
    )
    
    args = parser.parse_args()
    
    # Expand paths
    content_dir = os.path.expanduser(args.content_dir)
    skills_dir = os.path.expanduser(args.skills_dir)
    
    # Validate directories
    if not os.path.isdir(content_dir):
        print(f"Error: Content directory not found: {content_dir}")
        sys.exit(1)
    
    if not os.path.isdir(skills_dir):
        if args.dry_run:
            print(f"Warning: Skills directory not found (dry-run): {skills_dir}")
        else:
            print(f"Creating skills directory: {skills_dir}")
            os.makedirs(skills_dir, exist_ok=True)
    
    print("=" * 60)
    print("Skill Content Population Script")
    print("=" * 60)
    print(f"Content directory: {content_dir}")
    print(f"Skills directory:  {skills_dir}")
    print(f"Total skills:      {len(SKILL_PATHS)}")
    print(f"Cross-cutting:     {len(CROSS_CUTTING_SKILLS)}")
    print(f"Dry run:           {args.dry_run}")
    print("=" * 60)

    # Verify ownership configuration if requested
    if args.verify_ownership:
        verify_ownership_config()

    # Populate skills
    success, skipped, errors = populate_skill_files(
        content_dir, 
        skills_dir, 
        dry_run=args.dry_run
    )
    
    # Create placeholders if requested
    placeholders = 0
    if args.create_placeholders and not args.dry_run:
        print("\nCreating placeholder files...")
        placeholders = create_placeholder_for_missing(skills_dir)
    
    # Summary
    print("\n" + "=" * 60)
    print("SUMMARY")
    print("=" * 60)
    print(f"Successfully populated: {success}")
    print(f"Skipped (no content):   {skipped}")
    print(f"Placeholders created:   {placeholders}")
    print(f"Cross-cutting skills:   {len(CROSS_CUTTING_SKILLS)}")
    print(f"Errors:                 {len(errors)}")

    # Ownership summary
    print("\nOwnership Distribution:")
    owner_counts = {}
    for skill_id in SKILL_PATHS.keys():
        owner = get_skill_owner(skill_id)
        owner_counts[owner] = owner_counts.get(owner, 0) + 1
    for owner, count in sorted(owner_counts.items(), key=lambda x: -x[1]):
        print(f"  {owner}: {count} skills")

    if errors:
        print("\nErrors:")
        for error in errors:
            print(f"  - {error}")

    print("=" * 60)

    return 0 if not errors else 1


if __name__ == '__main__':
    sys.exit(main())
