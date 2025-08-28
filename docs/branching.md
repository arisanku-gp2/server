# Branching and Release Workflow

Default branch for this repository is `development`.
All feature branches should open Pull Requests into `development` and be merged using **Squash and merge**.

## Release process
1. Create a Pull Request from `development` to `main`.
2. On GitHub choose **Rebase and merge** or **Squash and merge**. Do **not** use merge commits and do not fast-forward from the CLI.
3. After merging, run `scripts/release/mark-main.sh` on `main` to add a version marker commit.

## Keeping history visible
After a release do **not** reset or fast-forward `development` to `main`.
If `development` needs the latest changes from `main`, merge `main` into `development` so the network graph shows the branching clearly.

## Manual fallback
If automation fails, create the release PR manually via the GitHub UI:
- Base: `main`
- Compare: `development`
- Merge using **Rebase and merge** or **Squash and merge**

This strategy keeps `main` linear and ensures every release is visible in the network graph.
