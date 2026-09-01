# Suji website

Main website for [Suji](https://github.com/suji-lang/suji), published at [suji-lang.org](https://suji-lang.org).

## Layout

- `src/` — homepage and the [Suji book](https://github.com/suji-lang/book)
- `infra/` — Terraform for S3, CloudFront, ACM, and DNS

## Local preview

Serve `src/` with any static file server:

```bash
python3 -m http.server --directory src
```

## Deploy

From `infra/`:

```bash
terraform init
terraform apply
```
