# prompton-home

The public landing page for PromptOn (`prompton.ai`). A single static document — no build
framework, no runtime JS beyond copy-to-clipboard — served by nginx.

- `site/index.html` — the page. Copy and design follow `DESIGN-resend.md` in the main repo
  (`prompton/design/`). Three placeholders are substituted at build time:
  `__APP_URL__` (the app: sign-in), `__HOME_URL__` (this site: `install.sh`) and `__DOCS_URL__` (the docs site).
- `/install.sh` and `/uninstall.sh` redirects (302) to the CLI installer in the [`prompton-cli`](https://github.com/polimo-dev/prompton-cli)
  repository (`raw.githubusercontent.com/polimo-dev/prompton-cli/main/install.sh`); nothing is served from here.
- `/docs/*` redirects to the docs site (`prompton-docs`, docs.prompton.ai).

## Develop

```sh
make serve                              # renders dist/ with production URLs, serves on :8089
APP_URL=http://localhost:4000 make serve
```

## Build the image

```sh
make docker APP_URL=https://app.dev.prompton.ai HOME_URL=https://dev.prompton.ai TAG=prompton-home:dev-local
```

The container listens on 8080 and answers `/health`.

## Deploy

Kubernetes manifests live in the deployment repository (`deployment/macmini/prompton/30-home.yaml`
for dev). Production: same image with the production URLs.

The production image is built by GitHub Actions (`.github/workflows/image.yml`): every push to `main`
and every `v*` tag builds `linux/amd64` + `linux/arm64` with the production URLs and pushes
`ghcr.io/polimo-dev/prompton-home` tagged `sha-<short sha>`, `main`, and the version on tags. Dev
images are built locally, not by CI.

## License

MIT — see [LICENSE](LICENSE). Copyright (c) 2026 Polimo.

**Trademark.** PromptOn is a trademark of Polimo. The license does not grant permission to use the
PromptOn name or logo; forks and derived services must use a different name.
