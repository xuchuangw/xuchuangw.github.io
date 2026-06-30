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
version: "1.1"
last_updated: 2026-07-01
changelog:
  - version: "1.1"
    date: 2026-07-01
    note: "Three-round editorial and fact-check revision: deeper mechanisms and figures, tightened prose, and primary-source verification of every quantitative claim."
  - version: "1.0"
    date: 2026-06-30
    note: "Initial publication."
toc:
  - name: What makes a good qubit
  - name: Five ways to make a qubit
  - name: The scorecard
  - name: "Why there's no winner yet"
  - name: Outlook
---

Every few months a headline announces that *the* quantum computer has arrived — a new chip, a new record, a new superlative. It is almost always built on one particular kind of qubit, and almost never says so. That omission is the single most misleading thing about how quantum computing is reported, because the most important fact in the whole field is that **there is no winning qubit.** There are five serious ways to build one, each a wildly different physical object — a printed circuit, a levitating atom, a thousand atoms in a web of light, a flying photon, a lone spin in a sliver of silicon — and each one aces part of the same test while flunking the rest. This post is the map — the entry point to a six-part series that takes each route apart; read this one first, then follow whichever route intrigues you. Start where every fair comparison must: with the checklist every qubit is measured against.

## What makes a good qubit

Before you can argue about *which* qubit is best, you need to agree on what "good" even means — and remarkably, the field does. In 2000, David DiVincenzo wrote down a checklist so durable that a quarter-century later every platform is still graded against it <d-cite key="divincenzo2000criteria"></d-cite>. The **DiVincenzo criteria** are five requirements a system must meet to compute, plus two more it needs to *network*. They are worth stating plainly, because the rest of this series is, at bottom, a report card filled out against them.

The five computing criteria:

1. **Well-defined qubits, and a way to scale them.** You need a genuine two-level system — a clean $\vert 0\rangle$ and $\vert 1\rangle$ — and a path to having *many* of them, not just two. "Well-defined" is doing real work here: a harmonic oscillator, with its evenly spaced ladder of levels, is *not* a good qubit, because a pulse that drives $\vert 0\rangle\to\vert 1\rangle$ also drives $\vert 1\rangle\to\vert 2\rangle$ and the state leaks upward. Every platform's first job is to isolate two levels and keep the rest out of the way.
2. **Initialization.** You must be able to reliably set the qubits to a known starting state, the quantum equivalent of clearing the register to all zeros.
3. **Long coherence.** The qubit must hold its quantum state — its delicate phase relationships — far longer than it takes to do a gate. Coherence is the clock you are racing; everything else is how fast you can run before it runs out.
4. **A universal gate set.** You need a small repertoire of operations — some single-qubit rotations plus one genuine two-qubit entangling gate — from which any computation can be assembled. The two-qubit gate is almost always the hard part.
5. **Measurement.** You must be able to read out each qubit's state at the end, turning quantum amplitudes back into classical bits.

And the two **networking** criteria, which the same paper lists and which matter enormously to anyone building a quantum *internet* rather than a single isolated machine:

6. **Flying qubits.** The ability to convert a stationary, computing qubit into a *moving* one — almost always a photon — that can carry the quantum state somewhere else.
7. **Faithful transmission.** The ability to send those flying qubits between distant nodes reliably, so two separated machines can share entanglement.

Those last two are the backbone of the quantum-internet vision <d-cite key="wehner2018internet"></d-cite>, and they are exactly where the five platforms diverge most sharply. A qubit can be a superb *computer* and a hopeless *node*, or the reverse. So the checklist has seven boxes, and — this is the punchline of the entire series — **no platform ticks all seven.** The criteria pull against each other: the very design choice that buys you long coherence often costs you gate speed, and the thing that makes a qubit easy to mass-produce often makes it impossible to network. Hold that tension; it is the reason there are five posts after this one and not a single coronation. Now meet the contenders.

## Five ways to make a qubit

Read these as five characters who will reappear, virtues and vices intact, in the scorecard below.

**Superconducting qubits — the fast front-runner.** Instead of catching a real atom, you *build* one: pattern a little circuit onto a wafer, add a Josephson junction to make its energy ladder uneven, cool it to about 10 millikelvin, and it starts behaving like an atom with discrete levels. This is the route Google and IBM bet on, and it leads on speed and engineering momentum — gate times of tens of nanoseconds <d-cite key="google2023surface"></d-cite> and the splashiest milestones, including the first below-threshold error correction, on Google's Willow chip <d-cite key="google2024willow"></d-cite>. It pays for that lead in cryogenics, short coherence, and a weakness at networking. [Read the deep-dive →](/blog/2026/superconducting-qubits/)

**Trapped-ion qubits — the precision instrument.** Strip one electron off an atom and hold the resulting ion in vacuum on oscillating electric fields. Now the qubit is a *real* atom — every ion of a given isotope identical to every other, no fabrication spread — and you talk to it with lasers or microwaves. Ions hold the field's best gate fidelities <d-cite key="ionq2025twoqubit"></d-cite><d-cite key="smith2025singlequbit"></d-cite>, coherence measured in *minutes* <d-cite key="wang2017tenminute"></d-cite>, and all-to-all connectivity — any qubit can entangle directly with any other — on systems now past fifty qubits <d-cite key="quantinuum2025helios"></d-cite>. The bill: two-qubit gates close to a thousand times slower than superconducting's, and the difficulty of herding more than a hundred ions into one trap. [Read the deep-dive →](/blog/2026/trapped-ion-qubits/)

**Neutral-atom qubits — the scaling contender.** Don't strip the electron at all; pinch a *neutral* atom in a tightly focused laser beam, an "optical tweezer," and split one laser into thousands of those traps at once. The atoms are identical and the array is reconfigurable — you can physically shuttle qubits around mid-computation — and you entangle two of them by briefly inflating them into giant Rydberg states whose interaction is so strong that they cannot both be excited at once — the Rydberg blockade <d-cite key="saffman2010rydberg"></d-cite>. This route now leads on raw qubit count <d-cite key="manetsch2025tweezer"></d-cite> and is among the front-runners on error-corrected *logical* qubits <d-cite key="bluvstein2025faulttolerant"></d-cite>, trading top-end per-qubit quality for sheer numbers. [Read the deep-dive →](/blog/2026/neutral-atom-qubits/)

**Photonic qubits — the flying messenger.** Write the qubit on a single particle of light. It cannot be trapped or cooled — it travels at the speed of light by nature — which makes it the worst at *sitting still to compute* and the best at *going places*. Because photons barely interact, you cannot build a normal two-qubit gate from mirrors; instead photonics computes by *measurement*, building a big entangled state and consuming it <d-cite key="raussendorf2001oneway"></d-cite>, or stitching small resource states together with probabilistic fusions <d-cite key="bartolucci2023fusion"></d-cite>. Universal photonic machines are still tiny, but the photon is the consensus best network *wire*. [Read the deep-dive →](/blog/2026/photonic-qubits/)

**Other platforms — silicon spins, diamond defects, and a qubit that may not exist.** Off the main highways runs a scrappier crowd, each betting on a single breakthrough the front-runners cannot reach. **Semiconductor spin qubits** store the bit in a single electron's spin in silicon, in two flavors easy to conflate: gate-defined quantum dots that could ride the very CMOS lines that print your phone <d-cite key="intel2023tunnelfalls"></d-cite>, and single phosphorus atoms placed in the silicon by a scanning probe, whose two-qubit fidelities now reach the three-nines range <d-cite key="sqc2025elevenqubit"></d-cite>. **Color centers in diamond** (NV and SiV) are spins you can control — and, for NV, even use to sense magnetic fields — all at room temperature; but the move that makes them network nodes, entangling a stationary spin with a photon it emits, needs cryogenic cooling (a few kelvin for NV, millikelvin for SiV). Cold or not, they are natural nodes: Delft used NV centers for the first loophole-free Bell test — the gold-standard proof that the entanglement is real <d-cite key="hensen2015loopholefree"></d-cite>. And **topological qubits** make the most radical bet — error protection built into the hardware — but remain, after a retracted flagship paper <d-cite key="zhang2021retraction"></d-cite> and live disputes, unproven <d-cite key="microsoft2025parity"></d-cite><d-cite key="legg2025comment"></d-cite>. [Read the deep-dive →](/blog/2026/other-qubit-platforms/)

## The scorecard

Now lay them side by side. The figure below is the one chart to take away from the whole series, because it makes the central trade-off visible at a glance. It places each platform by two quantities at the heart of the DiVincenzo criteria — **how fast its gates run** (horizontal) and **how long its qubits stay coherent** (criterion 3, vertical), both on a roughly logarithmic scale. Keep an eye on their *ratio* — how many operations fit before the qubit forgets — which will turn out to matter more than either axis alone.

<figure class="l-body" style="text-align:center; margin:1.5rem auto; max-width:760px;">
  <svg viewBox="0 0 760 504" role="img" aria-label="A scatter plot of quantum-computing platforms positioned by gate time on the horizontal axis (shorter, i.e. faster, to the right) and coherence time on the vertical axis (longer toward the top), both logarithmic. Superconducting qubits sit at the bottom right: very fast gates, about thirty nanoseconds, but short coherence around a third of a millisecond, with a whisker up to the 1.68-millisecond record. Silicon spin qubits sit just above and left of superconducting: fast gates of tens of nanoseconds and coherence spanning milliseconds to seconds. Neutral atoms sit upper-middle-left: gates of a few hundred nanoseconds and coherence near ten seconds. Trapped ions sit top left: the slowest gates, tens of microseconds for a two-qubit gate, but the longest coherence, minutes. A faint diagonal band marks the central speed-versus-coherence trade-off. The top-right corner, fast and long-lived, is marked as the empty ideal that no platform reaches. A note at the bottom explains that photonic qubits sit off this map entirely, because their limit is photon loss and probabilistic gate success rather than a coherence time." style="width:100%; height:auto; font-family:sans-serif;">
    <defs>
      <marker id="hubAx" markerWidth="9" markerHeight="9" refX="4.5" refY="4.5" orient="auto"><path d="M0 0 L9 4.5 L0 9 Z" fill="currentColor"/></marker>
      <marker id="hubTr" markerWidth="9" markerHeight="9" refX="4.5" refY="4.5" orient="auto"><path d="M0 0 L9 4.5 L0 9 Z" fill="currentColor" fill-opacity="0.55"/></marker>
    </defs>
    <!-- vertical gridlines -->
    <line x1="200" y1="70" x2="200" y2="410" stroke="currentColor" stroke-width="1" stroke-dasharray="3 5" opacity="0.16"/>
    <line x1="340" y1="70" x2="340" y2="410" stroke="currentColor" stroke-width="1" stroke-dasharray="3 5" opacity="0.16"/>
    <line x1="480" y1="70" x2="480" y2="410" stroke="currentColor" stroke-width="1" stroke-dasharray="3 5" opacity="0.16"/>
    <line x1="620" y1="70" x2="620" y2="410" stroke="currentColor" stroke-width="1" stroke-dasharray="3 5" opacity="0.16"/>
    <!-- horizontal gridlines -->
    <line x1="110" y1="363" x2="700" y2="363" stroke="currentColor" stroke-width="1" stroke-dasharray="3 5" opacity="0.16"/>
    <line x1="110" y1="224" x2="700" y2="224" stroke="currentColor" stroke-width="1" stroke-dasharray="3 5" opacity="0.16"/>
    <line x1="110" y1="141" x2="700" y2="141" stroke="currentColor" stroke-width="1" stroke-dasharray="3 5" opacity="0.16"/>
    <!-- axes -->
    <line x1="110" y1="410" x2="110" y2="58" stroke="currentColor" stroke-width="1.6" marker-end="url(#hubAx)"/>
    <line x1="110" y1="410" x2="714" y2="410" stroke="currentColor" stroke-width="1.6" marker-end="url(#hubAx)"/>
    <!-- axis titles -->
    <text x="34" y="240" fill="currentColor" font-size="14.5" transform="rotate(-90 34 240)" text-anchor="middle" font-weight="600">Coherence time  (longer &#8593;)</text>
    <text x="405" y="447" fill="currentColor" font-size="14.5" text-anchor="middle" font-weight="600">Gate time  (shorter = faster &#8594;)</text>
    <!-- y tick labels -->
    <text x="101" y="414" fill="currentColor" font-size="11.5" text-anchor="end" opacity="0.8">0.1 ms</text>
    <text x="101" y="367" fill="currentColor" font-size="11.5" text-anchor="end" opacity="0.8">1 ms</text>
    <text x="101" y="228" fill="currentColor" font-size="11.5" text-anchor="end" opacity="0.8">1 s</text>
    <text x="101" y="145" fill="currentColor" font-size="11.5" text-anchor="end" opacity="0.8">1 min</text>
    <!-- x tick labels (centered under gridlines) -->
    <text x="200" y="426" fill="currentColor" font-size="11.5" text-anchor="middle" opacity="0.8">~10 &#181;s</text>
    <text x="340" y="426" fill="currentColor" font-size="11.5" text-anchor="middle" opacity="0.8">~1 &#181;s</text>
    <text x="480" y="426" fill="currentColor" font-size="11.5" text-anchor="middle" opacity="0.8">~100 ns</text>
    <text x="620" y="426" fill="currentColor" font-size="11.5" text-anchor="middle" opacity="0.8">~10 ns</text>
    <!-- central trade-off band -->
    <line x1="528" y1="378" x2="170" y2="120" stroke="currentColor" stroke-width="15" opacity="0.07" stroke-linecap="round"/>
    <line x1="524" y1="375" x2="178" y2="126" stroke="currentColor" stroke-width="1.4" stroke-dasharray="6 5" opacity="0.5"/>
    <text x="351" y="258" fill="currentColor" font-size="13" text-anchor="middle" transform="rotate(35.8 351 258)" opacity="0.75" font-style="italic">the central trade-off: speed &#8596; coherence</text>
    <!-- ideal corner -->
    <circle cx="648" cy="104" r="11" fill="none" stroke="currentColor" stroke-width="1.5" stroke-dasharray="3 3" opacity="0.45"/>
    <text x="630" y="100" fill="currentColor" font-size="11.5" text-anchor="end" opacity="0.5" font-style="italic">ideal: fast AND</text>
    <text x="630" y="115" fill="currentColor" font-size="11.5" text-anchor="end" opacity="0.5" font-style="italic">long-lived &#8212; empty</text>
    <!-- platform: trapped ion -->
    <circle cx="144.3" cy="105.1" r="10" fill="#14b8a6" fill-opacity="0.30" stroke="#14b8a6" stroke-width="2.4"/>
    <text x="161.3" y="101.1" fill="#14b8a6" font-size="13.5" text-anchor="start" font-weight="600">Trapped ion</text>
    <text x="161.3" y="117.1" fill="currentColor" font-size="11" text-anchor="start" opacity="0.8">~tens of &#181;s &#183; minutes</text>
    <!-- platform: neutral atom -->
    <circle cx="413.2" cy="177.5" r="10" fill="#e0a106" fill-opacity="0.30" stroke="#e0a106" stroke-width="2.4"/>
    <text x="430.2" y="173.5" fill="#e0a106" font-size="13.5" text-anchor="start" font-weight="600">Neutral atom</text>
    <text x="430.2" y="189.5" fill="currentColor" font-size="11" text-anchor="start" opacity="0.8">hundreds of ns &#183; ~10 s</text>
    <!-- platform: silicon spin (with ms-s whisker) -->
    <line x1="511.1" y1="224.0" x2="511.1" y2="363.5" stroke="#ef4444" stroke-width="1.6" opacity="0.5"/>
    <line x1="507.1" y1="224.0" x2="515.1" y2="224.0" stroke="#ef4444" stroke-width="1.6" opacity="0.5"/>
    <line x1="507.1" y1="363.5" x2="515.1" y2="363.5" stroke="#ef4444" stroke-width="1.6" opacity="0.5"/>
    <circle cx="511.1" cy="284.5" r="10" fill="#ef4444" fill-opacity="0.30" stroke="#ef4444" stroke-width="2.4"/>
    <text x="528.1" y="280.5" fill="#ef4444" font-size="13.5" text-anchor="start" font-weight="600">Spin qubits</text>
    <text x="528.1" y="296.5" fill="currentColor" font-size="11" text-anchor="start" opacity="0.8">tens of ns &#183; ms&#8211;s</text>
    <!-- platform: superconducting (whisker to 1.68 ms record) -->
    <line x1="553.2" y1="353.0" x2="553.2" y2="387.8" stroke="#4f7cff" stroke-width="1.6" opacity="0.5"/>
    <line x1="549.2" y1="353.0" x2="557.2" y2="353.0" stroke="#4f7cff" stroke-width="1.6" opacity="0.5"/>
    <circle cx="553.2" cy="387.8" r="10" fill="#4f7cff" fill-opacity="0.30" stroke="#4f7cff" stroke-width="2.4"/>
    <text x="570.2" y="383.8" fill="#4f7cff" font-size="13.5" text-anchor="start" font-weight="600">Superconducting</text>
    <text x="570.2" y="399.8" fill="currentColor" font-size="11" text-anchor="start" opacity="0.8">~30 ns &#183; ~0.3&#8211;1.7 ms</text>
    <!-- photonic off-map callout -->
    <rect x="110" y="458" width="604" height="42" rx="8" fill="currentColor" fill-opacity="0.04" stroke="currentColor" stroke-width="1.4" stroke-dasharray="6 4" opacity="0.85"/>
    <path d="M132 480 q 9 -11 18 0 q 9 11 18 0 q 9 -11 18 0" fill="none" stroke="currentColor" stroke-width="2"/>
    <text x="196" y="476" fill="currentColor" font-size="12.5" text-anchor="start" font-weight="600">Photonic sits off this map</text>
    <text x="196" y="492" fill="currentColor" font-size="11.5" text-anchor="start" opacity="0.85">&#8212; limited by photon loss + probabilistic gate success, not a coherence time.</text>
  </svg>
  <figcaption style="margin-top:.5rem;"><b>Figure 1.</b> The central trade-off, drawn. Each platform sits at its gate time (horizontal, faster to the right) against its coherence time (vertical, longer toward the top), both roughly logarithmic. The numbers are representative records from this series' deep-dives, and the top of the superconducting whisker marks an energy-relaxation record — longer than the phase coherence its gates actually use.</figcaption>
</figure>

The picture shows the trade-off; the precise records sharpen it. Superconducting gates fire in tens of nanoseconds, but the qubit forgets fast: its record energy-relaxation time ($T_1$) is $1.68$ ms <d-cite key="bland2025tantalum"></d-cite>, the phase coherence ($T_2$) that gates actually lean on tops out a little lower, around $1.5$ ms <d-cite key="somoroff2023fluxonium"></d-cite>, and the coherence usable mid-circuit is a few tenths of a millisecond. Trapped ions are the mirror image — two-qubit gates in *tens of microseconds*, close to a thousand times slower <d-cite key="ballance2016highfidelity"></d-cite>, repaid by an idle memory that can stretch to minutes <d-cite key="wang2017tenminute"></d-cite>; neutral atoms split the difference, hundreds-of-nanosecond Rydberg gates <d-cite key="evered2023highfidelity"></d-cite> over seconds of coherence <d-cite key="manetsch2025tweezer"></d-cite>. One caveat the plot cannot draw: these are best-case, idle-memory numbers, coaxed out with dynamical decoupling and heavy shielding — the coherence available *while a circuit runs* is shorter.

So the obvious scorecard is the *ratio* of the two axes: operations per coherence lifetime. A superconducting transmon manages maybe ten thousand gates inside its coherence window ($0.3$ ms over $30$ ns); an ion, with seconds-to-minutes of usable memory over tens-of-microsecond gates, fits millions. The hare wins by being quick, the tortoise by never tiring. Useful as the ratio is, though, it is *not* the finish line — and here a careful reader should push back.

What actually decides whether any of these becomes a *computer* is a third number the plot leaves out: the **two-qubit gate error rate**, judged against the **fault-tolerance threshold**. Error correction only begins to help once the physical error rate falls *below* that threshold — roughly $1\%$ for the workhorse surface code <d-cite key="fowler2012surface"></d-cite>; cross it, and piling on more physical qubits drives the *logical* error rate exponentially down, which is exactly the regime Google's Willow chip first reached <d-cite key="google2024willow"></d-cite>. A qubit with a glorious speed-to-coherence ratio but a $1\%$ gate error is dead on arrival; a slower one at $0.1\%$ is a front-runner. That is why fidelity matters every bit as much as the clock, why the leading platforms now report two-qubit errors in the three-to-four-nines range — and why raw qubit *count* is a strategic bet at all: fault tolerance spends hundreds to thousands of physical qubits to buy a single reliable logical one.

The full report card needs all seven criteria, not just two. Here it is twice over — first as a visual scorecard, then as a table you can read off line by line.

<figure class="l-body" style="text-align:center; margin:1.5rem auto; max-width:760px;">
  <svg viewBox="0 0 760 470" role="img" aria-label="A report-card matrix scoring the five qubit platforms against the seven DiVincenzo criteria. Rows are the criteria: scalable qubits, initialization, long coherence, universal gates, measurement, flying qubits, and faithful links. Columns are superconducting, trapped ion, neutral atom, photonic, and spin and other platforms. Each cell is a filled-fraction disc, a Harvey ball, from full (meets the criterion strongly) to empty (weakly). Reading across any single row, one platform looks like the winner; reading down any single column, every platform shows at least one glaring gap. Trapped ions fill coherence, gates, and measurement but are only half-full on scaling. Neutral atoms fill scaling but trail on networking. Superconducting fills the computing criteria but is nearly empty on the two networking rows. Photonic is full on the two networking rows but weak on the computing rows, and its coherence cell is marked not-applicable because its limit is a different axis. No column is full on every row." style="width:100%; height:auto; font-family:sans-serif;">
    <!-- row bands -->
    <rect x="8" y="124" width="732" height="46" fill="currentColor" fill-opacity="0.035"/>
    <rect x="8" y="216" width="732" height="46" fill="currentColor" fill-opacity="0.035"/>
    <rect x="8" y="308" width="732" height="46" fill="currentColor" fill-opacity="0.035"/>
    <line x1="8" y1="78" x2="740" y2="78" stroke="currentColor" stroke-width="1.3" opacity="0.5"/>
    <!-- column divider after label column -->
    <line x1="202" y1="10" x2="202" y2="400" stroke="currentColor" stroke-width="1.1" opacity="0.35"/>
    <!-- platform headers -->
    <text x="259.4" y="40" fill="#4f7cff" font-size="13.5" text-anchor="middle" font-weight="700">Super-</text>
    <text x="259.4" y="57" fill="#4f7cff" font-size="13.5" text-anchor="middle" font-weight="700">conducting</text>
    <text x="366.2" y="40" fill="#14b8a6" font-size="13.5" text-anchor="middle" font-weight="700">Trapped</text>
    <text x="366.2" y="57" fill="#14b8a6" font-size="13.5" text-anchor="middle" font-weight="700">ion</text>
    <text x="473.0" y="40" fill="#e0a106" font-size="13.5" text-anchor="middle" font-weight="700">Neutral</text>
    <text x="473.0" y="57" fill="#e0a106" font-size="13.5" text-anchor="middle" font-weight="700">atom</text>
    <text x="579.8" y="48" fill="currentColor" font-size="13.5" text-anchor="middle" font-weight="700">Photonic</text>
    <text x="686.6" y="40" fill="#ef4444" font-size="13.5" text-anchor="middle" font-weight="700">Spin &amp;</text>
    <text x="686.6" y="57" fill="#ef4444" font-size="13.5" text-anchor="middle" font-weight="700">other</text>
    <!-- row: 1  Scalable qubits -->
    <text x="196" y="105.0" fill="currentColor" font-size="13" text-anchor="end" font-weight="600">1  Scalable qubits</text>
      <circle cx="259.4" cy="101.0" r="14" fill="none" stroke="#4f7cff" stroke-width="1.5" opacity="0.5"/>
      <path d="M 259.4 101.0 L 259.4 87.0 A 14 14 0 1 1 245.4 101.0 Z" fill="#4f7cff" fill-opacity="0.82"/>
      <circle cx="366.2" cy="101.0" r="14" fill="none" stroke="#14b8a6" stroke-width="1.5" opacity="0.5"/>
      <path d="M 366.2 101.0 L 366.2 87.0 A 14 14 0 0 1 366.2 115.0 Z" fill="#14b8a6" fill-opacity="0.82"/>
      <circle cx="473.0" cy="101.0" r="14" fill="none" stroke="#e0a106" stroke-width="1.5" opacity="0.5"/>
      <circle cx="473.0" cy="101.0" r="14" fill="#e0a106" fill-opacity="0.82"/>
      <circle cx="579.8" cy="101.0" r="14" fill="none" stroke="currentColor" stroke-width="1.5" opacity="0.5"/>
      <path d="M 579.8 101.0 L 579.8 87.0 A 14 14 0 0 1 579.8 115.0 Z" fill="currentColor" fill-opacity="0.82"/>
      <circle cx="686.6" cy="101.0" r="14" fill="none" stroke="#ef4444" stroke-width="1.5" opacity="0.5"/>
      <path d="M 686.6 101.0 L 686.6 87.0 A 14 14 0 0 1 686.6 115.0 Z" fill="#ef4444" fill-opacity="0.82"/>
    <!-- row: 2  Initialization -->
    <text x="196" y="151.0" fill="currentColor" font-size="13" text-anchor="end" font-weight="600">2  Initialization</text>
      <circle cx="259.4" cy="147.0" r="14" fill="none" stroke="#4f7cff" stroke-width="1.5" opacity="0.5"/>
      <circle cx="259.4" cy="147.0" r="14" fill="#4f7cff" fill-opacity="0.82"/>
      <circle cx="366.2" cy="147.0" r="14" fill="none" stroke="#14b8a6" stroke-width="1.5" opacity="0.5"/>
      <circle cx="366.2" cy="147.0" r="14" fill="#14b8a6" fill-opacity="0.82"/>
      <circle cx="473.0" cy="147.0" r="14" fill="none" stroke="#e0a106" stroke-width="1.5" opacity="0.5"/>
      <path d="M 473.0 147.0 L 473.0 133.0 A 14 14 0 1 1 459.0 147.0 Z" fill="#e0a106" fill-opacity="0.82"/>
      <circle cx="579.8" cy="147.0" r="14" fill="none" stroke="currentColor" stroke-width="1.5" opacity="0.5"/>
      <path d="M 579.8 147.0 L 579.8 133.0 A 14 14 0 1 1 565.8 147.0 Z" fill="currentColor" fill-opacity="0.82"/>
      <circle cx="686.6" cy="147.0" r="14" fill="none" stroke="#ef4444" stroke-width="1.5" opacity="0.5"/>
      <path d="M 686.6 147.0 L 686.6 133.0 A 14 14 0 1 1 672.6 147.0 Z" fill="#ef4444" fill-opacity="0.82"/>
    <!-- row: 3  Long coherence -->
    <text x="196" y="197.0" fill="currentColor" font-size="13" text-anchor="end" font-weight="600">3  Long coherence</text>
      <circle cx="259.4" cy="193.0" r="14" fill="none" stroke="#4f7cff" stroke-width="1.5" opacity="0.5"/>
      <path d="M 259.4 193.0 L 259.4 179.0 A 14 14 0 0 1 259.4 207.0 Z" fill="#4f7cff" fill-opacity="0.82"/>
      <circle cx="366.2" cy="193.0" r="14" fill="none" stroke="#14b8a6" stroke-width="1.5" opacity="0.5"/>
      <circle cx="366.2" cy="193.0" r="14" fill="#14b8a6" fill-opacity="0.82"/>
      <circle cx="473.0" cy="193.0" r="14" fill="none" stroke="#e0a106" stroke-width="1.5" opacity="0.5"/>
      <path d="M 473.0 193.0 L 473.0 179.0 A 14 14 0 1 1 459.0 193.0 Z" fill="#e0a106" fill-opacity="0.82"/>
      <circle cx="579.8" cy="193.0" r="14" fill="none" stroke="currentColor" stroke-width="1.4" opacity="0.4"/>
      <line x1="573.8" y1="193.0" x2="585.8" y2="193.0" stroke="currentColor" stroke-width="1.6" opacity="0.55"/>
      <circle cx="686.6" cy="193.0" r="14" fill="none" stroke="#ef4444" stroke-width="1.5" opacity="0.5"/>
      <path d="M 686.6 193.0 L 686.6 179.0 A 14 14 0 1 1 672.6 193.0 Z" fill="#ef4444" fill-opacity="0.82"/>
    <!-- row: 4  Universal gates* -->
    <text x="196" y="243.0" fill="currentColor" font-size="13" text-anchor="end" font-weight="600">4  Universal gates*</text>
      <circle cx="259.4" cy="239.0" r="14" fill="none" stroke="#4f7cff" stroke-width="1.5" opacity="0.5"/>
      <path d="M 259.4 239.0 L 259.4 225.0 A 14 14 0 1 1 245.4 239.0 Z" fill="#4f7cff" fill-opacity="0.82"/>
      <circle cx="366.2" cy="239.0" r="14" fill="none" stroke="#14b8a6" stroke-width="1.5" opacity="0.5"/>
      <circle cx="366.2" cy="239.0" r="14" fill="#14b8a6" fill-opacity="0.82"/>
      <circle cx="473.0" cy="239.0" r="14" fill="none" stroke="#e0a106" stroke-width="1.5" opacity="0.5"/>
      <path d="M 473.0 239.0 L 473.0 225.0 A 14 14 0 1 1 459.0 239.0 Z" fill="#e0a106" fill-opacity="0.82"/>
      <circle cx="579.8" cy="239.0" r="14" fill="none" stroke="currentColor" stroke-width="1.5" opacity="0.5"/>
      <path d="M 579.8 239.0 L 579.8 225.0 A 14 14 0 0 1 579.8 253.0 Z" fill="currentColor" fill-opacity="0.82"/>
      <circle cx="686.6" cy="239.0" r="14" fill="none" stroke="#ef4444" stroke-width="1.5" opacity="0.5"/>
      <path d="M 686.6 239.0 L 686.6 225.0 A 14 14 0 1 1 672.6 239.0 Z" fill="#ef4444" fill-opacity="0.82"/>
    <!-- row: 5  Measurement -->
    <text x="196" y="289.0" fill="currentColor" font-size="13" text-anchor="end" font-weight="600">5  Measurement</text>
      <circle cx="259.4" cy="285.0" r="14" fill="none" stroke="#4f7cff" stroke-width="1.5" opacity="0.5"/>
      <circle cx="259.4" cy="285.0" r="14" fill="#4f7cff" fill-opacity="0.82"/>
      <circle cx="366.2" cy="285.0" r="14" fill="none" stroke="#14b8a6" stroke-width="1.5" opacity="0.5"/>
      <circle cx="366.2" cy="285.0" r="14" fill="#14b8a6" fill-opacity="0.82"/>
      <circle cx="473.0" cy="285.0" r="14" fill="none" stroke="#e0a106" stroke-width="1.5" opacity="0.5"/>
      <path d="M 473.0 285.0 L 473.0 271.0 A 14 14 0 1 1 459.0 285.0 Z" fill="#e0a106" fill-opacity="0.82"/>
      <circle cx="579.8" cy="285.0" r="14" fill="none" stroke="currentColor" stroke-width="1.5" opacity="0.5"/>
      <path d="M 579.8 285.0 L 579.8 271.0 A 14 14 0 1 1 565.8 285.0 Z" fill="currentColor" fill-opacity="0.82"/>
      <circle cx="686.6" cy="285.0" r="14" fill="none" stroke="#ef4444" stroke-width="1.5" opacity="0.5"/>
      <path d="M 686.6 285.0 L 686.6 271.0 A 14 14 0 1 1 672.6 285.0 Z" fill="#ef4444" fill-opacity="0.82"/>
    <!-- row: 6  Flying qubits -->
    <text x="196" y="335.0" fill="currentColor" font-size="13" text-anchor="end" font-weight="600">6  Flying qubits</text>
      <circle cx="259.4" cy="331.0" r="14" fill="none" stroke="#4f7cff" stroke-width="1.5" opacity="0.5"/>
      <path d="M 259.4 331.0 L 259.4 317.0 A 14 14 0 0 1 273.4 331.0 Z" fill="#4f7cff" fill-opacity="0.82"/>
      <circle cx="366.2" cy="331.0" r="14" fill="none" stroke="#14b8a6" stroke-width="1.5" opacity="0.5"/>
      <path d="M 366.2 331.0 L 366.2 317.0 A 14 14 0 1 1 352.2 331.0 Z" fill="#14b8a6" fill-opacity="0.82"/>
      <circle cx="473.0" cy="331.0" r="14" fill="none" stroke="#e0a106" stroke-width="1.5" opacity="0.5"/>
      <path d="M 473.0 331.0 L 473.0 317.0 A 14 14 0 1 1 459.0 331.0 Z" fill="#e0a106" fill-opacity="0.82"/>
      <circle cx="579.8" cy="331.0" r="14" fill="none" stroke="currentColor" stroke-width="1.5" opacity="0.5"/>
      <circle cx="579.8" cy="331.0" r="14" fill="currentColor" fill-opacity="0.82"/>
      <circle cx="686.6" cy="331.0" r="14" fill="none" stroke="#ef4444" stroke-width="1.5" opacity="0.5"/>
      <path d="M 686.6 331.0 L 686.6 317.0 A 14 14 0 0 1 686.6 345.0 Z" fill="#ef4444" fill-opacity="0.82"/>
    <!-- row: 7  Faithful links -->
    <text x="196" y="381.0" fill="currentColor" font-size="13" text-anchor="end" font-weight="600">7  Faithful links</text>
      <circle cx="259.4" cy="377.0" r="14" fill="none" stroke="#4f7cff" stroke-width="1.5" opacity="0.5"/>
      <path d="M 259.4 377.0 L 259.4 363.0 A 14 14 0 0 1 273.4 377.0 Z" fill="#4f7cff" fill-opacity="0.82"/>
      <circle cx="366.2" cy="377.0" r="14" fill="none" stroke="#14b8a6" stroke-width="1.5" opacity="0.5"/>
      <path d="M 366.2 377.0 L 366.2 363.0 A 14 14 0 1 1 352.2 377.0 Z" fill="#14b8a6" fill-opacity="0.82"/>
      <circle cx="473.0" cy="377.0" r="14" fill="none" stroke="#e0a106" stroke-width="1.5" opacity="0.5"/>
      <path d="M 473.0 377.0 L 473.0 363.0 A 14 14 0 0 1 473.0 391.0 Z" fill="#e0a106" fill-opacity="0.82"/>
      <circle cx="579.8" cy="377.0" r="14" fill="none" stroke="currentColor" stroke-width="1.5" opacity="0.5"/>
      <circle cx="579.8" cy="377.0" r="14" fill="currentColor" fill-opacity="0.82"/>
      <circle cx="686.6" cy="377.0" r="14" fill="none" stroke="#ef4444" stroke-width="1.5" opacity="0.5"/>
      <path d="M 686.6 377.0 L 686.6 363.0 A 14 14 0 0 1 686.6 391.0 Z" fill="#ef4444" fill-opacity="0.82"/>
    <!-- legend -->
    <text x="16" y="438" fill="currentColor" font-size="11.5" text-anchor="start" opacity="0.85" font-weight="600">Meets the criterion:</text>
      <circle cx="150" cy="434" r="9" fill="none" stroke="currentColor" stroke-width="1.5" opacity="0.5"/>
      <circle cx="150" cy="434" r="9" fill="currentColor" fill-opacity="0.82"/>
      <circle cx="192" cy="434" r="9" fill="none" stroke="currentColor" stroke-width="1.5" opacity="0.5"/>
      <path d="M 192 434 L 192 425 A 9 9 0 1 1 183.0 434.0 Z" fill="currentColor" fill-opacity="0.82"/>
      <circle cx="234" cy="434" r="9" fill="none" stroke="currentColor" stroke-width="1.5" opacity="0.5"/>
      <path d="M 234 434 L 234 425 A 9 9 0 0 1 234.0 443.0 Z" fill="currentColor" fill-opacity="0.82"/>
      <circle cx="276" cy="434" r="9" fill="none" stroke="currentColor" stroke-width="1.5" opacity="0.5"/>
      <path d="M 276 434 L 276 425 A 9 9 0 0 1 285.0 434.0 Z" fill="currentColor" fill-opacity="0.82"/>
      <circle cx="318" cy="434" r="9" fill="none" stroke="currentColor" stroke-width="1.5" opacity="0.5"/>
    <text x="141" y="458" fill="currentColor" font-size="10.5" text-anchor="start" opacity="0.7">strong</text>
    <text x="309" y="458" fill="currentColor" font-size="10.5" text-anchor="start" opacity="0.7">weak</text>
      <circle cx="378" cy="434" r="9" fill="none" stroke="currentColor" stroke-width="1.4" opacity="0.4"/>
      <line x1="372" y1="434" x2="384" y2="434" stroke="currentColor" stroke-width="1.6" opacity="0.55"/>
    <text x="394" y="438" fill="currentColor" font-size="10.5" text-anchor="start" opacity="0.7">n/a (different axis)</text>
    <text x="740" y="458" fill="currentColor" font-size="10" text-anchor="end" opacity="0.6" font-style="italic">*incl. two-qubit gate fidelity vs. the fault-tolerance threshold</text>
  </svg>
  <figcaption style="margin-top:.5rem;"><b>Figure 2.</b> The seven-box DiVincenzo report card, scored. Each disc shows — qualitatively — how fully a platform meets a criterion, from full (a clear strength) to empty (a clear weakness); the hard numbers live in the table below and in the deep-dives.</figcaption>
</figure>

| | Superconducting | Trapped ion | Neutral atom | Photonic | Spin &amp; other |
|---|---|---|---|---|---|
| **Qubit** | printed circuit (transmon) | a real atom (ion) | a real atom | a photon | spin or defect (or Majorana) |
| **Gate speed** | very fast (~10–70 ns) | slow (~tens of µs, 2-qubit) | moderate (~hundreds of ns) | n/a (measurement) | fast (~tens of ns) |
| **Coherence** | short (~0.1–1.7 ms) | very long (s–min) | long (s) | loss-limited | ms–s (spin), to ~min (NV) |
| **2-qubit fidelity** | ~99.5–99.9% | best (&gt;99.99%) | ~99.5% | set by fusion success + photon purity | ~99% (to 99.9%) |
| **Connectivity** | mostly nearest-neighbor | all-to-all | reconfigurable | hard (no interaction) | nearest-neighbor |
| **Operating temp** | ~10 mK (dilution fridge) | room-temp vacuum | room-temp vacuum | room temperature | ~0.1–4 K (spin); NV: RT control, ~4 K as node |
| **As a network node** | needs transduction | natural (emits photons) | promising | it *is* the photon | NV natural (cold); donor spin needs transduction |

Trace any single row of the report card and one platform stands out as the winner; trace any single column and at least one cell is nearly empty. That row-winner, column-loser pattern is not a defect of the table; it *is* the state of the field.

## Why there's no winner yet

The real reason no qubit has won is that the DiVincenzo criteria are not independent wishes you can grant one by one — they are coupled, and improving one often *costs* you another. The trade-offs are structural, not temporary engineering embarrassments, and it is worth naming the main ones.

**Speed versus coherence.** Figure 1 draws this one, but the sharper question is *why* the two axes are yoked together — why you cannot buy a fast gate and a long memory at the same counter. A fast gate needs strong coupling between the qubit and whatever drives it, and that same strong coupling is an open door through which the environment reaches in and scrambles the state. Superconducting circuits buy their blazing speed with exactly the strong electromagnetic coupling that shortens their coherence; ions, addressed through feeble optical and hyperfine transitions, are slow to drive *because* they are so well isolated from everything — including your control. That is why decades of engineering have nudged platforms *along* the diagonal of Figure 1 but never lifted one into the empty top-right corner.

**Connectivity versus manufacturability.** Trapped ions enjoy their all-to-all connectivity, which keeps circuits short, precisely because they route every entangling operation through a shared vibrational mode — the very thing that makes them slow and caps a single trap near a hundred ions. Superconducting and silicon qubits are *manufacturable*, printed by lithography, but pay for it with mostly nearest-neighbor wiring and the "snowflake" problem: no two fabricated qubits come out quite identical, so each must be calibrated by hand. The atoms-are-identical platforms (ions, neutral atoms) never fight fabrication spread, but they fight vacuum systems and laser cathedrals instead. You can have *identical and connected*, or *printable and scalable*, but nobody yet has both.

**Computing versus networking.** This is the trade-off at the heart of quantum networking, and the table's bottom row makes it stark: the criteria for being a good *computer* and the criteria for being a good *network node* are nearly orthogonal. Superconducting qubits, the best-engineered computers, are among the worst would-be nodes. Their information rides on ~5 GHz microwave photons that cannot enter an optical fiber, so linking two fridges over distance demands microwave-to-optical *transduction* — and here the relevant number is not the one usually quoted. Raw device conversion has reached tens of percent in the lab, but the *low-noise* efficiency you actually need to carry entanglement without drowning it in added noise remains far lower, which is why no one has yet linked two superconducting processors over an optical quantum channel <d-cite key="han2021microwaveoptical"></d-cite>.

The atoms do far better, because they can natively emit an optical photon entangled with their internal state — ions have been entangled across 520 m of fiber <d-cite key="krutyanskiy2023entanglement"></d-cite>, and neutral atoms can now emit *telecom-band* photons ready for ordinary fiber <d-cite key="covey2025telecom"></d-cite>. Diamond color centers are downright built for it, carrying that first loophole-free Bell test <d-cite key="hensen2015loopholefree"></d-cite> and entanglement across 35 km of deployed city fiber <d-cite key="knaut2024telecom"></d-cite>. And the photon needs no conversion at all, because the qubit already *is* the photon — it is the wire. The cruel symmetry is that the platforms best at networking — photons, diamond — are weakest at large-scale computing, and the best computer is almost never the best courier.

Put these together and the field's structure becomes legible. No platform fails — each is genuinely excellent at *something* — but each excellence is bought with a specific weakness, because the criteria are a blanket too short to cover every corner at once. This is why serious people increasingly talk about **co-design** (shaping algorithms and error-correcting codes to a platform's strengths instead of demanding one universal machine) and about a **horses-for-courses** future.

## Outlook

If you came hoping this series would crown a winner, here is the disappointment and the better consolation: it cannot, and that is the point. Hand any platform the seven-box DiVincenzo scorecard and it fills in beautifully on some lines and leaves others blank. After all five routes, the only honest verdict is that the report card has no valedictorian.

But notice what that implies. If the platform that computes best and the platform that networks best are different platforms, then the future may not be a single triumphant qubit at all — it may be a *quantum network* that stitches several together, each doing the one job it is best at: a superconducting or neutral-atom processor for raw computation, a trapped-ion or diamond node where you need long memory and a photon you can send, and photonic links carrying entanglement between them. The thing that looked like the field's central failure — no qubit wins every row — turns out to be the argument for connecting them: a quantum *internet* is not a consolation prize for failing to build one perfect machine but, very possibly, the natural shape of the answer — and the reason a quantum-network researcher gets up in the morning.

So treat this post as a trailhead, not a verdict. Five routes climb the same mountain by different faces, and the view from each is worth the trip. Pick the one that pulls at you — the [fake atom in a fridge](/blog/2026/superconducting-qubits/), the [real atom in a vacuum](/blog/2026/trapped-ion-qubits/), the [thousand atoms in light](/blog/2026/neutral-atom-qubits/), the [photon that will not sit still](/blog/2026/photonic-qubits/), or the [scrappy contenders betting it all on one idea](/blog/2026/other-qubit-platforms/) — and read on. The interesting question was never *which qubit wins.* It is *how you wire them together.*
