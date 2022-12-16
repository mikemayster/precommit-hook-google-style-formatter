#!/usr/bin/env sh

RELEASE=1.15.0
JAR_NAME="google-java-format-${RELEASE}-all-deps.jar"
RELEASES_URL=https://repo1.maven.org/maven2/com/google/googlejavaformat/google-java-format
JAR_URL="${RELEASES_URL}/${RELEASE}/${JAR_NAME}"

CACHE_DIR="$HOME/.cache"
JAR_FILE="$CACHE_DIR/$JAR_NAME"

FORMATER_CONF=formatter.cfg

if [[ ! -f "$JAR_FILE" ]]
then
    mkdir -p "$CACHE_DIR"
    curl -L "$JAR_URL" -o "$JAR_NAME"
fi

changed_java_files=$(git diff --cached --name-only --diff-filter=ACMR | grep ".*java$" || true)
if [[ -n "$changed_java_files" ]]
then
    echo "Reformatting Java files: $changed_java_files"
    if ! java   --add-exports jdk.compiler/com.sun.tools.javac.api=ALL-UNNAMED \
                --add-exports jdk.compiler/com.sun.tools.javac.file=ALL-UNNAMED \
                --add-exports jdk.compiler/com.sun.tools.javac.parser=ALL-UNNAMED \
                --add-exports jdk.compiler/com.sun.tools.javac.tree=ALL-UNNAMED \
                --add-exports jdk.compiler/com.sun.tools.javac.util=ALL-UNNAMED \
                -jar "$JAR_FILE" -c ./$FORMATER_CONF --replace --set-exit-if-changed $changed_java_files
    then
        echo "An error occurred, aborting commit!" >&2
        exit 1
    fi
else
    echo "No Java files changes found."
fi