# Branching Strategy

## Main Branches

The main repository will always hold two evergreen branches:

- `main` (production)
- `develop` (next release/trunk)

The main branch should be considered `origin/develop` and will be the main branch where the source code always reflects a state with the latest delivered development changes for the next release.

Consider `origin/main` to always represent the latest code deployed to production. During day to day development, you, as a developer, won't interact with this branch.

## Supporting Branches

Supporting branches are used to help in collaboration between team members, to ease tracking of features, and to assist in bug fixing. Unlike the main branches, these branches always have a limited life time and will be removed eventually.

The different types of branches we may use are:

- `Feature branches`
- `Bugfix branches`
- `Hotfix branches`
- `Release branches`
- `Release fix branches`

---

## Working with Feature Branches

Feature branches (or sometimes called topic branches) are used to develop new features for the upcoming or a distant future release. The essence of a feature branch is that it exists as long as the feature is in development, but will eventually be merged back into develop through a pull request.

During the lifespan of the feature development, you should watch the `develop` branch to see if there has been new commits since the feature was branched out. Make sure all changes in `develop` branch are merged into the `feature` branch before merging it back.

Feature branches should never interact directly with `main`.

**Best Practices:**

- May branch off: develop
- Must merge back into: develop
- Branch naming convention: feature/[Issue TrackerId]/[short-description-of-the-task]

**Example:** `feature/PNI-1792/add-users-model`

### One Branch per ticket

- Cut a branch from last develop.
- Do your commits.
- Descriptive commit messages are encouraged.

### One task, One PR, One commit to `develop`

For each ticket you work on, there must be one PR and just one commit that will be eventually be merged into `develop`. Please squash your commits if necessary.

### Create Pull Request

- Test the code.
- Add a quick description to the PR summary.
- Mark your PR to ready for review.
- Make sure all build stages (linters, tests, etc.) are passing in the CI and that there are no conflicts.
- Add any comments if you think some part of the code needs some more explanation.

### Merging Pull Request

After you got the approval, **squash and merge** your pull request to `develop`. The main purpose of squashing instead of merging into develop is to maintain a clean history in the important branches.

---

## Bugfix Branches

Bugfix branches are used to implement bug fixes for upcoming releases. As soon as the fix is complete, it should be merged into `develop` branch.

Best Practices:

- May branch off: develop
- Must merge back into: develop
- Branch naming convention: fix/[Issue TrackerId]/[short-description-of-the-bug]

**Example:** `fix/PNI-1793/fix-users-report`

---

## Hotfix Branches

Hotfix branches are used to quickly patch releases. This is the only branch that should fork directly off of `main`. As soon as the fix is complete, it should be merged into `main` branch, and master should be tagged with an updated version number. A back-merge into `develop` should happen as well.

Best Practices:

- May branch off: master
- Must merge back into: master
- Tag: increment patch number
- Branch naming convention: hotfix/[Issue TrackerId]/[short-description-of-the-bug]

**Example:** `hotfix/PNI-1793/update-modal-styles`

---

## Release Branches

Release branches support preparation of a new production release.

X days before the release, do a code-freeze and cut a release branch from develop `release/[dd-mm-yyyy]`. This branch should only receive fixes for the release raised by QA. No new features are accepted after release branch is cut. A back-merge into `develop` should happen as well.

- May branch off: develop
- Must merge back: master
- Branch naming convention: release/[dd-mm-yyyy]

**Example:** `release/08-10-2022`

---

## Release Fix Branches

Release Fix branches implement fixes raised by QA on release branches that have already been prepared.

- May branch off: release branch
- Must merge back: release branch
- Branch naming convention: fix/[Issue TrackerId]/[short-description-of-the-bug]

**Example:** `fix/PNI-1793/fix-users-report`

Make sure to deploy latest release branch to staging after pushing a release fix branch.

---

## Release to Prod

When QA gives the 👍 to the release branch, it is ready to be deployed to production.

- Open a PR from `release/[dd-mm-yyyy]` to `main`.
- Merge PR to master. **MERGE, DO NOT SQUASH** This way each commit/author is preserved in `main` history so that develop and `main` has not differed in those commits.

Best Practices:

- May branch off: develop
- Must merge back into: master
- Branch naming convention: release/[dd-mm-yyyy]

**Example:** `release/08-10-2022`

---

## Summary

| Supporting Branch Type | May Branch Off | Must Merge Back | Back-merge to Develop |               Tag               |   Merge Type   |                  Branch Naming Convention                  |
| :--------------------: | :------------: | :-------------: | :-------------------: | :-----------------------------: | :------------: | :--------------------------------------------------------: |
|        Feature         |    develop     |     develop     |          ⛔           |               N/A               | Squash & Merge | feature/[Issue Tracker Id]/[short-description-of-the-task] |
|         Bugfix         |    develop     |     develop     |          ⛔           |               N/A               | Squash & Merge |   fix/[Issue Tracker Id]/[short-description-of-the-bug]    |
|         Hotfix         |     master     |     master      |          ✅           |     Increment patch number      |     Merge      |  hotfix/[Issue Tracker Id]/[short-description-of-the-bug]  |
|        Release         |    develop     |     master      |          ✅           | Increment major or minor number |     Merge      |                    release/[dd-mm-yyyy]                    |
|      Release fix       |    release     |     release     |          ⛔           |               N/A               | Squash & Merge |   fix/[Issue Tracker Id]/[short-description-of-the-bug]    |
