---
name: ssl-tls-management
description: Manage SSL certificates and TLS configuration
skill_id: OPS-011
owner: devops
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Certificate management, security configuration
dependencies: []
---

## Process
1. Provision certificates (ACM)
2. Configure auto-renewal
3. Set TLS 1.3 minimum
4. Enable HSTS
5. Configure cipher suites

## StudyAbroad-Specific
- ACM certificates for *.studyabroad.com
- HSTS max-age: 1 year
- TLS 1.3 only in production
- Certificate transparency logging