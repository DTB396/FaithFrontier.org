# MER-L-002371-25 Case Files

This directory contains all case-related files for MER-L-002371-25.

## Directory Structure

- `filings/` - Court filings and submitted documents
- `docket/` - Alternative location for docket entries (use filings/ as primary)
- `evidence/` - Supporting evidence and exhibits
- `notes/` - Internal case notes and analysis

## Docket Management

All PDFs placed in the `filings/` directory will be automatically indexed by the docket intake system when metadata is added to `_data/docket/mer-l-002371-25.yml`.

## Intake Process

To add new documents:
1. Place PDF in `_inbox/` directory at repository root
2. Name with format: `YYYYMMDD-description.pdf` or `MER-L-002371-25_description.pdf`
3. Run intake script: `node scripts/docket-intake.js`
4. Files will be automatically moved to `filings/` and YAML updated

## Manual Entry

To manually add a docket entry:
1. Copy PDF to `filings/` directory
2. Add entry to `_data/docket/mer-l-002371-25.yml`:

```yaml
- id: YYYY-MM-DD-description
  date: 'YYYY-MM-DD'
  type: Filing|Order|Notice|Brief|Exhibit|Motion|Complaint|Certification
  title: Human-readable title
  file: /cases/mer-l-002371-25/filings/YYYYMMDD-description.pdf
  notes: Optional notes about this filing
```
