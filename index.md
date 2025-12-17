---
layout: default
title: "Faith Frontier"
hide_hero: true
show_breadcrumbs: false
description: "Faith Frontier Ecclesiastical Trust builds a faith-rooted public trust for New Jersey residents, focusing on due process, equity, and restoration."
---

<!-- markdownlint-disable MD033 -->


<section class="hero hero--home hero-home--revival">
  <div class="container hero-grid">
    <div class="hero-main">
      <p class="hero-eyebrow">Faith Frontier Ecclesiastical Trust</p>
      <h1>
        Faith-informed transparency for New Jersey neighbors
      </h1>
      <p class="hero-lead">
        Faith Frontier is a Christian-informed public trust that documents public records, teaches civic literacy, and stewards property initiatives with humility and accountability. We operate within the U.S. Constitution and New Jersey law, treating faith as a guide to conscience—not as extrajudicial authority—so residents can see the record, verify facts, and engage officials with confidence.
      </p>
      <div class="hero-highlights">
        <article class="hero-highlight">
          <span class="hero-highlight__label">Due process clarity</span>
          <p>Plain-language case journals track what has happened in courts, agencies, housing, and everyday disputes so people can follow the record, seek counsel, and rely on lawful procedures.</p>
        </article>
        <article class="hero-highlight">
          <span class="hero-highlight__label">Stewardship with boundaries</span>
          <p>Housing and land efforts are pursued lawfully, respecting zoning, licensing, tax rules, and corporate separateness. Stewardship means caring for neighbors while honoring compliance and proper oversight.</p>
        </article>
        <article class="hero-highlight">
          <span class="hero-highlight__label">Accountability</span>
          <p>Shared documentation, transparent records, and neutral summaries help landlords, contractors, agencies, and neighbors operate with dignity and fairness while inviting lawful oversight.</p>
        </article>
        <article class="hero-highlight">
          <span class="hero-highlight__label">Faith-shaped conscience</span>
          <p>Christian principles—truthfulness, humility, repentance, service—inform conduct and communication. They do not replace legal authority or create parallel courts.</p>
        </article>
      </div>
      <div class="hero-actions hero-actions--centered">
        <a class="btn btn-main" href="{{ '/about/' | relative_url }}">Explore Our Mission</a>
        <a class="btn btn-ghost" href="{{ '/cases/' | relative_url }}">Learn Your Rights</a>
        <a class="btn btn-ghost" href="{{ '/manifesto/' | relative_url }}">Read the Manifesto</a>
      </div>
    </div>

    <div class="hero-side-panel">
      <div class="hero-brand-visual">
        <!-- Placeholder for brand image or motif -->
        <!-- Preload hero visual for faster first-paint, use modern image attributes to reduce layout shift -->
        <link rel="preload" href="/assets/img/faithfrontier-mark.svg" as="image">
        <img src="/assets/img/faithfrontier-mark.svg" alt="Faith Frontier Crest" width="360" height="360" decoding="async" fetchpriority="high" style="max-width: 100%; height: auto; margin-bottom: 1.5rem;" />
      </div>
      <p class="hero-badge">Transparent, lawful, accountable</p>
      <!-- Daily Verse placed in side panel -->
      <div id="daily-verse" class="hero-scripture">
        <span class="dv-text">Loading daily verse…</span>
        <span class="dv-ref"></span>
        <span class="dv-note">Updated daily from Atlantic County, New Jersey</span>
      </div>

      <div class="hero-panel__stat">
        <span class="hero-panel__number">Open record</span>
        <span class="hero-panel__label">Case archives with source links</span>
      </div>
      <div class="hero-panel__stat">
        <span class="hero-panel__number">Guides</span>
        <span class="hero-panel__label">Plain-language civic primers</span>
      </div>
          </div>
        --card-bg: rgba(20,30,50,0.92);

        --shadow: 0 4px 32px rgba(15,23,42,0.22);
        --radius: 16px;
      }
      html { box-sizing: border-box; font-family: 'Inter', system-ui, -apple-system, Segoe UI, Roboto, 'Helvetica Neue', Arial; }
      *, *::before, *::after { box-sizing: inherit; }
      body {
        margin: 0;
        line-height: 1.6;
        -webkit-font-smoothing: antialiased;
        text-rendering: optimizeLegibility;
        color: var(--accent);
        background: var(--color-bg);
      }
      .container {
        max-width: var(--max-width);
        padding: 0 var(--container-pad);
        margin: 0 auto;
        width: 100%;
        box-sizing: border-box;
      }
      h1, h2, h3 {
        color: var(--accent);
        font-family: 'Inter', system-ui, sans-serif;
        font-weight: 700;
        margin-top: 0.5em;
        margin-bottom: 0.3em;
        letter-spacing: -0.01em;
      }
      h1 { font-size: clamp(2.2rem, 5vw, 3.5rem); line-height: 1.08; }
      h2 { font-size: clamp(1.5rem, 3vw, 2.2rem); }
      h3 { font-size: clamp(1.15rem, 2vw, 1.35rem); }
      p {
        margin: .5em 0;
        color: var(--muted);
        max-width: 70ch;
        line-height: 1.8;
        font-size: 1.08rem;
      }
      section {
        padding: clamp(1.5rem, 4vw, 3rem) 0;
      }
      .section-divider {
        margin: 0;
        height: 2px;
        background: rgba(212,165,116,0.08);
        border: none;
      }
      .hero-grid {
        display: grid;
        grid-template-columns: 1.5fr minmax(340px, 1fr);
        gap: var(--gutter);
        align-items: stretch;
        align-content: start;
        min-height: 60vh;
      }
      .hero-main {
        min-width: 0;
        display: flex;
        flex-direction: column;
        justify-content: center;
        gap: 1.5rem;
      }
      .hero-side-panel {
        background: var(--card-bg);
        color: var(--accent);
        display: flex;
        flex-direction: column;
        gap: clamp(1rem, 2vw, 2rem);
        align-items: flex-start;
        border-radius: var(--radius);
        box-shadow: var(--shadow);
        padding: 2.5rem 2rem;
        margin-top: 0;
        min-width: 320px;
        max-width: 480px;
      }
      .hero-highlights {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
        gap: clamp(1rem, 2vw, 2rem);
        margin-top: 1.5rem;
      }
      .hero-highlight {
        background: var(--color-panel);
        color: var(--accent);
        padding: 1.25rem 1rem;
        border-radius: 12px;
        box-shadow: 0 2px 12px rgba(15,23,42,0.18);
        min-height: 180px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        border: 1px solid rgba(212,165,116,0.13);
      }
      .hero-highlight__label {
        color: var(--accent-brass);
        font-size: 0.85rem;
        font-weight: 600;
        letter-spacing: 0.12em;
        text-transform: uppercase;
        margin-bottom: 0.2rem;
      }
      .hero-actions {
        display: flex;
        flex-wrap: wrap;
        gap: 1rem;
        margin-top: 1.5rem;
        justify-content: center;
      }
      .hero-actions .btn {
        min-width: 140px;
        padding: .7rem 1.25rem;
        font-size: 1.1rem;
        border-radius: 8px;
        font-weight: 600;
        background: linear-gradient(90deg, var(--accent-brass), var(--accent-emerald));
        color: #181818;
        border: none;
        box-shadow: 0 2px 12px rgba(212, 165, 116, 0.12);
        transition: background 0.2s, box-shadow 0.2s;
      }
      .hero-actions .btn-ghost {
        background: transparent;
        color: var(--accent-brass);
        border: 1.5px solid var(--accent-brass);
        box-shadow: none;
      }
      .hero-actions .btn:hover, .hero-actions .btn:focus {
        background: linear-gradient(90deg, var(--accent-emerald), var(--accent-brass));
        box-shadow: 0 4px 18px rgba(212, 165, 116, 0.18);
        color: #181818;
      }
      .hero-actions .btn-ghost:hover, .hero-actions .btn-ghost:focus {
        background: var(--accent-brass);
        color: #181818;
        border-color: var(--accent-brass);
      }
      @media (max-width: 900px) {
        .hero-grid { grid-template-columns: 1fr; }
        .hero-side-panel { order: 2; width: 100%; max-width: none; min-width: 0; }
        .hero-actions .btn { flex: 1; }
        .hero-highlights { grid-template-columns: 1fr; }
      }
      img { max-width: 100%; height: auto; display: block; }
      @media (prefers-reduced-motion:reduce){*{animation-duration:0.001ms!important;transition-duration:0.001ms!important}}
    </style>
