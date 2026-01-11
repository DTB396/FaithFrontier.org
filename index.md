---
layout: home
title: Faith Frontier
body_class: ff-home
permalink: /
description: "Christian stewardship, neighborly-care, and lawfully managed enterprises—manifesto, pro se case docketing, petitions for relief, essays, and faith-based civic engagement resources."
image: /assets/img/og/faith-frontier-og.jpg
robots: "index,follow"

<a class="skip-link" href="#main">Skip to content</a>

<header class="ff-hero" role="banner">
  <div class="container ff-hero__inner">
    <p class="ff-kicker">Faith Frontier</p>

    <h1 class="ff-title">
      Stewardship, neighborly-care, and lawful civic engagement.
    </h1>

    <p class="ff-lede">
      A sanctuary for Christian stewardship and responsibly managed work—rooted in conscience, transparency,
      and lawful process. Explore the manifesto, essays, and case materials organized for clarity and record integrity.
    </p>

    <nav class="ff-cta" aria-label="Primary">
      <a href="/cases/" class="btn btn-primary">Cases</a>
      <a href="/essays/" class="btn btn-secondary">Essays</a>
      <a href="/contact/" class="btn btn-tertiary">Contact</a>
    </nav>

    <ul class="ff-quicklinks" aria-label="Key documents">
      <li><a href="/faith-frontier-mission-addendum/">Mission Statement</a></li>
      <li aria-hidden="true">·</li>
      <li><a href="/faith-frontier-brand-creed/">Brand Creed</a></li>
    </ul>
  </div>
</header>

<main id="main" class="ff-main" tabindex="-1">
  <section class="ff-section ff-section--banner" aria-label="Conscience and transparency">
    {% include faith-conscience-banner.html %}
  </section>

  <section class="ff-section ff-section--verse" aria-label="Daily verse">
    {% include daily-verse-enhanced.html %}
  </section>

  <section class="ff-section ff-section--featured" aria-label="Featured essays">
    {% include featured-essays.html %}
  </section>

  <section class="ff-section ff-section--map" aria-label="Doctrine and essay map">
    {% include doctrine-essay-map.html %}
  </section>

  <section class="ff-section ff-section--faq" aria-label="Logo FAQ">
    {% include logo-faq.html %}
  </section>

  <section class="ff-section ff-section--listen" aria-label="Listen">
    {% include spotify-player.html %}
  </section>
</main>

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "WebSite",
  "name": "Faith Frontier",
  "url": "{{ site.url }}{{ site.baseurl }}/",
  "description": "{{ page.description | escape }}",
  "inLanguage": "{{ site.lang | default: 'en' }}",
  "publisher": {
    "@type": "Organization",
    "name": "Faith Frontier",
    "url": "{{ site.url }}{{ site.baseurl }}/"
  }
}
</script>
