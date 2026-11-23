# Glossary

Written by the student, reviewed by the professor. One entry per term: your own definition, plus the source you learned it from.

## Bikeshed

The Debian equivalent of a PPA (Personal Package Archive). Instalation flow is simple:
- Download the package archive's GPG key
- Add a file in /etc/apt/sources.list.d/ with a `deb` line containing signed-by=`<gpg-key-path>`, also include `arch=amd64`
- Run an apt update to validate the new repository entry
