# Bug Fix Loop

## Bug Description
{{bug_description}}

## Steps to Reproduce
{{reproduction_steps}}

## Expected Behavior
{{expected_behavior}}

## Process
1. Write a failing test that reproduces the bug
2. Run the test - confirm it fails
3. Analyze the failure to identify root cause
4. Implement the fix
5. Run the test - confirm it passes
6. Run full test suite - confirm no regressions
7. Document the fix

## Completion Criteria
- New test reproduces the original bug
- Fix makes the test pass
- All existing tests still pass
- No new issues introduced

When all criteria met, output: <promise>BUG_FIXED</promise>

