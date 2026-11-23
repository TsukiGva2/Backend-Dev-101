# Problem set 0001: Getting Started

**Due:** 2026-11-29 · **Class:** [0001](../classes/0001-getting-started.md) · **Deliver:** one PR from branch `ps-0001` that closes the issue.

Your app lives in `app/` in this repo. This problem set creates it.

## Exercise 1: choose and install your PHP version

Pick a PHP branch that is still in **active support** on 2027-08-14 (the term end date) and install it with the method from PHP The Right Way's *Linux Setup*. Keep Debian's 8.4 if you like, but the app runs on your choice.

In `app/README.md`, add a **PHP version** section: the branch you picked and why (cite the Supported Versions page), plus **three** backward-incompatible changes from that version's migration guide that could affect you, each in one sentence. "Affect you" means code you've already written (for example `Sac\Runtime`) or code the syllabus says this app will have. Name the concrete thing each change would hit.

**Acceptance:**
- `php -r 'echo PHP_MAJOR_VERSION, ".", PHP_MINOR_VERSION, PHP_EOL;'` prints the branch named in `app/README.md`.
- That branch's *Active Support Until* date on php.net is after 2027-08-14.

## Exercise 2: directory skeleton

Create the app skeleton following pds/skeleton: `app/public/` (document root), `app/src/`, `app/config/`, `app/tests/`. Git doesn't track empty directories, so decide how to keep them, and be ready to explain your choice.

Put one file in `app/config/` called `app.ini` with a fake secret in it (for example `secret = "do-not-leak"`). Exercise 3 checks that it can't be reached over HTTP.

**Acceptance:** `ls app` shows `README.md config public src tests`.

## Exercise 3: a front controller on the built-in server, by hand

No framework, no Composer, no libraries. Write `app/public/index.php` so that the built-in server, started **with it as the router script**:

```
php -S 127.0.0.1:8000 -t app/public app/public/index.php
```

behaves like this:

| Request | Response |
|---------|----------|
| `GET /` | `200`, an HTML home page for your harmonica tab site |
| `GET /tabs/{slug}`, where slug matches `[a-z0-9-]+` | `200`, an HTML page that shows the slug |
| `GET /tabs/{anything else}` | `404` |
| any existing file in `app/public/` (for example `style.css`) | the file itself, served by the built-in server, not read by your PHP |
| anything else | `404`, with your own HTML 404 page that shows the requested path, URL-decoded (`/caf%C3%A9` shows `/café`) |
| anything that would reach `app/config/app.ini` | never shows the secret |

Every value from the URL that you put into HTML goes through [`htmlspecialchars`](https://www.php.net/manual/en/function.htmlspecialchars.php). Status codes are set with [`http_response_code`](https://www.php.net/manual/en/function.http-response-code.php).

**Acceptance:** with the server running, `bash problem-sets/checks/0001.sh` prints `ALL PASS`.

## Revisiting an earlier unit

None this time: this is the first unit.

---

## Challenge 0001: what the built-in server really does (pass/fail)

The manual describes how the built-in server maps a URI to a file **without** a router script. That description is incomplete, and some of what it says isn't what the server does.

Create `challenges/0001/public/` with exactly this content: `index.php` (prints `$_SERVER['SCRIPT_NAME']` and `$_SERVER['PATH_INFO']`, or `(unset)` when it isn't set), `style.css`, and an empty subdirectory `tabs/` (with whatever placeholder you need to commit it, as long as it's not named `index.*`).

Start the server with `-t challenges/0001/public` and **no router script**. For each URI below, find the status code, which file runs or is served, `SCRIPT_NAME` and `PATH_INFO`:

```
/
/tabs/
/tabs/oh-susanna
/tabs/oh-susanna.txt
/index.php/tabs/x
/style.css
/style.css/x
/missing.css
```

**Deliver** `challenges/0001/README.md` with:
1. The table, plus `challenges/0001/run.sh`, which starts the server, requests every URI and prints the table.
2. For every row where the manual's description doesn't predict the result, an explanation of **why**, citing the php-src function responsible, with a link to it at a specific commit (a permalink, not `master`).
3. Which rows would have been different on PHP 8.3, and why.

**Acceptance (strict):**
- `run.sh` output matches your table exactly on your PHP version.
- Explanations cite the right php-src code.
- At review time, I'll give you **3 new URIs**. You predict each one in a PR comment *before* running it, and all 3 predictions must be right.

**Bonus:** cite the specific php-src commit or PR that introduced the PHP 8.4 behaviour change. A php-src citation alone is required, so it doesn't earn points.
