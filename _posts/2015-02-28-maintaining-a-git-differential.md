---
layout:   post
title:    "Maintaining a Git Differential"
comments: true
tags:     [git, workflow]
---

Lately, while working on some projects, I came across times when I had to inspect and debug the code *my way*, which means using some debugging utilities and introducing some config changes and additions. 
So, I have been trying to figure out a way to maintain my own setup for working on projects, so that I can pull in changes from remote, work on them and push the relevant stuff upstream, without those modifications (config changes, debugging utilities etc) coming in the way. Also I would like my changes to be version-controlled.

What this turns out in my case is the task of maintaining my own git differential. And here's the way I deal with them.

Let's assume a simple setup in which there is a git remote labelled as origin and a branch on the local system labelled as master.

To begin with, create a new branch from the master branch.

```sh
$ git checkout -b dev
```

Now, make any such changes (commits) which you would not like to introduce to remote in this branch.

To work on the project, you might want to continue with the same branch or create a separate branch altogether. I work on the former in case, I have to 
make a commit or two and/or need to patch the master as soon as I make a commit. In that case, while working on the dev branch, I do

```sh
$ git checkout master
$ git cherry-pick <required-commit-ref>
```

For the uninitiated, cherry-pick copies a commit from one branch to another, which means the new commits has the same content but a new commit ID.

In case, I am doing some work where I am only concerned with moving some commits only after doing a brief work, I first checkout a new branch based on dev

```sh
$ git checkout -b feature-x
```

Let feature-x be the ref of the new branch.
Now when you are done, you would like to do away with those unneeded commits from the dev branch. Worry not. Simply do

```sh
$ git rebase --onto master last-non-required-commit-ref feature-x
```

Slick. Right?

What I have done here is provided the branch (master) which has to become the base of the resultant branch as the first argument to the rebase --onto command. The second command is the initial commit reference (non-inclusive) which I want to be included in the resultant branch. The third command is the commit reference for the last commit required in the resultant branch.

One can see it in action as..

Here's the log of the commits from the feature-x branch. I have aliased git log (basically) as gl on my system.

![git log from feature-x]({{site.baseurl}}assets/git-log-feature-x.png)

Now, the rebase stuff..

![git log from feature-x]({{site.baseurl}}assets/git-rebase-onto.png)

And the final git log!

![git log from feature-x]({{site.baseurl}}assets/git-log-feature-x-final.png)

Note: Doing so may also result in merge conflict, which the rebase process will handle gracefully, but you won't usually encounter them as long as most of your changes are non-intrusive to the regular setup.

Now, you simply have to checkout the master branch and rebase it against the feature branch.

```sh
$ git checkout master
$ git rebase feature-x
```

Also, I do all interations with the remote only from my master branch. So, in case you want to pull in the latest commits into your dev branches, simply do

```sh
$ git checkout master
$ git pull --rebase
```

then,

```sh
$ git checkout <working-branch>
$ git rebase master
```

This would apply the latest changes on the code from master branch, and apply the exclusive commits over them. This has worked fine for me yet :)

This is my personal strategy for maintaining a git differential. If you have something to say or share, please comment below.

Ref:

- <http://pivotallabs.com/git-rebase-onto/?tag=git>
- <http://stackoverflow.com/questions/27566077/maintaining-a-personal-differential-using-git>
