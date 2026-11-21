# Backend Dev 101: PHP

**Status:** APPROVED by the student on 2026-11-21.
**Term:** 2026-11-23 to 2027-08-14 (38 weeks).
**Load:** 2 h/day of PHP, 6 days a week: 12 h/week, about 455 h in total. Plus the DSA track in the extra hour on days you can do 3 h.
**Repo:** github.com/TsukiGva2/Backend-Dev-101 (public).

## Mission

You'll pass a mid-level PHP backend interview for a competitive remote job, in Brazil or abroad. "Mid-level" means you can do all of this without help:

- Build an HTTP application in plain PHP, then in a framework, and explain what the framework does for you.
- Explain the engine: types and type juggling, references and copy-on-write, autoloading, errors versus exceptions, and the request lifecycle.
- Work with databases safely and efficiently: PDO, transactions, indexes, and N+1 queries.
- Find and fix the OWASP Top 10 classes of bugs in your own code.
- Test with PHPUnit, run CI on every PR, ship with Docker, and know why each piece exists.
- Defend your design decisions out loud, under questioning.

The gap this course closes: you've written real PHP (`Sac\Runtime`), but you can't yet defend every part of it, and you've never written tests. Every unit ends with an oral exam so the knowledge holds up when you have to explain it, not just type it.

## Units

The units follow [PHP The Right Way](https://phptherightway.com) (last updated 2026-09-30) top to bottom. Week counts are estimates.

| # | Unit | Source | Weeks |
|---|------|--------|-------|
| 1 | Getting Started | [PHPTRW #getting_started](https://phptherightway.com/#getting_started) | 1 |
| 2 | Code Style Guide | [PHPTRW #code_style_guide](https://phptherightway.com/#code_style_guide) | 1 |
| 3 | Language Highlights | [PHPTRW #language_highlights](https://phptherightway.com/#language_highlights) | 3 |
| 4 | Dependency Management | [PHPTRW #dependency_management](https://phptherightway.com/#dependency_management) | 2 |
| — | **Project 1** | | 1 |
| 5 | Coding Practices | [PHPTRW #coding_practices](https://phptherightway.com/#coding_practices) | 3 |
| 6 | Dependency Injection | [PHPTRW #dependency_injection](https://phptherightway.com/#dependency_injection) | 2 |
| 7 | Databases | [PHPTRW #databases](https://phptherightway.com/#databases) | 3 |
| 8 | Templating | [PHPTRW #templating](https://phptherightway.com/#templating) | 1 |
| 9 | **MVC architecture** (added) | see below | 2 |
| — | **Project 2: MVC app** | see below | 2 |
| 10 | Errors and Exceptions | [PHPTRW #errors_and_exceptions](https://phptherightway.com/#errors_and_exceptions) | 1 |
| 11 | Security | [PHPTRW #security](https://phptherightway.com/#security) | 3 |
| 12 | Testing | [PHPTRW #testing](https://phptherightway.com/#testing) | 3 |
| 13 | Servers and Deployment | [PHPTRW #servers_and_deployment](https://phptherightway.com/#servers_and_deployment) | 2 |
| — | **Project 3** | | 1 |
| 14–15 | Virtualization, Caching | [#virtualization](https://phptherightway.com/#virtualization), [#caching](https://phptherightway.com/#caching) | 2 (shared) |
| 16 | Documenting your Code | [PHPTRW #documenting](https://phptherightway.com/#documenting) | 1 |
| 17 | Frameworks | [PHPTRW #frameworks](https://phptherightway.com/#frameworks) (Resources) | 3 |
| — | **Project 4** | | 1 |

**Total: 38 weeks, ending around 2027-08-14, with no buffer.** Documenting as its own unit and a second week for Servers and Deployment each added a week. Unit 13 is split into servers (nginx + PHP-FPM on a VPS or a PaaS) and building and deploying (a deploy pipeline). CI itself already starts in Unit 12, so Unit 13 only adds the CD half. (The first draft said 34 + 2; I added it up wrong.) Any 3-hour days you put in are the only slack. If you fall more than 2 weeks behind, we cut scope together. The end date doesn't move silently.

Welcome, Community and Credits aren't units. From the Resources section, only Frameworks is used, because PHP jobs in Brazil ask for Laravel or Symfony.

### Unit 9: MVC architecture

PHP The Right Way doesn't teach MVC. [Design Patterns](https://phptherightway.com/#design_patterns) just says to pick patterns and links out. So this unit adds:

- Symfony, [Symfony versus Flat PHP](https://symfony.com/doc/current/introduction/from_flat_php_to_symfony.html): turning a flat PHP app into a front controller with controllers and templates, step by step.
- Martin Fowler's catalog of enterprise application patterns: [Front Controller](https://martinfowler.com/eaaCatalog/frontController.html), [Page Controller](https://martinfowler.com/eaaCatalog/pageController.html), [Model View Controller](https://martinfowler.com/eaaCatalog/modelViewController.html), [Table Data Gateway](https://martinfowler.com/eaaCatalog/tableDataGateway.html).
- PHP-FIG [PSR-7](https://www.php-fig.org/psr/psr-7/) and [PSR-15](https://www.php-fig.org/psr/psr-15/): how the ecosystem standardised the request and response objects that hand-rolled MVC apps usually skip.

### Project 2: an MVC app in the reference architecture

The architecture comes from [kerlonfernandes/sistema-agendamento-academia](https://github.com/kerlonfernandes/sistema-agendamento-academia), a gym scheduling system whose author was hired with it. It's used for its **overall architecture only**. Its code has known mistakes; don't copy any of it.

Your app keeps that shape, in a domain you choose (not gym scheduling):

- A single entry point: every request is rewritten to `index.php` (a front controller).
- A route table mapping a path, with parameters, to a controller and action, kept in its own files.
- Controllers that share a base controller, which handles rendering and auth checks.
- Models over PDO, one per table, sharing a generic base model.
- Plain PHP views with reusable partials (head, header, sidebar, footer).
- Session-based login with two roles (user and admin) and a separate admin area.
- Some endpoints that return HTML fragments or JSON for in-page updates.
- One report or export feature.
- Configuration kept out of the code.

What you'll improve on the reference (each point will be graded):

- Composer PSR-4 autoloading, with no `require_once` chains.
- Dependencies passed in, not created with `new` inside constructors (Unit 6).
- Separate `public/` and source directories.
- Every query parameterised.

**Why it comes before Security and Testing:** in Unit 11 your challenge is to break this app (injection, session fixation, CSRF) and fix it. In Unit 12 you add PHPUnit tests and CI to it. You'll defend this project in interviews, so it gets hardened three times.

### Fast-tracking a unit

You can ask to go through any unit faster than its week count. To be allowed, you have to pass everything a normal unit requires, done all at once:

1. **Placement oral exam**, before any class is published: 5 questions from memory, at least 2 of them "why is it designed this way", plus one snippet to read or debug. Any gap means the unit runs at its normal pace, and we don't reopen the question.
2. **The full problem set and its challenge**, with every acceptance check passing. Nothing is skipped or reduced.
3. **The normal end-of-unit oral exam.** It still happens, graded on the same scale.

Weeks you save go into a buffer. They don't make the course end earlier unless we both agree. A unit you fast-tracked and then show gaps in later gets reopened.

## How it works

- **Class** (`classes/`): readings with exact sections, plus guiding questions. Your own notes go in `GLOSSARY.md`.
- **Problem set** (`problem-sets/`): each one adds a step to **your app**, the final project that grows all term. Each exercise has an acceptance check. One exercise revisits an earlier unit. When a unit covers a language feature, you do it by hand first, then with the standard tool (for example, an autoloader written by hand before Composer).
- **Delivery:** one GitHub issue per problem set, one PR per issue. I review the PR with must-fix or suggestion comments, each tied to a reading. It gets merged once every acceptance check passes.
- **From Unit 12 on:** every PR needs PHPUnit tests, and a GitHub Actions workflow runs them.
- **Challenge:** one per problem set. It's hard, it needs digging beyond the readings, and it's graded pass or fail.
- **Oral exam:** at the end of every unit. You get 3 to 5 questions answered from memory, including at least one "why is it designed this way", plus short snippets to read or debug.
- **Projects:** after Units 4, 9, 13 and 17. Each one is a small, complete app built from a brief, separate from your main app, so you have four portfolio pieces besides it. You deliver the code, a README and a live presentation where I question you like an examining panel.

## Grading

| Item | Scale | Weight |
|------|-------|--------|
| Problem sets | A–D | 35% |
| Projects (works / defends design / code quality) | A–D each | 40% |
| Oral exams | A–D | 25% |
| Challenges | pass/fail | separate count |
| Codeforces contest milestone | pass/fail | separate |
| Bonus | points | for citing non-obvious sources: php-src, PHP RFCs, internals list, PHP Internals Book |

Everything is recorded in `GRADES.md`. What you've shown you know goes in `records/`.

## Bibliography

**Required**
- PHP The Right Way: https://phptherightway.com
- PHP manual: https://www.php.net/manual/en/

**Complementary** (used only where PHPTRW is thin or just links out)
- PHP-FIG PSRs: https://www.php-fig.org/psr/
- Composer docs: https://getcomposer.org/doc/
- OWASP Top 10: https://owasp.org/www-project-top-ten/
- PHPUnit docs: https://docs.phpunit.de/en/12.5/
- GitHub Actions docs: https://docs.github.com/en/actions
- PHP supported versions: https://www.php.net/supported-versions.php
- Symfony versus Flat PHP, Fowler's enterprise patterns catalog, PSR-7 and PSR-15 (Unit 9)

**Bonus sources** (citing these earns points)
- php-src: https://github.com/php/php-src
- PHP RFCs: https://wiki.php.net/rfc
- Internals mailing list archive: https://externals.io/
- PHP Internals Book: https://www.phpinternalsbook.com/

## DSA track

This track runs alongside the course and isn't part of the units.

- **When:** the extra hour (30–60 min) on the days you can do 3 h. It never takes time from the 2 h of PHP.
- **How:** solve interview-style DSA problems in PHP and commit each solution under `dsa/`, with a note on its time and space complexity.
- **Evaluation:** I may ask about one of your `dsa/` solutions in any oral exam (explain it, or improve its complexity). It isn't graded A–D. It's tracked as a count in `GRADES.md`.
- **Source:** [Codeforces problemset](https://codeforces.com/problemset). I pick problems through its [public API](https://codeforces.com/apiHelp) by rating and tag, starting around rating 800–1000 and rising as you go. Submit in PHP (Codeforces runs **PHP 8.1.7**, so features from 8.2 and later, such as readonly classes or typed class constants, fail there even though they work locally on 8.4). Commit every solution under `dsa/` too.
- **Contest milestone (challenge, pass/fail):** take part live in a rated Codeforces **Div. 3 or Div. 4** round, submitting in PHP, before Project 2 starts (around week 21, April 2027). These rounds run about once or twice a month, so you have several chances. To pass, you need all three:
  1. You're a rated participant, not virtual or unofficial.
  2. At least 2 problems accepted during the contest.
  3. A post-mortem in `dsa/contests/<contest-id>.md`: what you solved and how, where you lost time, and an accepted upsolve of the first problem you didn't solve.

## Your app (the final project)

**A community harmonica tablature site**, an original site in the same genre as Cifra Club (not a copy of it). Users submit tabs, and the site parses, versions, searches and transposes them between harmonica keys. Seed content: public-domain songs and your own tabs only.

One weak spot to design for on purpose: work too slow for a request (for example songbook PDF export, a moderation queue, notification emails).

**Frontend scope.** This is a backend course, so the frontend is graded only on these points:
- Server-rendered PHP templates (Unit 8).
- Semantic HTML with labelled, accessible forms.
- Every page works without JavaScript.
- Tabs shown in a monospace block.

Visual design isn't graded. Use a ready-made stylesheet: [Pico CSS](https://picocss.com/) (classless) or [Bootstrap](https://getbootstrap.com/). JavaScript is optional; use [htmx](https://htmx.org/) or plain `fetch` only where an in-page update is worth it. No SPA framework. Reference for forms: [MDN web forms](https://developer.mozilla.org/en-US/docs/Learn_web_development/Extensions/Forms).
