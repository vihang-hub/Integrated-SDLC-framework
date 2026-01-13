---
name: database-operations
description: Manage database migrations, backups, and maintenance
skill_id: OPS-006
owner: devops
collaborators: []
project: studyabroad-v1
version: 1.0.0
when_to_use: Schema changes, data operations, maintenance
dependencies: []
---

## Process
1. Write migrations with Prisma
2. Test migrations in staging first
3. Run migrations in deployment pipeline
4. Configure automated backups
5. Plan point-in-time recovery

## StudyAbroad-Specific
- Daily RDS snapshots (7-day retention)
- Cross-region backup for DR
- Maintenance windows (Sunday 3-4 AM)
- Connection pooling with PgBouncer