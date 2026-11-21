# Class 0001: Getting Started

**Unit 1: Getting Started** · Week 1 (2026-11-23 to 2026-11-29) · Problem set: [0001](../problem-sets/0001-getting-started.md)

## Readings, in this order

1. **PHP The Right Way, [Getting Started](https://phptherightway.com/#getting_started)**: read all of it. You can skim *macOS Setup* and *Windows Setup*; read *Linux Setup* and *Common Directory Structure* closely.
2. **php.net, [Supported Versions](https://www.php.net/supported-versions.php)**: the whole table. Compare its dates with what PHP The Right Way recommends, and with the term end date in the syllabus.
3. **php.net, [Built-in web server](https://www.php.net/manual/en/features.commandline.webserver.php)**: the whole page, including the note about PHP 8.4.0 and the "router script" examples.
4. **php-pds/skeleton, [README](https://github.com/php-pds/skeleton)**: the *Summary* tables and the sections for `public/`, `src/`, `config/` and `tests/`.
5. **php.net, migration guide for the version you pick**: the *Backward Incompatible Changes* page, either [8.5](https://www.php.net/manual/en/migration85.incompatible.php) or [8.6](https://www.php.net/manual/en/migration86.incompatible.php). Read it after you've answered question 1.

## Guiding questions

Answer them in your head or in `GLOSSARY.md`; they come back in the oral exam.

1. PHP The Right Way says to use 8.5. php.net says 8.6 came out on 2026-11-19. Debian 13 ships 8.4. Codeforces runs 8.1.7. Which one is "right" for your app, and what is the risk of choosing a release that is two days old?
2. What is the difference between *active support* and *security support*? Which one matters for a production app?
3. Why should `config/` sit outside the directory the web server serves? What exactly would a visitor get if it were inside?
4. The built-in server manual warns "It should not be used on a public network." Find two concrete reasons on the same page.
5. What does a router script returning `false` mean to the server? Who serves the file in that case, your PHP or the server?
6. `PATH_INFO`: what is it, and when does the built-in server set it?

## Glossary entries due this week

`document root`, `SAPI`, `CLI`, `router script`, `PATH_INFO`, `active support`, `security support`, `EOL`. Write them in your own words, each with the source where you learned it.
