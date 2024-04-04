# React App CI/CD Pipeline Using GitHub Actions

### Skills Used: 
GitHub Actions, Docker, Trivy, CodeQL, Terraform, AWS EC2/VPC  

# The pipeline strucutre:

### React Web App: 
it is a simple To-do web app (monolith).

### Enviroments:

Dev (Local) / Staging (EC2) / Production (EC2)

### Branching:

dev branch > feature branches > when complete pull request it triggers ci.yml and code-analysis.yml that builds, test, lints and scan codebase

if both workflows are successful then run cd.yml (deploy) where deploying to a enviroment to test using AWS EC2 (for every Pull REquest created)



 

