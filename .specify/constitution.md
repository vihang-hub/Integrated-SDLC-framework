# studyabroad-v2 Constitution

## Mission
Empower students to discover, apply to, and successfully complete study abroad programs through a seamless digital experience.

## Core Principles

### 1. Student-First Design
Every feature must demonstrably improve the student experience across the journey stages: Discovery, Application, Preparation, Abroad, and Return.

### 2. Privacy by Design
- All PII must be encrypted at rest and in transit
- GDPR compliance is mandatory
- Data minimization: collect only what's necessary
- Right to deletion must be implemented

### 3. Accessibility
- WCAG 2.1 AA compliance minimum
- Support for screen readers
- Keyboard navigation for all features

### 4. Security
- OWASP Top 10 vulnerabilities must be addressed
- OAuth2/SSO for authentication
- Regular security audits

### 5. Quality
- 80% minimum test coverage
- All PRs require code review
- No deployment without passing tests

## Non-Negotiables
1. Never store plain-text passwords
2. Never expose PII in logs
3. Never skip security reviews for auth-related changes
4. Always validate external API responses
5. Always have a rollback plan for deployments

## Technology Choices
- Justified by ADRs
- Consider long-term maintenance
- Prefer well-supported libraries

