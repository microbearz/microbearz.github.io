# Shaoxiong Zhan Personal Website

This is a minimal personal website built with GitHub Pages and Jekyll. It presents technical background, patent portfolio, professional experience, core technology stack, and contact links.

## Local Preview

```bash
bundle install
bundle exec jekyll serve
```

Open the site at:

```text
http://127.0.0.1:4000
```

## Deploy to GitHub Pages

### One-command deploy

If your SSH key or GitHub CLI is already configured, run:

```bash
chmod +x scripts/deploy.sh
./scripts/deploy.sh <username>
```

The script will initialize git, commit the site, push to `<username>.github.io`, and, when GitHub CLI is available, try to enable GitHub Pages automatically.

The site usually becomes available within 1-5 minutes:

```text
https://<username>.github.io
```

### Manual deploy

1. Create a new GitHub repository named:

```text
<username>.github.io
```

2. Initialize the repository and push the site:

```bash
git init
git add .
git commit -m "Create personal website"
git branch -M main
git remote add origin git@github.com:<username>/<username>.github.io.git
git push -u origin main
```

3. Open `Settings -> Pages` in the GitHub repository. Set the source to `Deploy from a branch`, choose the `main` branch, and use `/root` as the publishing directory.

4. Visit:

```text
https://<username>.github.io
```

## Update Contact Links

Contact links are configured in `_config.yml`:

```yaml
author:
  email: "shaoxiong0001@gmail.com"
  github: "https://github.com/your-github"
  linkedin: "https://www.linkedin.com/in/your-linkedin"
```

Before publishing, replace `github` and `linkedin` with your real profile links.
