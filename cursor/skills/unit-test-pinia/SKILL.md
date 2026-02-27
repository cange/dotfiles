---
name: unit-test-pinia
description: Creates comprehensive Pinia store tests with proper mocks and coverage. Use when writing tests for Pinia stores, or when the user mentions store testing, Pinia testing, or Nuxt store tests.
---

# Pinia Store Testing

Comprehensive Pinia store unit tests in Nuxt 3 applications using Vitest.

Create well-structured test suites that achieve >90% coverage and document
business logic.

Focus on indistinguishable, production-ready tests: follow existing codebase
patterns, avoid unnecessary comments, and verify work by running tests.

## Workflow

1. **Analyze**: Read the store file to identify state, getters, actions, and
   external dependencies (e.g., `useNuxtApp`, other stores).
2. **Plan**: Check `tests/stores/` for existing patterns.
3. **Implement**: Write the test file using the standards below.
4. **Verify**: Run tests with coverage.
5. **Iterate**: If tests fail, diagnose root cause, fix the issue (prefer code
   fixes over weakening tests), and re-run verification.

## Standards

### Setup & Teardown

- **Mandatory**: Use `setActivePinia(createPinia())` in `beforeEach`.
- **Mocks**:
  - Mock `#imports` (for `useNuxtApp`) _only_ if the store or its dependencies
    require it.
  - Stub global `sessionStorage` if used.
  - Ensure `vi.clearAllMocks()` and cleanups run in `beforeEach`/`afterEach`.

### Structure

Organize tests into three strictly named `describe` blocks:

1. `describe("state", ...)`: Initial values.
2. `describe("getters", ...)`: Computed logic.
3. `describe("actions", ...)`: Methods and side effects.

### Naming Convention

- Use **imperative verbs** (e.g., "calculates total", "updates user profile").
- **Forbidden**: "should", "works correctly", or vague descriptions.
- Concise, professional, imperative test titles.

### Implementation Details

- Test behavior, not internal implementation details.
- Access store instances directly (e.g., `store.increment()`).
- Verify side effects (e.g., storage calls, API calls) explicitly.
- Preserve existing functionality; never delete failing tests to pass CI.

## Output Format

- Provide test file paths and full contents for new or updated tests.
- Follow the project's naming conventions (e.g., `tests/stores/*.test.ts`).
- If tests were executed, report the exact command and outcome.

## Completion Criteria

- All tests pass (`pnpm test`, `npm test`, or `vitest` exits 0).
- Coverage meets the >90% threshold.
- No tests were deleted to achieve passing status.
