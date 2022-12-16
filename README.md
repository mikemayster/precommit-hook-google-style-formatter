# precommit-hook-google-style-formatter

A git pre-commit hook script for formatting the Java source files according to Google Java Style Guide

The script will download (and cache) the Jar from https://github.com/google/google-java-format
and try to re-format all changed `.java` files in the repository. If any re-formatting did occur,
the commit will be aborted, so that you can incorporate formatting fixes.

Usage:

```
repos:
- repo: https://github.com/mikemayster/precommit-hook-google-style-formatter
  sha: b7e9e7fcba4a5aea463e72fe9964c14877bd8130
    hooks:
      - id: google-style-java
```

# License

The script is licensed under Apache License, Version 2.0.
