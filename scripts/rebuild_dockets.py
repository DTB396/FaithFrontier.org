"""Rebuild case docket files and fill missing case artifacts.

Usage:
    python scripts/rebuild_dockets.py

Dependencies:
    - Python 3.10+
    - pyyaml (install with: pip install pyyaml)

This script scans the repository's cases/ directory, creates missing case
artifacts, rebuilds docket.yaml entries from filings/, and writes a summary
report at the repository root.
"""

# NOTE: If the project uses a static-site generator, adjust the front-matter
# in index.md below to match the generator's expectations (e.g., Jekyll layout,
# Hugo front matter, etc.).

from __future__ import annotations

import json
import re
import sys
from pathlib import Path
from typing import Any

import yaml

REQUIRED_FILES = ("index.md", "metadata.json", "docket.yaml")
PLACEHOLDER_DESCRIPTION = "Placeholder – replace with actual description"
DEFAULT_STATUS = "pending"


def find_case_dirs(cases_root: Path) -> list[Path]:
    """Return immediate subdirectories under cases/ as case folders."""
    return sorted(
        [path for path in cases_root.iterdir() if path.is_dir()],
        key=lambda path: path.name,
    )


def detect_missing_files(case_dir: Path) -> list[str]:
    """Return a list of missing required files for a case directory."""
    missing: list[str] = []
    for filename in REQUIRED_FILES:
        if not (case_dir / filename).exists():
            missing.append(filename)
    return missing


def ensure_index_md(case_dir: Path, case_id: str) -> None:
    """Create a placeholder index.md if it does not exist."""
    index_path = case_dir / "index.md"
    if index_path.exists():
        return
    index_path.write_text(
        "---\n"
        f'title: "{case_id}"\n'
        "layout: case   # adjust if the site uses a different layout name\n"
        "---\n\n"
        f"# {case_id}\n\n"
        "> TODO: Add a case summary, background, and any introductory text.\n",
        encoding="utf-8",
    )


def ensure_metadata_json(case_dir: Path, case_id: str) -> None:
    """Create a placeholder metadata.json if it does not exist."""
    metadata_path = case_dir / "metadata.json"
    if metadata_path.exists():
        return
    metadata = {
        "case_id": case_id,
        "court": "TODO",
        "parties": "TODO",
        "filing_date": "TODO",
        "status": "TODO",
    }
    metadata_path.write_text(
        json.dumps(metadata, indent=2) + "\n",
        encoding="utf-8",
    )


def parse_date_from_filename(filename: str) -> tuple[str, str | None]:
    """Parse a date from the filename.

    Returns a tuple of (date_value, comment). The comment is provided when the
    date could not be inferred.
    """
    match = re.search(r"\b(\d{4}-\d{2}-\d{2})\b", filename)
    if match:
        return match.group(1), None

    match = re.search(r"\b(\d{6})\b", filename)
    if match:
        yymmdd = match.group(1)
        return f"20{yymmdd[:2]}-{yymmdd[2:4]}-{yymmdd[4:]}", None

    return "UNKNOWN", "Date not found in filename."


def build_docket_entries(case_dir: Path) -> tuple[list[dict[str, Any]], int]:
    """Build docket entries from the filings directory if present."""
    filings_dir = case_dir / "filings"
    entries: list[dict[str, Any]] = []

    if filings_dir.exists() and filings_dir.is_dir():
        filing_paths = sorted(
            [
                path
                for path in filings_dir.iterdir()
                if path.is_file() and not path.name.startswith(".")
            ],
            key=lambda path: path.name,
        )

        for filing_path in filing_paths:
            date_value, comment = parse_date_from_filename(filing_path.name)
            entry: dict[str, Any] = {
                "file": str(Path("filings") / filing_path.name),
                "date": date_value,
                "description": PLACEHOLDER_DESCRIPTION,
                "status": DEFAULT_STATUS,
            }
            if comment:
                entry["comment"] = comment
            entries.append(entry)

        return entries, len(filing_paths)

    entries.append(
        {
            "file": "filings/PLACEHOLDER",
            "date": "UNKNOWN",
            "description": PLACEHOLDER_DESCRIPTION,
            "status": DEFAULT_STATUS,
            "comment": "No filings directory found; placeholder entry created.",
        }
    )
    return entries, 0


def write_docket_yaml(case_dir: Path, entries: list[dict[str, Any]]) -> None:
    """Write docket.yaml with the provided entries."""
    docket_path = case_dir / "docket.yaml"
    with docket_path.open("w", encoding="utf-8") as handle:
        yaml.safe_dump(
            entries,
            handle,
            sort_keys=False,
            allow_unicode=True,
            default_flow_style=False,
        )


def process_case(case_dir: Path) -> dict[str, Any]:
    """Process a case folder and return reporting data."""
    case_id = case_dir.name
    missing_files = detect_missing_files(case_dir)

    ensure_index_md(case_dir, case_id)
    ensure_metadata_json(case_dir, case_id)

    docket_entries, filings_found = build_docket_entries(case_dir)
    write_docket_yaml(case_dir, docket_entries)

    return {
        "case_id": case_id,
        "missing_files": missing_files,
        "filings_found": filings_found,
        "docket_entries_created": len(docket_entries),
    }


def validate_cases(case_dirs: list[Path]) -> list[str]:
    """Return a list of case IDs that fail validation."""
    failures: list[str] = []
    for case_dir in case_dirs:
        missing = detect_missing_files(case_dir)
        if missing:
            failures.append(case_dir.name)
    return failures


def main() -> int:
    repo_root = Path(__file__).resolve().parents[1]
    cases_root = repo_root / "cases"

    if not cases_root.exists():
        print("Error: cases/ directory not found.", file=sys.stderr)
        return 1

    case_dirs = find_case_dirs(cases_root)
    report_data: list[dict[str, Any]] = []
    total_missing_files = 0

    for case_dir in case_dirs:
        case_report = process_case(case_dir)
        report_data.append(case_report)
        total_missing_files += len(case_report["missing_files"])

    report_path = repo_root / "docket_rebuild_report.json"
    report_path.write_text(json.dumps(report_data, indent=2) + "\n", encoding="utf-8")

    print(
        f"Processed {len(case_dirs)} cases – {total_missing_files} missing files fixed"
    )

    failures = validate_cases(case_dirs)
    if failures:
        print("Validation failed for cases:")
        for case_id in failures:
            print(f"- {case_id}")
        return 1

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
