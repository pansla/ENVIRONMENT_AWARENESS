# Auth And Remotes

Last updated: 2026-06-02

## GitHub auth

GitHub CLI is authenticated in WSL.

Known observed state:

```text
gh auth status: authenticated to github.com as hatikva
Token scopes include repo and workflow
Git operations protocol: https
```

## Organization work

Pansla repositories should use remotes under:

```text
https://github.com/pansla/<repo>.git
```

## Rule

After GitHub org transfers or repo renames:

1. Check `git remote -v`.
2. Update local `origin` if it still points to the old owner.
3. Fetch.
4. Compare local `HEAD` and `origin/main`.
5. Update environment notes if the transfer affected auth or sync.
