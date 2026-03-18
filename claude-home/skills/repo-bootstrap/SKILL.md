---
name: repo-bootstrap
description: Inspect a new repository and produce a safe starter plan before making edits.
---

When invoked on a new repository:

1. Detect the main stack, package manager, entry points, and important folders.
2. Find the main run, build, lint, and test commands.
3. Identify env files, config files, CI files, and deployment clues.
4. Summarize architecture in a concise way.
5. End with:
   - Risks
   - Missing secrets or setup blockers
   - Safest next step
