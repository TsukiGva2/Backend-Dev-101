#!/usr/bin/env bash
# Acceptance check for problem set 0001. Start the server first:
#   php -S 127.0.0.1:8000 -t app/public app/public/index.php
set -u
BASE="${BASE:-http://127.0.0.1:8000}"
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
fail=0
pass() { echo "PASS  $1"; }
bad()  { echo "FAIL  $1"; fail=1; }

# expect STATUS PATH [body-must-contain] [body-must-not-contain]
expect() {
  local want="$1" path="$2" has="${3:-}" hasnt="${4:-}" out code body
  out="$(curl -s --path-as-is -w $'\n%{http_code}' "$BASE$path")" || { bad "$path: no response (is the server running?)"; return; }
  code="${out##*$'\n'}"; body="${out%$'\n'*}"
  [[ "$code" == "$want" ]] || { bad "$path: status $code, want $want"; return; }
  [[ -z "$has" || "$body" == *"$has"* ]] || { bad "$path: body lacks '$has'"; return; }
  [[ -z "$hasnt" || "$body" != *"$hasnt"* ]] || { bad "$path: body contains '$hasnt'"; return; }
  pass "$path -> $want"
}

ctype() { curl -s -o /dev/null -w '%{content_type}' "$BASE$1"; }

expect 200 /
[[ "$(ctype /)" == text/html* ]] && pass "/ is text/html" || bad "/ is not text/html"
expect 200 /tabs/oh-susanna oh-susanna
expect 200 '/tabs/oh-susanna?key=C' oh-susanna
expect 200 /tabs/blues-in-a-2 blues-in-a-2
expect 404 /tabs/
expect 404 /tabs/Oh-Susanna
expect 404 /tabs/oh_susanna
expect 404 /tabs/oh-susanna/extra
expect 404 '/tabs/%3Cscript%3E'
expect 404 /no-such-page
expect 404 '/caf%C3%A9' '/café'
expect 404 '/%3Cscript%3Ealert(1)%3C%2Fscript%3E' '&lt;script&gt;alert(1)' '<script>alert(1)'
[[ "$(ctype /no-such-page)" == text/html* ]] && pass "404 page is text/html" || bad "404 page is not text/html"

if [[ -f "$ROOT/app/public/style.css" ]]; then
  body="$(curl -s "$BASE/style.css")"
  [[ "$body" == "$(cat "$ROOT/app/public/style.css")" ]] && pass "/style.css served as-is" || bad "/style.css not served as-is"
  [[ "$(ctype /style.css)" == text/css* ]] && pass "/style.css is text/css" || bad "/style.css is not text/css"
else
  bad "app/public/style.css is missing"
fi

for p in /../config/app.ini /%2e%2e/config/app.ini /config/app.ini /app.ini; do
  [[ "$(curl -s --path-as-is "$BASE$p")" != *do-not-leak* ]] && pass "$p does not leak the secret" || bad "$p LEAKS the secret"
done

[[ $fail -eq 0 ]] && echo "ALL PASS" || { echo "SOME CHECKS FAILED"; exit 1; }
