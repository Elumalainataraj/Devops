# Working model

### Github Project Board

To understand the github project board go through this link.

<https://docs.github.com/en/issues/organizing-your-work-with-project-boards/managing-project-boards/editing-a-project-board>

Understand project boards via youtube videos

<https://www.youtube.com/watch?v=C0RTISXqyAk>

### Start Project

<https://github.com/Vizual-Platform>

- Ask for access for a repo
- Total seat (9)
- All repos are private as of now, will opensource if really required(if we have outside contributors)

### devops repo

<https://github.com/Vizual-Platform/devops>

### Basic Requirements

- Windows/Mac with Docker (either with/without Docker Desktop)
- 8GB RAM with i5/i3 will work but it will be very slow.

### Tools

- Docker
- Kube
- Helm
- kubectl
- Make
- Mongo Compass/others

Required in laptop to work on all these projects under Vizual platform. Add other tools for this project if i miss anything here.

### PR review

- Follow Github process, create a feature branch from `main` branch and create PR against `main` branch.
- Use some reference for the PR, use Labels.
- Keep your stakeholders in update.
- Use reviewers Santhosh/Dinesh/Ranjith/Raghu have access to merge PR.

### Testing

- Testing will happen in local desktop.
- Assume Docker is running and bring the kube cluster
- Tester run few `make` command to bring up the local cluster with other depenenices and test your service , either swagger or equivalent service.
- Update Readme for instructions in same repo.
