#!/usr/bin/env python3
import logging
import re
from pathlib import Path
from typing import List, Pattern, Iterable

# ---------------------------------------------
# Constants
# ---------------------------------------------
SCRIPT_PATH: Path = Path(__file__).resolve()
PARENT_DIR: Path = SCRIPT_PATH.parent.parent

SRC_ROOT: Path = PARENT_DIR / "app" / "src" / "main"
# SRC_ROOT: Path = PARENT_DIR / "app" / "src" / "main" / "java" / "com" / "foo" / "bar"
OUTPUT_FILE: Path = PARENT_DIR / "_all_kotlin.ai"


def get_exclude_patterns() -> List[Pattern[str]]:
    """Compile regexes for paths to skip."""
    return [
        re.compile(r".*/androidTest/"),
        re.compile(r".*/build/"),
        re.compile(r".*/target/"),
        re.compile(r".*/tests?/"),  # matches `test/` or `tests/`
    ]


def is_excluded(path: Path, patterns: List[Pattern[str]]) -> bool:
    text = str(path)
    return any(p.search(text) for p in patterns)


def should_include_file(path: Path, excludes: List[Pattern[str]]) -> bool:
    """
    Decide if a given .kt file should be included:
      - must not live under an excluded dir
      - name must not start with `test_` or end with `_test.kt`
    """
    if is_excluded(path, excludes):
        return False
    name = path.name
    if name.startswith("test_") or name.endswith("_test.kt"):
        return False
    return True


def find_kotlin_files(src_root: Path, excludes: List[Pattern[str]]) -> List[Path]:
    """Recursively find all .kt files under src_root that pass our filters."""
    return sorted(
        p for p in src_root.rglob("*.kt")
        if should_include_file(p, excludes)
    )


def get_line_filters() -> List[Pattern[str]]:
    """Compile regexes for filtering out unwanted lines."""
    return [
        re.compile(r"^\s*//+"),  # comments
        re.compile(r"^\s*import\b"),  # import statements
        re.compile(r"^\s*package\b"),  # package declarations
        re.compile(r"^\s*$"),  # blank lines
    ]


def filter_file_lines(
        path: Path,
        filters: List[Pattern[str]]
) -> Iterable[str]:
    """
    Yield lines from `path` that do NOT match any of the given filters.
    """
    for line in path.read_text(encoding="utf-8").splitlines(keepends=True):
        if any(f.match(line) for f in filters):
            continue
        yield line


def write_concatenated_file(
        files: List[Path],
        output_path: Path,
        base_dir: Path
) -> None:
    """
    Write headers and filtered contents of each file into output_path.
    """
    # remove old file
    try:
        output_path.unlink()
    except FileNotFoundError:
        pass

    filters = get_line_filters()

    with output_path.open("w", encoding="utf-8") as out:
        for kt in files:
            rel = kt.relative_to(base_dir)
            out.write(f"\n\n// ===== FILE: {rel} =====\n")
            for line in filter_file_lines(kt, filters):
                out.write(line)

    logging.info("Wrote all Kotlin files to: %s", output_path)


def main() -> None:
    logging.basicConfig(level=logging.INFO, format="%(message)s")

    excludes = get_exclude_patterns()
    kt_files = find_kotlin_files(SRC_ROOT, excludes)

    if not kt_files:
        logging.warning("No Kotlin files found under %s", SRC_ROOT)
        return

    write_concatenated_file(kt_files, OUTPUT_FILE, PARENT_DIR)


if __name__ == "__main__":
    main()
