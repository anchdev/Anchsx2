# GitHub Fork Setup Instructions

## Step 1: Create the Fork

1. Go to https://github.com/PCSX2/pcsx2
2. Click the **Fork** button (top-right)
3. Select your account (anchdev)
4. Click **Create fork**

You'll now have: `github.com/anchdev/pcsx2`

## Step 2: Push Your Changes

Once the fork is created, run these commands:

```powershell
cd C:\Users\zolfu\anchsx2\pcsx2

# Verify remote is set correctly
git remote -v

# Push all commits and branches
git push -u origin master
```

## Step 3: Verify on GitHub

Visit https://github.com/anchdev/pcsx2 and verify:
- ✅ 5 commits pushed
- ✅ All files visible
- ✅ GitHub Actions enabled in Settings

## What Gets Built

When you push (or create a tag), GitHub Actions will:
- Build unsigned iOS IPA
- Upload as artifact
- Create releases for tags

### First Build
Just push to see the build in action:
```powershell
git push -u origin master
```

Check the build: https://github.com/anchdev/pcsx2/actions

## Complete!

Once pushed, users can:
1. Download unsigned IPA from Releases
2. Install in LiveContainer
3. Play PS2 games on iOS

---

**Need help with fork creation?** See GitHub's guide:
https://docs.github.com/en/get-started/quickstart/fork-a-repo
