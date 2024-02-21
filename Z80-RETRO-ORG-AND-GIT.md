# Z80-Retro Org and Git

[Back](./README.md)

The "Z80-Retro!" project is delivered on GitHub as an open source hardware and
software project.  As development of the project progresses, the various
repositories are updated inside GitHub.  It helps to have a basic understanding
of how to use Git in this context.

## Z80-Retro Organisation

The Z80-Retro Org in Github contains all the repositories (including this one)
that relate to building a "Z80-Retro!" of your own.  In order to maintain some
modicum of sanity there are multiple repositories - each dealing with a
different aspect of the project.  For example, there are hardware repositories
that contain the schematics and PCB KiCAD files etc. and there are software
repositories that contain the firmware, CP/M and other utilities.

In general you will need to clone only a few of these repositories to your host
PC to be productive.  The rest of this page contains some detail on how to
learn more about git, as well some resources on how the "Z80-Retro!" org will
expect collaboration to occur should that be what you want to do.

## Using Git

The sections below cover some of the basics.  For a more detailed introduction
to Git, GitHub and version control systems in general, it is suggested you
review these resources.

### Git SCM:

  - [https://git-scm.com/docs/user-manual](https://git-scm.com/docs/user-manual)
  - [https://git-scm.com/docs/gittutorial](https://git-scm.com/docs/gittutorial)

### GitHub:

  - [https://docs.github.com/en](https://docs.github.com/en)
  - [https://docs.github.com/en/get-started/using-git](https://docs.github.com/en/get-started/using-git)
  - [https://docs.github.com/en/get-started/quickstart/hello-world](https://docs.github.com/en/get-started/quickstart/hello-world)

### John's Basement

- _Video Link: [Git - The Basic Concepts of Repos, Cloning, Pushing, and Pulling](https://youtu.be/EJDd9z3nh3w)_
- _Video Link: [NIU CSCI 340, How to set up SSH & Github](https://youtu.be/CdZa8MzLtjQ)_

In case you are looking to collaborate you need to familiarise yourself with the
pull request work flows in GitHub.  See:

  - [https://docs.github.com/en/get-started/quickstart/github-flow](https://docs.github.com/en/get-started/quickstart/github-flow)
  - [https://docs.github.com/en/get-started/quickstart/fork-a-repo](https://docs.github.com/en/get-started/quickstart/fork-a-repo)

### Deep Dive

If you're looking for a deep dive into Git concepts try:

- _Video Link: [Git For Ages 4 and Up](https://www.youtube.com/watch?v=1ffBJ4sVUb4)_

## Collaboration Using the Fork / Pull Request Workflow

We use the Fork model for dealing with pull requests.  The basic flow is:

1. Fork the repository into your own GitHub account. (you only need to do this
   once)
2. Clone your fork of the repository on to your workstation.
3. Create a branch.
4. Develop and test your changes.  Document anything that's new.  Okay to use
   multiple commits.
5. Raise a pull request against the upstream project.
6. Your pull request should include a written description describing what your
   intentions are and why you made the changes you did.
7. The owner of the upstream project will review your changes, add any comments
   and generally collaborate with you on your pull request.  During this time,
   you might add further commits to your branch and push them up to your fork.
   GitHub will automatically reflect this changes in the pull request so the
   upstream maintainer can see what you've done.
8. At some point, the maintainer will merge your pull request into the main
   branch of the upstream repository.
9. You will need to then rebase your fork main branch to match upstream in
   readiness for future pull requests and to ensure your fork is aligned with
   upstreeam.
