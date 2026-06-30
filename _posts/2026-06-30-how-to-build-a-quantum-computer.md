---
layout: distill
title: "How to build a quantum computer: five ways to make a qubit"
description: "There is no single best way to build a qubit — only five very different bets, each acing part of the same scorecard and flunking the rest; here is the map that ties the whole series together."
date: 2026-06-30
tags: quantum overview
categories: physical-layer
giscus_comments: false
related_posts: true
bibliography: quantum_computing_101.bib
authors:
  - name: Xuchuang Wang
    url: "/"
    affiliations:
      name: HKBU
toc:
  - name: What makes a good qubit
  - name: Five ways to make a qubit
  - name: The scorecard
  - name: "Why there's no winner yet"
  - name: Outlook
---

Every few months a headline announces that *the* quantum computer has arrived — a new chip, a new record, a new superlative. It is almost always built on one particular kind of qubit, and almost never says so. That omission is the single most misleading thing about how quantum computing is reported, because the most important fact in the whole field is that **there is no winning qubit.** There are five serious ways to build one, each a wildly different physical object — a printed circuit, a levitating atom, a thousand atoms in a web of light, a flying photon, a flaw in a diamond — and each one aces part of the same test while flunking the rest. This post is the map to that test and those five answers. It is the entry point to a six-part series that takes each route apart in turn; if you read only one piece, read this one, then follow the route that intrigues you. Let us start where every honest comparison has to start: with the scorecard itself.

## What makes a good qubit

Before you can argue about *which* qubit is best, you need to agree on what "good" even means — and remarkably, the field does. In 2000, David DiVincenzo wrote down a checklist so durable that twenty-five years later every platform is still graded against it <d-cite key="divincenzo2000criteria"></d-cite>. The **DiVincenzo criteria** are five requirements a system must meet to compute, plus two more it needs to *network*. They are worth stating plainly, because the rest of this series is, at bottom, a report card filled out against them.

The five computing criteria:

1. **Well-defined qubits, and a way to scale them.** You need a genuine two-level system — a clean $\vert 0\rangle$ and $\vert 1\rangle$ — and a path to having *many* of them, not just two. "Well-defined" is doing real work here: a harmonic oscillator, with its evenly spaced ladder of levels, is *not* a good qubit, because a pulse that drives $\vert 0\rangle\to\vert 1\rangle$ also drives $\vert 1\rangle\to\vert 2\rangle$ and the state leaks upward. Every platform's first job is to isolate two levels and keep the rest out of the way.
2. **Initialization.** You must be able to reliably set the qubits to a known starting state, the quantum equivalent of clearing the register to all zeros.
3. **Long coherence.** The qubit must hold its quantum state — its delicate phase relationships — far longer than it takes to do a gate. Coherence is the clock you are racing; everything else is how fast you can run before it runs out.
4. **A universal gate set.** You need a small repertoire of operations — some single-qubit rotations plus one genuine two-qubit entangling gate — from which any computation can be assembled. The two-qubit gate is almost always the hard part.
5. **Measurement.** You must be able to read out each qubit's state at the end, turning quantum amplitudes back into classical bits.

And the two **networking** criteria, which the same paper lists and which matter enormously to anyone building a quantum *internet* rather than a single isolated machine:

6. **Flying qubits.** The ability to convert a stationary, computing qubit into a *moving* one — almost always a photon — that can carry the quantum state somewhere else.
7. **Faithful interconversion.** The ability to transmit those flying qubits between distant nodes and convert them back, reliably, so two separated machines can share entanglement.

Those last two are the backbone of the quantum-internet vision <d-cite key="wehner2018internet"></d-cite>, and they are exactly where the five platforms diverge most sharply. A qubit can be a superb *computer* and a hopeless *node*, or the reverse. So the scorecard has seven boxes, and — this is the punchline of the entire series — **no platform ticks all seven.** The criteria pull against each other: the very design choice that buys you long coherence often costs you gate speed, and the thing that makes a qubit easy to mass-produce often makes it impossible to network. Hold that tension; it is the reason there are five posts after this one and not a single coronation. Let us meet the contenders.

## Five ways to make a qubit

Here is each route in a paragraph — a fair, fast sketch, with a link to the full deep-dive. Read these as five characters who will reappear, with all their virtues and vices, in the scorecard below.

**Superconducting qubits — the fast front-runner.** Instead of catching a real atom, you *build* one: pattern a little circuit onto a wafer, add a Josephson junction to make its energy ladder uneven, cool it to about 10 millikelvin, and it starts behaving like an atom with discrete levels. This is the route Google and IBM bet on, and it leads on speed and engineering momentum — gate times of tens of nanoseconds <d-cite key="google2023surface"></d-cite> and the splashiest milestones, including error correction pushed below threshold on Google's Willow chip <d-cite key="google2024willow"></d-cite>. It pays for that lead in cryogenics, short coherence, and a weakness at networking. [Read the deep-dive →](/blog/2026/superconducting-qubits/)

**Trapped-ion qubits — the precision instrument.** Strip one electron off an atom and hold the resulting ion in vacuum on oscillating electric fields. Now the qubit is a *real* atom — every ion of a given isotope identical to every other, no fabrication spread — and you talk to it with lasers or microwaves. Ions hold the field's best fidelities <d-cite key="quantinuum2025helios"></d-cite>, coherence measured in *minutes* <d-cite key="wang2017tenminute"></d-cite>, and all-to-all connectivity. The bill: gates a thousand times slower than superconducting, and the difficulty of herding more than a hundred atoms into one trap. [Read the deep-dive →](/blog/2026/trapped-ion-qubits/)

**Neutral-atom qubits — the scaling contender.** Don't strip the electron at all; pinch a *neutral* atom in a tightly focused laser beam, an "optical tweezer," and split one laser into thousands of those traps at once. The atoms are identical and the array is reconfigurable — you can physically shuttle qubits around mid-computation — and you entangle two of them by briefly inflating them into giant Rydberg states that shove each other <d-cite key="saffman2010rydberg"></d-cite>. This route now leads on raw qubit count <d-cite key="manetsch2025tweezer"></d-cite> and on error-corrected *logical* qubits <d-cite key="bluvstein2025faulttolerant"></d-cite>, trading top-end per-qubit quality for sheer numbers. [Read the deep-dive →](/blog/2026/neutral-atom-qubits/)

**Photonic qubits — the flying messenger.** Write the qubit on a single particle of light. It cannot be trapped or cooled — it travels at the speed of light by nature — which makes it the worst at *sitting still to compute* and the best at *going places*. Because photons barely interact, you cannot build a normal two-qubit gate from mirrors; instead photonics computes by *measurement*, building a big entangled state and consuming it <d-cite key="raussendorf2001oneway"></d-cite>, or stitching small resource states together with probabilistic fusions <d-cite key="bartolucci2023fusion"></d-cite>. Universal photonic machines are still tiny, but the photon is the consensus best network *wire*. [Read the deep-dive →](/blog/2026/photonic-qubits/)

**Other platforms — silicon spins, diamond defects, and a qubit that may not exist.** Off the main highways runs a scrappier crowd, each betting on a single breakthrough the front-runners cannot reach. **Semiconductor spin qubits** store the bit in a single electron's spin in silicon and could, in principle, be mass-produced on the same CMOS lines that print your phone <d-cite key="intel2023tunnelfalls"></d-cite>, with fidelities now reaching the best ion numbers <d-cite key="sqc2025elevenqubit"></d-cite>. **Color centers in diamond** (NV and SiV) are room-temperature spins that emit entangled photons, making them natural network nodes — Delft used them for the first loophole-free Bell test <d-cite key="hensen2015loopholefree"></d-cite>. And **topological qubits** make the most radical bet — error protection built into the hardware — but remain, after a retracted flagship paper and live disputes, unproven <d-cite key="microsoft2025parity"></d-cite><d-cite key="legg2025comment"></d-cite>. [Read the deep-dive →](/blog/2026/other-qubit-platforms/)

## The scorecard

Now lay them side by side. The figure below is the single most useful picture in this series, because it makes the central trade-off visible at a glance. It plots each platform on two of the DiVincenzo criteria at once: **how fast its gates run** (horizontal) against **how long its qubits stay coherent** (vertical), both on a roughly logarithmic scale.

<figure class="l-body" style="text-align:center; margin:1.5rem auto; max-width:760px;">
  <svg viewBox="0 0 760 560" role="img" aria-label="A scatter plot of quantum-computing platforms positioned by gate speed on the horizontal axis (faster to the right) and coherence time on the vertical axis (longer toward the top), both logarithmic. Superconducting qubits sit at the bottom right: very fast gates, about thirty nanoseconds, but short coherence near a third of a millisecond. Silicon spin qubits sit just above and left of superconducting: fast gates, millisecond-to-second coherence. Neutral atoms sit upper-middle-left: slow gates around a few hundred nanoseconds, coherence near ten seconds. Trapped ions sit top left: the slowest gates, about a microsecond, but the longest coherence, minutes. A faint diagonal band runs from the fast-short corner to the slow-long corner, labelled the central trade-off. The top-right corner, fast and long-lived, is marked as the empty ideal that no platform reaches. A separate note at the bottom explains that photonic qubits sit off this map entirely, because they have no gate clock and are limited by photon loss rather than coherence." style="width:100%; height:auto; font-family:sans-serif;">
    <defs>
      <marker id="hubAx" markerWidth="9" markerHeight="9" refX="4.5" refY="4.5" orient="auto"><path d="M0 0 L9 4.5 L0 9 Z" fill="currentColor"/></marker>
      <marker id="hubTr" markerWidth="9" markerHeight="9" refX="4.5" refY="4.5" orient="auto"><path d="M0 0 L9 4.5 L0 9 Z" fill="currentColor" fill-opacity="0.55"/></marker>
    </defs>
    <!-- gridlines -->
    <line x1="187" y1="70" x2="187" y2="410" stroke="currentColor" stroke-width="1" stroke-dasharray="3 5" opacity="0.16"/>
    <line x1="443" y1="70" x2="443" y2="410" stroke="currentColor" stroke-width="1" stroke-dasharray="3 5" opacity="0.16"/>
    <line x1="700" y1="70" x2="700" y2="410" stroke="currentColor" stroke-width="1" stroke-dasharray="3 5" opacity="0.16"/>
    <line x1="110" y1="363" x2="700" y2="363" stroke="currentColor" stroke-width="1" stroke-dasharray="3 5" opacity="0.16"/>
    <line x1="110" y1="224" x2="700" y2="224" stroke="currentColor" stroke-width="1" stroke-dasharray="3 5" opacity="0.16"/>
    <line x1="110" y1="141" x2="700" y2="141" stroke="currentColor" stroke-width="1" stroke-dasharray="3 5" opacity="0.16"/>
    <!-- axes -->
    <line x1="110" y1="410" x2="110" y2="58" stroke="currentColor" stroke-width="1.6" marker-end="url(#hubAx)"/>
    <line x1="110" y1="410" x2="714" y2="410" stroke="currentColor" stroke-width="1.6" marker-end="url(#hubAx)"/>
    <!-- axis titles -->
    <text x="34" y="240" fill="currentColor" font-size="14.5" transform="rotate(-90 34 240)" text-anchor="middle" font-weight="600">Coherence time  (longer &#8593;)</text>
    <text x="405" y="447" fill="currentColor" font-size="14.5" text-anchor="middle" font-weight="600">Gate speed  (faster &#8594;)</text>
    <!-- y tick labels -->
    <text x="101" y="414" fill="currentColor" font-size="11.5" text-anchor="end" opacity="0.8">0.1 ms</text>
    <text x="101" y="367" fill="currentColor" font-size="11.5" text-anchor="end" opacity="0.8">1 ms</text>
    <text x="101" y="228" fill="currentColor" font-size="11.5" text-anchor="end" opacity="0.8">1 s</text>
    <text x="101" y="145" fill="currentColor" font-size="11.5" text-anchor="end" opacity="0.8">1 min</text>
    <!-- x tick labels -->
    <text x="187" y="426" fill="currentColor" font-size="11.5" text-anchor="middle" opacity="0.8">~1 &#181;s</text>
    <text x="443" y="426" fill="currentColor" font-size="11.5" text-anchor="middle" opacity="0.8">~100 ns</text>
    <text x="690" y="426" fill="currentColor" font-size="11.5" text-anchor="middle" opacity="0.8">~10 ns</text>
    <!-- central trade-off band -->
    <line x1="560" y1="378" x2="214" y2="110" stroke="currentColor" stroke-width="15" opacity="0.07" stroke-linecap="round"/>
    <line x1="556" y1="375" x2="222" y2="116" stroke="currentColor" stroke-width="1.4" stroke-dasharray="6 5" opacity="0.5" marker-end="url(#hubTr)"/>
    <text x="388" y="232" fill="currentColor" font-size="13" text-anchor="middle" transform="rotate(37.7 388 232)" opacity="0.75" font-style="italic">the central trade-off: speed &#8596; coherence</text>
    <!-- ideal corner -->
    <text x="660" y="92" fill="currentColor" font-size="11.5" text-anchor="end" opacity="0.5" font-style="italic">ideal: fast AND long-lived</text>
    <text x="660" y="108" fill="currentColor" font-size="11.5" text-anchor="end" opacity="0.5" font-style="italic">(nobody here yet)</text>
    <!-- platform: trapped ion -->
    <circle cx="187" cy="94" r="10" fill="#14b8a6" fill-opacity="0.30" stroke="#14b8a6" stroke-width="2.4"/>
    <text x="204" y="90" fill="#14b8a6" font-size="13.5" text-anchor="start" font-weight="600">Trapped ion</text>
    <text x="204" y="106" fill="currentColor" font-size="11" text-anchor="start" opacity="0.8">&#8776;1 &#181;s gate &#183; minutes</text>
    <!-- platform: neutral atom -->
    <circle cx="321" cy="173" r="10" fill="#e0a106" fill-opacity="0.30" stroke="#e0a106" stroke-width="2.4"/>
    <text x="338" y="169" fill="#e0a106" font-size="13.5" text-anchor="start" font-weight="600">Neutral atom</text>
    <text x="338" y="185" fill="currentColor" font-size="11" text-anchor="start" opacity="0.8">hundreds of ns &#183; ~10 s</text>
    <!-- platform: silicon spin -->
    <circle cx="521" cy="363" r="10" fill="#ef4444" fill-opacity="0.30" stroke="#ef4444" stroke-width="2.4"/>
    <text x="533" y="349" fill="#ef4444" font-size="13.5" text-anchor="start" font-weight="600">Spin qubits</text>
    <text x="533" y="365" fill="currentColor" font-size="11" text-anchor="start" opacity="0.8">tens of ns &#183; ms&#8211;s</text>
    <!-- platform: superconducting -->
    <circle cx="578" cy="388" r="10" fill="#4f7cff" fill-opacity="0.30" stroke="#4f7cff" stroke-width="2.4"/>
    <text x="566" y="383" fill="#4f7cff" font-size="13.5" text-anchor="end" font-weight="600">Superconducting</text>
    <text x="566" y="399" fill="currentColor" font-size="11" text-anchor="end" opacity="0.8">~30 ns gate &#183; ~0.3 ms</text>
    <!-- photonic off-map callout -->
    <rect x="110" y="474" width="590" height="62" rx="8" fill="currentColor" fill-opacity="0.04" stroke="currentColor" stroke-width="1.4" stroke-dasharray="6 4" opacity="0.85"/>
    <path d="M132 505 q 9 -11 18 0 q 9 11 18 0 q 9 -11 18 0" fill="none" stroke="currentColor" stroke-width="2"/>
    <text x="196" y="497" fill="currentColor" font-size="12.5" text-anchor="start" font-weight="600">Photonic sits off this map.</text>
    <text x="196" y="514" fill="currentColor" font-size="11.5" text-anchor="start" opacity="0.85">There is no gate "clock" (it computes by measurement) and the limiting</text>
    <text x="196" y="529" fill="currentColor" font-size="11.5" text-anchor="start" opacity="0.85">resource is photon loss, not coherence &#8212; the field's best wire, not a point on this trade-off.</text>
  </svg>
  <figcaption style="margin-top:.5rem;"><b>Figure 1.</b> The central trade-off, drawn. Each platform is placed by gate speed (horizontal, faster to the right) against coherence time (vertical, longer toward the top), both roughly logarithmic; numbers are representative, drawn from this series' deep-dives. Superconducting and silicon spin qubits live at the fast-but-forgetful bottom right; trapped ions and neutral atoms at the slow-but-long-lived top. The faint diagonal is the trade-off itself — the two criteria pull against each other, and the "ideal" top-right corner (fast *and* long-lived) is empty. Photonic qubits do not belong on this plot at all: they have no gate clock and are limited by photon loss, not by a coherence time. What ultimately matters is not either axis alone but their ratio — how many operations you can complete before coherence runs out.</figcaption>
</figure>

Read the picture and the trade-off jumps out. Superconducting qubits sprint — gates in tens of nanoseconds — but forget almost as fast, with coherence around a few tenths of a millisecond and a hard-won record of $1.68$ ms <d-cite key="bland2025tantalum"></d-cite>. Trapped ions are the mirror image: gates a thousand times slower, in microseconds <d-cite key="ballance2016highfidelity"></d-cite>, but coherence measured in minutes <d-cite key="wang2017tenminute"></d-cite>. Neutral atoms sit between, with hundreds-of-nanosecond gates and seconds of coherence <d-cite key="manetsch2025tweezer"></d-cite>; silicon spin qubits cluster near superconducting — fast gates, millisecond coherence. The decisive quantity is not either axis alone but their *ratio*: how many operations you can run before the qubit forgets. The hare wins by being quick; the tortoise wins by never tiring. Both strategies can, in principle, get you to the same finish line.

The full report card needs all the criteria, not just two. Here is the at-a-glance comparison, consistent with the per-platform tables across the series, now with the spin/solid-state family added as a fifth column:

| | Superconducting | Trapped ion | Neutral atom | Photonic | Spin &amp; other |
|---|---|---|---|---|---|
| **Qubit** | printed circuit (transmon) | a real atom (ion) | a real atom | a photon | spin or defect (or Majorana) |
| **Gate speed** | very fast (~10–70 ns) | slow (~µs) | slow (~µs) | n/a (measurement) | fast (~tens of ns) |
| **Coherence** | short (~0.1–1.7 ms) | very long (s–min) | long (s) | loss-limited | ms–s (spin), to ~min (NV) |
| **Connectivity** | mostly nearest-neighbor | all-to-all | reconfigurable | hard (no interaction) | nearest-neighbor |
| **Operating temp** | ~10 mK (dilution fridge) | room-temp vacuum | room-temp vacuum | room temperature | ~0.1–4 K (spin), room temp (NV) |
| **As a network node** | needs transduction | natural (emits photons) | promising | it *is* the photon | NV natural, spin needs transduction |

Trace any single row and one platform looks like the obvious winner. Trace any single *column* and that same platform has a glaring weakness. That is not a defect of the table; it *is* the state of the field.

## Why there's no winner yet

The honest reason no qubit has won is that the DiVincenzo criteria are not independent wishes you can grant one by one — they are coupled, and improving one often *costs* you another. The trade-offs are structural, not temporary engineering embarrassments, and it is worth naming the main ones.

**Speed versus coherence.** This is the trade-off Figure 1 draws. The superconducting bet is to compute *fast* — out-sprint decoherence with tens-of-nanosecond gates — and the price is a qubit that forgets in well under a millisecond. The trapped-ion bet is the opposite: compute *slowly* but on a qubit that remembers for minutes, so the slowness is paid back many times over in operations completed. Neither is wrong. They are different routes to the same destination — *enough good operations before the clock runs out* — and the figure's diagonal is the line along which they trade.

**Connectivity versus manufacturability.** Trapped ions enjoy all-to-all connectivity — any qubit can talk directly to any other, which keeps circuits short — precisely because they route entanglement through a shared vibrational mode, the very thing that makes them slow and caps a single trap near a hundred ions. Superconducting and silicon qubits are *manufacturable*, printed by lithography, but pay for it with mostly nearest-neighbor wiring and the "snowflake" problem: no two fabricated qubits come out quite identical, so each must be calibrated by hand. The atoms-are-identical platforms (ions, neutral atoms) never fight fabrication spread, but they fight vacuum systems and laser cathedrals instead. You can have *identical and connected*, or *printable and scalable*, but nobody yet has both.

**Computing versus networking.** This is the trade-off this researcher cares about most, and the table's bottom row makes it stark. The criteria for being a good *computer* and the criteria for being a good *network node* are nearly orthogonal. Superconducting qubits, the best engineered computers, are among the worst would-be nodes: their information rides on ~5 GHz microwave photons that cannot enter an optical fiber, so linking two fridges over distance needs microwave-to-optical *transduction*, a translation step that today runs at best a few tens of percent efficient and has never linked two processors over a quantum channel <d-cite key="han2021microwaveoptical"></d-cite>. The atoms do far better, because they can natively emit an optical photon entangled with their internal state — ions have been entangled across 520 m of fiber <d-cite key="krutyanskiy2023entanglement"></d-cite>, and neutral atoms can now emit *telecom-band* photons ready for ordinary fiber <d-cite key="covey2025telecom"></d-cite>. Diamond color centers are downright built for it, carrying the first loophole-free Bell test <d-cite key="hensen2015loopholefree"></d-cite> and entanglement across 35 km of deployed city fiber <d-cite key="knaut2024telecom"></d-cite>. And the photon needs no conversion at all, because the qubit already *is* the photon — it is the wire. The cruel symmetry is that the platforms best at networking (photons, diamond) are weakest at large-scale computing, and the platform best at computing today (superconducting) is weakest at networking. The squad that scales and the squad that networks are rarely the same squad.

Put these together and the field's structure becomes legible. No platform fails — each is genuinely excellent at *something* — but each excellence is bought with a specific weakness, because the criteria are a blanket too short to cover every corner at once. This is why serious people increasingly talk about **co-design** (shaping algorithms and error-correcting codes to a given platform's strengths rather than demanding one universal machine) and about a **horses-for-courses** future: maybe the answer is not one winning qubit but several, each doing the job it is best at. Which leads directly to the most interesting possibility in the whole series.

## Outlook

If you came hoping this series would crown a winner, here is the honest disappointment and the better consolation: it cannot, and that is the point. Superconducting circuits are the fastest and most milestone-heavy; trapped ions are the most precise and the best memories; neutral atoms scale to the most qubits and the most logical qubits; photons fly natively and make the best wire; and the solid-state contenders each chase one disruptive breakthrough — mass production, room-temperature networking, or hardware-level error protection — with one of them not yet even proven to exist. Hand any of them the seven-box DiVincenzo scorecard and it fills in beautifully on some lines and leaves others blank. After six builds, the only intellectually honest verdict is that the report card has no valedictorian.

But notice what that implies, because it is genuinely hopeful rather than deflating. If the platform that computes best and the platform that networks best are different platforms, then the future may not be a single triumphant qubit at all — it may be a *quantum network* that stitches several together, each doing the one job it is best at: a superconducting or neutral-atom processor for raw computation, a trapped-ion or diamond node where you need long memory and a photon you can send, and photonic links carrying entanglement between them. The thing that looked like the field's central failure — no qubit wins every row — turns out to be the argument for connecting them. A quantum *internet* is not a consolation prize for failing to build one perfect machine; it may be the natural shape of the answer, and the reason a quantum-network researcher gets up in the morning.

So treat this post as a trailhead, not a verdict. Five routes climb the same mountain by different faces, and the view from each is worth the trip. Pick the one that pulls at you — the [fake atom in a fridge](/blog/2026/superconducting-qubits/), the [real atom in a vacuum](/blog/2026/trapped-ion-qubits/), the [thousand atoms in light](/blog/2026/neutral-atom-qubits/), the [photon that will not sit still](/blog/2026/photonic-qubits/), or the [scrappy contenders betting it all on one idea](/blog/2026/other-qubit-platforms/) — and read on. The interesting question was never *which qubit wins.* It is *how you wire them together.*
