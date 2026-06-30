---
layout: distill
title: "Trapped-ion qubits: one real atom, doing two jobs"
description: "Strip one electron off an atom, hang it in nothing on an electric field oscillating millions of times a second, and you get the field's most accurate qubit — and a single speck of matter that is, at once, a quantum memory good for minutes, a processor with all-to-all wiring, and a node that can fire its state down a fiber."
date: 2026-06-30
tags: quantum trapped-ion
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
  - name: What a trapped-ion qubit is
  - name: How it is built and controlled
  - name: Where it shines
  - name: The honest costs
  - name: State of the art
  - name: Where it sits
---

*Part of the [How to Build a Quantum Computer](/blog/2026/how-to-build-a-quantum-computer/) series.*

The previous post in this series ended on a confession: a superconducting qubit is a circuit pretending to be an atom. This post is about the platform that refuses the pretense and catches a *real* one. Take an ordinary atom, strip a single electron so it carries a net charge, and hold that ion suspended in vacuum on nothing but electric fields. What you get is, by several measures, the most precise qubit anyone has built — and a quietly remarkable economy of function. The same lonely, levitating atom can *store* a quantum state for minutes, *compute* on it with any other ion in the trap, and *hand* it to a photon you fire down an optical fiber to a node across the city. Most platforms make you pick one of those jobs. The trapped ion just shrugs and does all three. Let us take the shrug seriously, because the physics that makes it possible is genuinely beautiful — and the bill it hands you is genuinely steep.

## What a trapped-ion qubit is

Start where every platform must: *what is the two-level system?* For a superconducting qubit it was a fabricated circuit; here it is the genuine article. The qubit is a single atomic ion — one atom of, say, ytterbium or calcium or barium, with one electron removed so it carries charge $+e$ — and the two states $\vert 0\rangle$ and $\vert 1\rangle$ are two of that atom's own internal electronic levels. Nothing is being faked. The discreteness that a transmon had to engineer with a Josephson junction comes free, because an atom's electrons genuinely can only sit on discrete energy levels. Pick two of them and you have your bit.

Which two? There are two standard choices, and the distinction matters later.

- A **hyperfine qubit** uses two ground-state sublevels split by the coupling between the electron's spin and the nucleus's. In $^{171}\mathrm{Yb}^+$ — the field's longtime workhorse — these are split by about $12.6$ GHz, a *microwave* frequency. The two states are so-called "clock states," prized because the particular pair chosen — both with magnetic quantum number $m=0$ — has, to first order, no Zeeman shift at all, leaving its energy gap nearly immune to stray magnetic fields. That insensitivity is the secret behind the absurd coherence times we will meet later.
- An **optical qubit** instead uses a ground state and a long-lived metastable excited state joined by a narrow *optical* transition — in $^{40}\mathrm{Ca}^+$, the $S_{1/2}\!\leftrightarrow\!D_{5/2}$ transition near $729$ nm, whose upper state lingers for about a second. The gap is hundreds of terahertz, so you drive it with a single, exquisitely stable laser rather than microwaves.

<figure class="l-body" style="text-align:center; margin:1.5rem auto; max-width:720px;">
  <svg viewBox="0 0 720 300" role="img" aria-label="Two ways to pick the qubit's two levels. Left: a hyperfine clock qubit in ytterbium-171, two ground-state sublevels split by 12.6 gigahertz and driven with microwaves, both stable so there is no decay floor. Right: an optical qubit in calcium-40, a ground state and a metastable state about one second long joined by a narrow 729-nanometre transition that caps its coherence." style="width:100%; height:auto; font-family:sans-serif;">
    <defs>
      <marker id="f1mw" markerWidth="8" markerHeight="8" refX="4" refY="4" orient="auto"><path d="M0 0 L8 4 L0 8 Z" fill="#4f7cff"/></marker>
      <marker id="f1op" markerWidth="8" markerHeight="8" refX="4" refY="4" orient="auto"><path d="M0 0 L8 4 L0 8 Z" fill="#ef4444"/></marker>
    </defs>
    <line x1="360" y1="44" x2="360" y2="272" stroke="currentColor" stroke-width="1" stroke-dasharray="3 6" opacity="0.35"/>
    <!-- LEFT: hyperfine clock qubit -->
    <text x="180" y="30" fill="currentColor" font-size="15" text-anchor="middle" font-weight="600">hyperfine &#8220;clock&#8221; qubit</text>
    <text x="180" y="50" fill="#4f7cff" font-size="12.5" text-anchor="middle"><tspan baseline-shift="super" font-size="9">171</tspan>Yb<tspan baseline-shift="super" font-size="9">+</tspan> &#183; microwave</text>
    <line x1="96" y1="150" x2="264" y2="150" stroke="#14b8a6" stroke-width="3"/>
    <line x1="96" y1="214" x2="264" y2="214" stroke="#14b8a6" stroke-width="3"/>
    <text x="88" y="146" fill="#14b8a6" font-size="13" text-anchor="end">&#124;1&#10217;</text>
    <text x="88" y="218" fill="#14b8a6" font-size="13" text-anchor="end">&#124;0&#10217;</text>
    <text x="272" y="146" fill="currentColor" font-size="11.5" text-anchor="start">F=1, m=0</text>
    <text x="272" y="218" fill="currentColor" font-size="11.5" text-anchor="start">F=0, m=0</text>
    <line x1="180" y1="150" x2="180" y2="214" stroke="#4f7cff" stroke-width="1.8" marker-start="url(#f1mw)" marker-end="url(#f1mw)"/>
    <text x="172" y="186" fill="#4f7cff" font-size="11.5" text-anchor="end">12.6 GHz</text>
    <text x="180" y="252" fill="currentColor" font-size="11" text-anchor="middle" opacity="0.85">both states are ground sublevels &#8212; no decay floor</text>
    <!-- RIGHT: optical qubit -->
    <text x="540" y="30" fill="currentColor" font-size="15" text-anchor="middle" font-weight="600">optical qubit</text>
    <text x="540" y="50" fill="#ef4444" font-size="12.5" text-anchor="middle"><tspan baseline-shift="super" font-size="9">40</tspan>Ca<tspan baseline-shift="super" font-size="9">+</tspan> &#183; 729 nm laser</text>
    <line x1="456" y1="214" x2="624" y2="214" stroke="#14b8a6" stroke-width="3"/>
    <line x1="456" y1="96" x2="624" y2="96" stroke="#14b8a6" stroke-width="3"/>
    <text x="448" y="218" fill="#14b8a6" font-size="13" text-anchor="end">&#124;0&#10217;</text>
    <text x="448" y="100" fill="#14b8a6" font-size="13" text-anchor="end">&#124;1&#10217;</text>
    <text x="632" y="218" fill="currentColor" font-size="11.5" text-anchor="start">S<tspan baseline-shift="sub" font-size="8">1/2</tspan></text>
    <text x="632" y="100" fill="currentColor" font-size="11.5" text-anchor="start">D<tspan baseline-shift="sub" font-size="8">5/2</tspan> &#183; ~1 s</text>
    <line x1="540" y1="96" x2="540" y2="214" stroke="#ef4444" stroke-width="1.8" marker-start="url(#f1op)" marker-end="url(#f1op)"/>
    <text x="532" y="158" fill="#ef4444" font-size="11.5" text-anchor="end">729 nm</text>
    <text x="540" y="252" fill="currentColor" font-size="11" text-anchor="middle" opacity="0.85">metastable upper state ~1 s &#8212; caps coherence</text>
  </svg>
  <figcaption style="margin-top:.5rem;"><b>Figure 1.</b> The two standard ways to choose a trapped-ion qubit's $\vert 0\rangle$ and $\vert 1\rangle$. <b>Left:</b> a <em>hyperfine</em> "clock" qubit in $^{171}\mathrm{Yb}^+$ — two ground-state sublevels split by $12.6$ GHz and driven with microwaves; because both states are stable ground levels, nothing limits their coherence from within. <b>Right:</b> an <em>optical</em> qubit in $^{40}\mathrm{Ca}^+$ — a ground state and a metastable state joined by a narrow $729$ nm transition, whose $\sim 1$ s upper-state lifetime sets a ceiling on coherence. The two qubit-defining levels are drawn in teal, the same color as the ions in every figure that follows.</figcaption>
</figure>

Hold onto that one-second number; it quietly draws a line we will return to when the coherence records arrive. Here is the part that fabricated qubits openly envy. Every $^{171}\mathrm{Yb}^+$ ion is *fundamentally identical to every other* — not "matched to within manufacturing tolerance," but *the same*, because atoms are not manufactured. Two transmons coming off the same wafer have slightly different frequencies and need individual calibration; the field calls them snowflakes. Two ions of the same isotope have *exactly* the same transition frequencies, set by nature to a precision no foundry will ever touch. (The honest footnote: the atoms are identical, but their *environments* are not. Micromotion, stray fields, crosstalk, and position-dependent heating still vary ion to ion, so nobody actually skips calibration — they just start from a far better place.)

So the qubit itself is the easy part: nature supplies it, pre-matched, for free. Everything hard is about *holding* the thing still and *talking* to it without knocking it loose.

## How it is built and controlled

**Why you cannot just build a bowl.** Your instinct, holding a charged particle, is to surround it with electrodes shaped like a bowl and let it settle at the bottom. Nature forbids it. In the empty space between your electrodes the electric potential obeys Laplace's equation $\nabla^2\Phi = 0$, and a function with no sources has no local minimum — every "bowl" is secretly a saddle, curving up along one axis and down along another. This is **Earnshaw's theorem**: no arrangement of static charges can trap another charge in stable equilibrium. Push down in two directions and the potential springs a leak in the third, and your ion rolls out.

**The trick: spin the saddle.** Wolfgang Paul's insight, which shared the 1989 Nobel Prize in Physics <d-cite key="nobel1989iontrap"></d-cite>, was to stop fighting the saddle and start rotating it. Drive the electrodes with a fast radio-frequency voltage — typically tens of megahertz — so the saddle flips its uphill and downhill directions millions of times a second. At any instant the ion is on a downhill slope somewhere; but before it can slide off, the field reverses and that direction becomes uphill. Picture a ball on a saddle that you spin: at every frozen moment it is about to roll off, yet on average it stays put. The mathematics is the Mathieu equation, and over a range of drive parameters its solutions are bounded. Time-average the fast oscillation and the ion feels a smooth, bowl-shaped effective potential. The energy of that pseudopotential — written with the quadratic dependence on charge and inverse dependence on mass that makes it an *energy*, not a voltage — is

$$
U_{\text{pseudo}}(\mathbf r) \;=\; \frac{q^2\,\lvert\mathbf E_0(\mathbf r)\rvert^2}{4\,m\,\Omega_{\text{RF}}^2},
$$

quadratic near the center, so the ion oscillates at a slow **secular frequency** $\omega_{\text{sec}}\ll\Omega_{\text{RF}}$ with a small fast jitter (micromotion) riding on top. A **linear Paul trap** builds this from four parallel rod electrodes forming a radial quadrupole — the RF drive sits on one opposing pair, the other pair held at RF ground — which squeezes the ion sideways, plus a pair of DC endcaps to push it inward along the axis. Several ions, all positive, repel one another and string out along the trap axis into an evenly spaced **linear chain** whose shared vibrations every ion feels at once — the canonical picture of trapped-ion computing, and the subject of Figure 2.

<figure class="l-body" style="text-align:center; margin:1.5rem auto; max-width:720px;">
  <svg viewBox="0 0 720 360" role="img" aria-label="A linear Paul trap holding a chain of five ions. Two horizontal radio-frequency electrode rails run above and below the chain; amber DC endcap electrodes cap the left and right ends. Five teal ions sit evenly spaced along the central axis. Beneath them, equal arrows under every ion show the chain's center-of-mass vibration, the shared phonon bus, with faint ghost positions marking the uniform displacement." style="width:100%; height:auto; font-family:sans-serif;">
    <defs>
      <marker id="t1a" markerWidth="8" markerHeight="8" refX="4" refY="4" orient="auto"><path d="M0 0 L8 4 L0 8 Z" fill="currentColor"/></marker>
    </defs>
    <!-- RF rails -->
    <rect x="150" y="58" width="430" height="16" rx="8" fill="none" stroke="#4f7cff" stroke-width="2"/>
    <rect x="150" y="286" width="430" height="16" rx="8" fill="none" stroke="#4f7cff" stroke-width="2"/>
    <text x="365" y="48" fill="#4f7cff" font-size="13" text-anchor="middle">RF electrode</text>
    <text x="365" y="324" fill="#4f7cff" font-size="13" text-anchor="middle">RF electrode (drives the spinning saddle, &#x3A9;<tspan baseline-shift="sub" font-size="9">RF</tspan> &#8776; tens of MHz)</text>
    <!-- DC endcaps -->
    <rect x="120" y="150" width="16" height="60" rx="5" fill="none" stroke="#e0a106" stroke-width="2"/>
    <rect x="594" y="150" width="16" height="60" rx="5" fill="none" stroke="#e0a106" stroke-width="2"/>
    <text x="128" y="232" fill="#e0a106" font-size="12" text-anchor="middle">DC</text>
    <text x="602" y="232" fill="#e0a106" font-size="12" text-anchor="middle">DC</text>
    <!-- ion chain -->
    <line x1="186" y1="180" x2="544" y2="180" stroke="currentColor" stroke-width="1" stroke-dasharray="3 5" opacity="0.45"/>
    <g opacity="0.3">
      <circle cx="224" cy="180" r="11" fill="none" stroke="#14b8a6" stroke-width="1.6" stroke-dasharray="3 3"/>
      <circle cx="294" cy="180" r="11" fill="none" stroke="#14b8a6" stroke-width="1.6" stroke-dasharray="3 3"/>
      <circle cx="364" cy="180" r="11" fill="none" stroke="#14b8a6" stroke-width="1.6" stroke-dasharray="3 3"/>
      <circle cx="434" cy="180" r="11" fill="none" stroke="#14b8a6" stroke-width="1.6" stroke-dasharray="3 3"/>
      <circle cx="504" cy="180" r="11" fill="none" stroke="#14b8a6" stroke-width="1.6" stroke-dasharray="3 3"/>
    </g>
    <g>
      <circle cx="210" cy="180" r="11" fill="#14b8a6" fill-opacity="0.22" stroke="#14b8a6" stroke-width="2.4"/>
      <circle cx="280" cy="180" r="11" fill="#14b8a6" fill-opacity="0.22" stroke="#14b8a6" stroke-width="2.4"/>
      <circle cx="350" cy="180" r="11" fill="#14b8a6" fill-opacity="0.22" stroke="#14b8a6" stroke-width="2.4"/>
      <circle cx="420" cy="180" r="11" fill="#14b8a6" fill-opacity="0.22" stroke="#14b8a6" stroke-width="2.4"/>
      <circle cx="490" cy="180" r="11" fill="#14b8a6" fill-opacity="0.22" stroke="#14b8a6" stroke-width="2.4"/>
    </g>
    <text x="350" y="135" fill="#14b8a6" font-size="13" text-anchor="middle">linear ion chain &#8212; each a single atom, charge +e</text>
    <!-- shared motional (center-of-mass) mode: uniform displacement -->
    <g opacity="0.85">
      <line x1="197" y1="234" x2="223" y2="234" stroke="currentColor" stroke-width="1.7" marker-end="url(#t1a)"/>
      <line x1="267" y1="234" x2="293" y2="234" stroke="currentColor" stroke-width="1.7" marker-end="url(#t1a)"/>
      <line x1="337" y1="234" x2="363" y2="234" stroke="currentColor" stroke-width="1.7" marker-end="url(#t1a)"/>
      <line x1="407" y1="234" x2="433" y2="234" stroke="currentColor" stroke-width="1.7" marker-end="url(#t1a)"/>
      <line x1="477" y1="234" x2="503" y2="234" stroke="currentColor" stroke-width="1.7" marker-end="url(#t1a)"/>
    </g>
    <text x="350" y="262" fill="currentColor" font-size="13" text-anchor="middle">center-of-mass mode (a phonon) &#8212; the whole chain sways in lockstep: the quantum bus</text>
  </svg>
  <figcaption style="margin-top:.5rem;"><b>Figure 2.</b> A linear Paul trap. Radio-frequency rails (blue) make the rotating saddle that confines the ions sideways; DC endcaps (amber) confine them along the axis. The mutual repulsion of the ions (teal) spreads them into an evenly spaced chain. Crucially, the whole chain vibrates as one: its collective normal modes — shared vibrations called <b>phonons</b> — belong to every ion at once. Here the arrows show the simplest mode, the center-of-mass mode, in which every ion steps the same way at the same instant (ghosted circles mark the displaced positions); that shared motion is the bus entangling gates exploit.</figcaption>
</figure>

**Cooling.** A trapped ion still jiggles thermally, and that motion is the very thing the gates will use, so it must be cold and well-defined. Lasers do the cooling. Doppler cooling — a beam tuned just below an atomic transition, so the ion preferentially absorbs photons when moving toward the beam and gets nudged to a stop — brings it to millikelvin scales; resolved-sideband cooling then removes motional quanta one at a time until the ion sits essentially in its **motional ground state**, an effective kinetic temperature of tens of microkelvin. Note what kind of temperature this is: it describes how much the ion is *moving*, not a surrounding bath. And note what it is *not*: there is no dilution refrigerator. The trap sits in ultra-high vacuum, around $10^{-11}$ mbar — roughly a thousand times emptier than the space the ISS flies through — but the apparatus around it runs at room temperature. Vacuum emptier than low orbit, lasers fussing over it around the clock, chilled in its motion to within a whisker of absolute zero: comfortably the most pampered atom in the universe.

**Single-qubit gates** are the easy half. Flip $\vert 0\rangle\leftrightarrow\vert 1\rangle$ on one ion with a resonant pulse: microwaves (or a pair of laser beams driving a stimulated Raman transition) for a hyperfine qubit, a narrow laser for an optical qubit. Tightly focused beams, or distinct microwave near-fields, address one ion at a time.

**Two-qubit gates** are where the genius lives — and where the shared vibration of Figure 2 pays off. You cannot entangle two ions by pushing them at each other directly; they are micrometers apart and you must not heat them. Instead you use their *collective motion* as an intermediary. Because the ions are coupled by their mutual repulsion, the chain has **normal modes** — the whole string sloshing in lockstep (the center-of-mass mode), or stretching and breathing — and each mode is a quantized harmonic oscillator whose excitations are **phonons**. These modes belong to *all* the ions at once. The trick, due first to Cirac and Zoller in 1995 <d-cite key="ciraczoller1995"></d-cite> and refined into the workhorse gate by Mølmer and Sørensen around 1999–2000 <d-cite key="molmer1999multiparticle"></d-cite>, is to make a laser exert a force on each ion *that depends on its internal qubit state* — a **spin-dependent force** — tuned to push on a shared motional mode.

Here is the mechanism, and it is worth slowing down for. Illuminate the two target ions with a **bichromatic** field — two laser tones straddling the qubit frequency, one sitting near the *red* motional sideband and one near the *blue*, each detuned by a small amount $\delta$ from its sideband. (Those sidebands lie a full motional frequency $\nu\sim\text{MHz}$ to either side of the qubit transition; $\delta$, the offset from the sideband, is far smaller, of order tens of kHz — so the two tones are emphatically *not* sitting beside the carrier, they hug the sidebands.) Together they produce a force on each ion proportional to its qubit operator $\hat\sigma_x$. Conditioned on the joint spin state, this force pushes the shared motional mode in different directions, sending it on a loop through *phase space* — the plane of the mode's position and momentum. The detuning is chosen so that after one gate time $t_{\text{gate}} = 2\pi/\delta$ the loop *closes*: the motion returns exactly to where it started and disentangles itself from the qubits, but the loop has swept out an area, and that enclosed area becomes a **geometric phase** stamped on the joint spin state. The collective effect is captured by one almost suspiciously tidy operator,

$$
H_{\text{MS}} \;\propto\; \hat S_x^{\,2}, \qquad \hat S_x \equiv \sum_i \hat\sigma_x^{(i)},
$$

the square of a total spin. Square a sum and out falls a cross term — here one ion's $\hat\sigma_x$ multiplied by the other's — and *that* cross term is the entangler, turning a separable product state into a maximally entangled Bell state. Pause on what just happened: two laser tones and a single shared wobble of the chain have welded the fates of two atoms together, and the atoms never touched. The deep virtue, and the reason the Mølmer–Sørensen gate displaced its predecessor, is that because the motion *returns to its starting point* the final entanglement barely depends on how many phonons were in the mode to begin with. The bus can be a little warm and the gate still works. Figure 3 sketches it.

<figure class="l-body" style="text-align:center; margin:1.5rem auto; max-width:680px;">
  <svg viewBox="0 0 720 420" role="img" aria-label="A Mølmer–Sørensen gate in three steps. First, a frequency axis shows two laser tones placed next to the red and blue motional sidebands, each a small detuning from its sideband and far from the carrier. Second, the resulting bichromatic field washes over both trapped ions and pushes their one shared motional mode. Third, the mode traces a closed loop in phase space whose enclosed area becomes a geometric phase that entangles the two ions, leaving the motion cold." style="width:100%; height:auto; font-family:sans-serif;">
    <defs>
      <marker id="f3ax" markerWidth="8" markerHeight="8" refX="4" refY="4" orient="auto"><path d="M0 0 L8 4 L0 8 Z" fill="currentColor"/></marker>
      <marker id="f3sp" markerWidth="7" markerHeight="7" refX="3.5" refY="3.5" orient="auto"><path d="M0 0 L7 3.5 L0 7 Z" fill="#14b8a6"/></marker>
      <marker id="f3dir" markerWidth="9" markerHeight="9" refX="4.5" refY="4.5" orient="auto"><path d="M0 0 L9 4.5 L0 9 Z" fill="#e0a106"/></marker>
    </defs>
    <!-- ============ 1. FREQUENCY INSET ============ -->
    <text x="360" y="34" fill="currentColor" font-size="13" text-anchor="middle">the two tones sit by the motional sidebands &#8212; not by the carrier</text>
    <line x1="128" y1="84" x2="598" y2="84" stroke="currentColor" stroke-width="1.4" marker-end="url(#f3ax)"/>
    <text x="606" y="88" fill="currentColor" font-size="10" text-anchor="start" opacity="0.7">frequency</text>
    <!-- carrier -->
    <line x1="360" y1="76" x2="360" y2="92" stroke="currentColor" stroke-width="1.2"/>
    <text x="360" y="70" fill="currentColor" font-size="12" text-anchor="middle">&#x3C9;&#8320;</text>
    <!-- red sideband + tone -->
    <line x1="228" y1="76" x2="228" y2="92" stroke="currentColor" stroke-width="1.2"/>
    <text x="228" y="70" fill="currentColor" font-size="11.5" text-anchor="middle">&#x3C9;&#8320;&#8722;&#x3BD;</text>
    <line x1="246" y1="84" x2="246" y2="104" stroke="#ef4444" stroke-width="2"/>
    <circle cx="246" cy="107" r="3" fill="#ef4444"/>
    <text x="237" y="100" fill="#ef4444" font-size="10" text-anchor="middle">&#x3B4;</text>
    <text x="246" y="122" fill="#ef4444" font-size="10" text-anchor="middle">red tone</text>
    <!-- blue sideband + tone -->
    <line x1="492" y1="76" x2="492" y2="92" stroke="currentColor" stroke-width="1.2"/>
    <text x="492" y="70" fill="currentColor" font-size="11.5" text-anchor="middle">&#x3C9;&#8320;+&#x3BD;</text>
    <line x1="474" y1="84" x2="474" y2="104" stroke="#4f7cff" stroke-width="2"/>
    <circle cx="474" cy="107" r="3" fill="#4f7cff"/>
    <text x="483" y="100" fill="#4f7cff" font-size="10" text-anchor="middle">&#x3B4;</text>
    <text x="474" y="122" fill="#4f7cff" font-size="10" text-anchor="middle">blue tone</text>
    <!-- ============ 2. ION SCENE ============ -->
    <text x="360" y="162" fill="currentColor" font-size="12.5" text-anchor="middle">one bichromatic field pushes both ions through the one shared mode</text>
    <rect x="110" y="178" width="500" height="18" rx="9" fill="#ef4444" fill-opacity="0.16"/>
    <rect x="110" y="200" width="500" height="18" rx="9" fill="#4f7cff" fill-opacity="0.16"/>
    <!-- ions with spin states -->
    <circle cx="170" cy="198" r="20" fill="#14b8a6" fill-opacity="0.22" stroke="#14b8a6" stroke-width="2.6"/>
    <circle cx="550" cy="198" r="20" fill="#14b8a6" fill-opacity="0.22" stroke="#14b8a6" stroke-width="2.6"/>
    <line x1="170" y1="189" x2="170" y2="207" stroke="#14b8a6" stroke-width="1.6" marker-start="url(#f3sp)" marker-end="url(#f3sp)"/>
    <line x1="550" y1="189" x2="550" y2="207" stroke="#14b8a6" stroke-width="1.6" marker-start="url(#f3sp)" marker-end="url(#f3sp)"/>
    <!-- shared motional mode (the bus) -->
    <path d="M194 198 q 12 -9 24 0 q 12 9 24 0 q 12 -9 24 0 q 12 9 24 0 q 12 -9 24 0 q 12 9 24 0 q 12 -9 24 0 q 12 9 24 0 q 12 -9 24 0 q 12 9 24 0 q 12 -9 24 0 q 12 9 24 0 q 12 -9 24 0 q 12 9 24 0" fill="none" stroke="currentColor" stroke-width="1.8" opacity="0.55"/>
    <text x="170" y="240" fill="#14b8a6" font-size="12.5" text-anchor="middle">ion 1</text>
    <text x="550" y="240" fill="#14b8a6" font-size="12.5" text-anchor="middle">ion 2</text>
    <text x="360" y="240" fill="currentColor" font-size="12" text-anchor="middle">shared motional mode = the bus</text>
    <!-- entanglement arc -->
    <path d="M192 216 Q 360 262 528 216" fill="none" stroke="#14b8a6" stroke-width="2" stroke-dasharray="5 4"/>
    <text x="360" y="282" fill="#14b8a6" font-size="12.5" text-anchor="middle">the two ions end up entangled &#8212; and they never touched</text>
    <!-- ============ 3. PHASE-SPACE LOOP ============ -->
    <text x="360" y="318" fill="currentColor" font-size="12" text-anchor="middle">the gate = a closed loop in phase space; its enclosed area is the phase</text>
    <line x1="322" y1="372" x2="406" y2="372" stroke="currentColor" stroke-width="1.4" marker-end="url(#f3ax)"/>
    <text x="414" y="376" fill="currentColor" font-size="11" text-anchor="start">X</text>
    <line x1="360" y1="406" x2="360" y2="342" stroke="currentColor" stroke-width="1.4" marker-end="url(#f3ax)"/>
    <text x="360" y="336" fill="currentColor" font-size="11" text-anchor="middle">P</text>
    <ellipse cx="360" cy="372" rx="38" ry="22" fill="#e0a106" fill-opacity="0.12" stroke="#e0a106" stroke-width="2"/>
    <path d="M398 366 a 38 22 0 0 1 -11 17" fill="none" stroke="#e0a106" stroke-width="2" marker-end="url(#f3dir)"/>
    <text x="430" y="360" fill="#e0a106" font-size="10.5" text-anchor="start">enclosed</text>
    <text x="430" y="373" fill="#e0a106" font-size="10.5" text-anchor="start">area &#8594;</text>
    <text x="430" y="386" fill="#e0a106" font-size="10.5" text-anchor="start">phase</text>
    <text x="360" y="416" fill="currentColor" font-size="11.5" text-anchor="middle">loop closes &#8594; motion left cold, spins entangled (Bell state)</text>
  </svg>
  <figcaption style="margin-top:.5rem;"><b>Figure 3.</b> The Mølmer–Sørensen gate, in three beats. <b>Top:</b> the two drive tones sit beside the red and blue motional sidebands (a full motional frequency $\nu$ from the carrier), each detuned from its sideband by a small $\delta$. <b>Middle:</b> that single bichromatic field illuminates both ions and exerts a spin-dependent force through their one <em>shared</em> motional mode — the bus. <b>Bottom:</b> the mode is driven around a closed loop in phase space; after $t_{\text{gate}}=2\pi/\delta$ the loop closes, returning the motion cold and uncorrelated with the qubits, while the area it enclosed becomes a geometric phase that leaves the two spins in a Bell state. Because the loop closes, the result barely cares how warm the bus was to begin with.</figcaption>
</figure>

The payoff of routing entanglement through a *shared* bus is **all-to-all connectivity**: every ion in the chain couples to the same collective modes, so any pair can be entangled directly, with no need to relay the state through a chain of intermediate neighbors. It is a group chat, not a corporate phone tree where every call is transferred desk to desk. Shorter circuits mean fewer operations, and fewer operations mean fewer chances to fail — a structural advantage we will weigh against the platform's structural curse, slowness, once we have counted its strengths.

## Where it shines

Four things set trapped ions apart — record gate fidelity, absurd coherence, clean single-shot readout, and all-to-all wiring — and in each one the precision of the numbers is the whole point. Weigh them exactly, and resist the urge to round up.

**Fidelity that strains belief.** A single-qubit gate is the operation ions do most flawlessly. Back in 2014 the Lucas group at Oxford demonstrated single-qubit gates on $^{43}\mathrm{Ca}^+$ with an error of about $1\times10^{-6}$ — "six nines," one slip in a million <d-cite key="harty2014highfidelity"></d-cite>. In June 2025 the same effort pushed that to an error of $1.5\times10^{-7}$, roughly **one error in 6.7 million operations** <d-cite key="smith2025singlequbit"></d-cite> — to put it in human terms, a typist that accurate could retype every Harry Potter book back to back and still, on average, not expect a single typo. Both records use *microwave* control rather than lasers, which sidesteps a fundamental laser-scattering error floor.

Keep the single-qubit and two-qubit records strictly apart, because the two-qubit gate is much harder. Its lab record has marched from $99.9\%$ in 2016 <d-cite key="ballance2016highfidelity"></d-cite> to above $99.99\%$ — past "four nines" — in 2025, again via all-electronic control <d-cite key="ionq2025twoqubit"></d-cite>. And on a *commercial, all-to-all* machine the best two-qubit fidelity is $99.921\%$, across all pairs on Quantinuum's Helios <d-cite key="quantinuum2025helios"></d-cite>. These are different categories of claim — single versus two-qubit, a laboratory hero-run versus a full-machine spec — and conflating them is the single most common way trapped-ion numbers get oversold. Much of this precision traces straight back to the identical-atoms point: when every qubit is the same atom with the same frequency, you are not fighting fabrication spread, and all-to-all connectivity keeps your circuits short.

**Coherence measured in minutes.** Where a transmon forgets in a fraction of a millisecond, an ion remembers for an almost comic length of time. A single $^{171}\mathrm{Yb}^+$ ion at Tsinghua (Kihwan Kim's group) held a quantum state coherent for more than **ten minutes** — about $660$ s — in 2017 <d-cite key="wang2017tenminute"></d-cite>. In 2021 the same group pushed an **estimated** coherence time past **one hour** ($\approx 5500$ s) <d-cite key="wang2021onehour"></d-cite>, though that figure is extrapolated from data taken out to under a thousand seconds, not a direct hour-long measurement. The joke writes itself: this atom holds a fragile quantum superposition steady for the better part of an hour, while I can lose a colleague's name in the four seconds between hearing it and needing it.

One detail makes the feat fair rather than miraculous, and it pays off a promise from the very first section. These records are all *hyperfine* clock qubits, whose two states are both stable ground-state sublevels — so there is no spontaneous-decay floor to fall through. An *optical* qubit cannot do this: its upper state is the metastable level from Figure 1, and that $\sim 1$ s lifetime caps its coherence no matter how quiet the lab. The two encodings really are different beasts, and this is where the difference bites. (A 2026 preprint from the same Tsinghua group stretches a two-ion encoding to an extrapolated $\sim 10.5$ hours <d-cite key="pi2026dfs"></d-cite> — striking, but a preprint, and another extrapolation.) The serious version of the keys joke is the entire reason ions make good network nodes, which we come to below.

**Readout you can trust in a single shot.** Measuring an ion is almost embarrassingly direct. Shine a *detection* laser tuned to a fast cycling transition: if the qubit sits in one state it scatters photons by the thousands and the ion glows visibly **bright**; if it sits in the other it stays off-resonant and **dark**. Point a sensitive camera or photomultiplier at it, count photons for a few hundred microseconds, and *bright versus dark* hands you the answer in a single shot — no averaging over many runs, no ambiguous analog voltage to threshold — at fidelities around $99.9\%$. One atom, one glance, one bit. This state-dependent fluorescence is one of the quiet reasons ions make such clean qubits.

**All-to-all connectivity.** Because every ion couples to the same shared modes, any pair can be entangled directly — no relaying a state down a line of neighbors. On a nearest-neighbor chip, entangling two far-apart qubits means a parade of SWAP gates to walk them together and back; an all-to-all machine skips that bookkeeping entirely, so the same algorithm compiles to a shallower circuit with fewer operations — and fewer operations mean fewer chances to fail. The advantages compound.

Taken together — record fidelities, minutes of coherence, single-shot readout, and full connectivity — these are exactly the properties you want if you care about *quality* of computation over raw speed and scale.

## The honest costs

Now settle the bill, because the same physics that buys all that precision charges for it.

**The gates are slow.** A high-fidelity two-qubit ion gate takes **microseconds** — sometimes many. The careful 2016 record reached its $99.9\%$ fidelity at a $100\,\mu\text{s}$ gate time; the very same study, pushed to its fastest $3.8\,\mu\text{s}$ gate, shed almost all of that quality and fell to about $97\%$ <d-cite key="ballance2016highfidelity"></d-cite>. Faster gates than that exist, but the trade is brutal — fidelity drops sharply. Against the **tens of nanoseconds** of a superconducting gate (Google's run around $25$–$34$ ns) <d-cite key="google2023surface"></d-cite>, that is roughly **100 to 1000 times slower**. The slowness is not incidental; it is structural. Entangling through a motional sideband is a weak process: the coupling is the bare laser Rabi frequency $\Omega$ reduced by the small **Lamb–Dicke parameter** $\eta\ll 1$ that measures how strongly light couples to the ion's motion, and the gate must also be slow enough to spectrally resolve a single motional mode and let its phase-space loop close. Both pressures push the gate time toward

$$
t_{\text{gate}} \;\sim\; \frac{2\pi}{\delta} \;\sim\; \frac{1}{\eta\,\Omega},
$$

which lands in microseconds. No clever pulse erases that scale entirely. None of which makes slow gates secretly a virtue — they are a genuine cost. But the honest counter is subtler and more interesting: what ultimately matters is not raw gate speed but **how many useful operations you complete before an error creeps in**, and very long coherence times multiplied by very high fidelities buy you an enormous number of those. It is the tortoise — slower per step, but far fewer missteps over the long haul a real quantum algorithm demands.

**Scaling one chain is hard.** You cannot simply keep adding ions to a single string. The more ions share a trap, the denser and softer their motional spectrum becomes: modes crowd together, become harder to address individually, heat more easily, and slow the gates further. Today's leading single-chain machines hold only on the order of a hundred ions. Two escape routes are under active construction, and they map neatly onto the field's two leading companies. The first is the **QCCD** ("quantum charge-coupled device") architecture: physically *shuttle* ions between dedicated storage and interaction zones on a segmented chip, so every gate happens in a small, well-behaved group of two or three ions — Quantinuum's bet. There is no free lunch in this: every shuttle reheats the ions' motion — the very thing the gates need kept cold — so these machines co-trap a second "coolant" species and sympathetically re-cool the qubits between gates, trading a connectivity win for a transport-and-cooling problem. The second is **photonic interconnect**: build many small, excellent traps and stitch them into one modular machine using photons — the same ion-emits-a-photon trick that, as we are about to see, also makes ions natural network nodes. This is IonQ's bet.

**Lasers and vacuum, everywhere.** A trapped-ion system is an optics cathedral. Each species needs a small orchestra of frequency-stabilized lasers — for cooling, state preparation, gates, and readout — plus the ultra-high vacuum ($\sim 10^{-11}$ mbar) that keeps stray gas molecules from knocking the ion out of the trap, plus electrode surfaces clean enough to suppress "anomalous heating," the stubborn, not-fully-understood noise that warms the motional modes the gates depend on. There is no dilution fridge, which is a real relief next to superconducting; but "room-temperature vacuum chamber wrapped in lasers" is not exactly a laptop either. Different cathedral, comparable upkeep.

## State of the art

The trapped-ion scoreboard is less about raw qubit counts — the headline-grabbing flex of the superconducting world — and more about fidelity, error correction, and the first real steps toward networking. Read each result for what it is.

**Quantinuum.** Honeywell's quantum unit merged with Cambridge Quantum to form Quantinuum, and its QCCD H-series has spent years quietly setting records — particularly in **quantum volume**, a whole-machine benchmark that rewards quality and connectivity rather than mere qubit count. In November 2025 it launched **Helios**: 98 physical qubits, its first machine built on $^{137}\mathrm{Ba}^+$ rather than ytterbium (barium's visible $493$ nm light is kinder to optics and fiber than ytterbium's ultraviolet), with all-to-all connectivity, a single-qubit fidelity of $99.9975\%$ and a two-qubit fidelity of $99.921\%$ across all pairs <d-cite key="quantinuum2025helios"></d-cite>. On top of those 98 physical qubits it also ran *logical* qubits — 48 of them, at an unusually dense two-to-one physical-to-logical encoding that Quantinuum reports clearing the better-than-physical bar <d-cite key="quantinuum2025helios"></d-cite>. That second count arguably matters more than the first: encoded qubits are the currency of fault tolerance, not just more raw atoms. (How robustly 48 qubits at a two-to-one ratio *correct* errors, as opposed to merely *detect* them, is exactly the kind of claim that wants a published code distance behind it; at launch the announcement still led the peer-reviewed literature.)

Earlier, in 2024, a Microsoft–Quantinuum collaboration ran error correction on H2 hardware and reported logical error rates **11 to 800 times** below the matching physical baselines, across experiments using up to 12 logical qubits — results since validated in a peer-reviewed 2026 paper <d-cite key="microsoft2024logical"></d-cite>. The caveat: an 800-fold improvement over a physical baseline is a demonstration of *better-than-physical encoded operations* on a handful of logical qubits, not a fault-tolerant computer — the prerequisite, not the destination.

**IonQ.** The other commercial heavyweight, IonQ pursues the modular, photonically-networked path. It long ran on $^{171}\mathrm{Yb}^+$ and has since moved to **barium**, whose friendlier wavelengths ease both optics and the photonic links its architecture depends on; its barium "Tempo" system reached a milestone benchmark in 2025 <d-cite key="ionq2025barium"></d-cite>. IonQ (via its acquisition of Oxford Ionics) also holds the laboratory two-qubit fidelity record above $99.99\%$ noted earlier, achieved with all-electronic control <d-cite key="ionq2025twoqubit"></d-cite>.

**The academic record-setters.** Behind the companies sit the labs that set the fidelity ceilings — Oxford's single-qubit results at the $10^{-7}$ level <d-cite key="smith2025singlequbit"></d-cite>, and the long lineage from NIST, where the *first* quantum logic gate of any kind was demonstrated in 1995 between the internal and motional states of a single $^{9}\mathrm{Be}^+$ ion <d-cite key="monroe1995logicgate"></d-cite>. The field's pedigree is hard to overstate: Paul shared the 1989 Nobel for the trap itself <d-cite key="nobel1989iontrap"></d-cite>, and David Wineland shared the 2012 Nobel for the trapped-ion quantum control that made all of this possible <d-cite key="nobel2012wineland"></d-cite>. The usual three caveats apply to every number above — a lab hero-run is not an in-machine median, a single-qubit gate is not a two-qubit gate, and a physical qubit is not a logical one — and trapped-ion practitioners, to their credit, tend to be unusually scrupulous about saying so.

## Where it sits

A trapped ion is a **slow, fussy, ferociously precise** qubit — and, almost uniquely, one that is equally credible as a quantum *memory*, a quantum *processor*, and a quantum *network node*. That triple identity is the through-line of this whole platform: store a state and the ion is a memory; entangle two and it is a processor; let one breathe out a photon and it is a node. The same charged speck of matter, held in nothing, does all three jobs we normally build separate machines for.

That networking role is not a footnote here — it is a genuine strength, and the reason this series keeps one eye on whether a qubit can *network* as well as compute. A superconducting qubit speaks in microwave photons that cannot travel down an optical fiber, so linking two of them over distance demands a lossy microwave-to-optical translation step that nobody has yet made work well. An ion has no such problem: it natively *emits an optical photon entangled with its own internal state*. Catch that photon, send it down a fiber, interfere it with a photon from a distant ion, and a successful measurement leaves the two faraway ions entangled — having never touched. This is demonstrated physics, not a hope: two ions about a metre apart were heralded into entanglement by Monroe's group back in 2007 <d-cite key="moehring2007entanglement"></d-cite>, and in 2023 an Innsbruck team entangled two ions in separate buildings across **520 m of fiber** (230 m apart) at about $88\%$ fidelity <d-cite key="krutyanskiy2023entanglement"></d-cite>. An ion that remembers for minutes *and* can hand its state to a photon is precisely the ingredient a quantum repeater — the backbone of any future quantum internet — is built from. For a researcher who cares about quantum *networks*, this is the row that matters most.

<figure class="l-body" style="text-align:center; margin:1.5rem auto; max-width:720px;">
  <svg viewBox="0 0 720 300" role="img" aria-label="Why an ion is a natural network node. Two ions, each in its own trap in a separate lab, each emit an optical photon entangled with their internal state. The two photons travel down optical fibers to a central beam-splitter and detectors that perform a Bell-state measurement. A coincidence click heralds entanglement between the two distant ions, which never interacted, shown as a dashed link arcing over the top. Annotations note 520 metres of fiber, ions 230 metres apart, and about 88 percent fidelity from Innsbruck in 2023." style="width:100%; height:auto; font-family:sans-serif;">
    <defs>
      <marker id="f4ph" markerWidth="8" markerHeight="8" refX="4" refY="4" orient="auto"><path d="M0 0 L8 4 L0 8 Z" fill="#e0a106"/></marker>
    </defs>
    <!-- heralded-entanglement arc over the top -->
    <path d="M110 150 Q 360 96 610 150" fill="none" stroke="#14b8a6" stroke-width="2" stroke-dasharray="6 4"/>
    <text x="360" y="92" fill="#14b8a6" font-size="12.5" text-anchor="middle">a coincidence click heralds: ions A and B entangled &#8212; never touched</text>
    <!-- node A -->
    <line x1="92" y1="162" x2="92" y2="198" stroke="#e0a106" stroke-width="2.4"/>
    <line x1="128" y1="162" x2="128" y2="198" stroke="#e0a106" stroke-width="2.4"/>
    <circle cx="110" cy="180" r="15" fill="#14b8a6" fill-opacity="0.22" stroke="#14b8a6" stroke-width="2.4"/>
    <text x="110" y="226" fill="#14b8a6" font-size="12" text-anchor="middle">node A</text>
    <text x="110" y="242" fill="currentColor" font-size="10.5" text-anchor="middle" opacity="0.8">(ion in a trap, lab A)</text>
    <!-- node B -->
    <line x1="592" y1="162" x2="592" y2="198" stroke="#e0a106" stroke-width="2.4"/>
    <line x1="628" y1="162" x2="628" y2="198" stroke="#e0a106" stroke-width="2.4"/>
    <circle cx="610" cy="180" r="15" fill="#14b8a6" fill-opacity="0.22" stroke="#14b8a6" stroke-width="2.4"/>
    <text x="610" y="226" fill="#14b8a6" font-size="12" text-anchor="middle">node B</text>
    <text x="610" y="242" fill="currentColor" font-size="10.5" text-anchor="middle" opacity="0.8">(ion in a trap, lab B)</text>
    <!-- fibers -->
    <line x1="128" y1="180" x2="338" y2="180" stroke="currentColor" stroke-width="3" opacity="0.25"/>
    <line x1="592" y1="180" x2="382" y2="180" stroke="currentColor" stroke-width="3" opacity="0.25"/>
    <!-- photons (wavy, travelling inward) -->
    <path d="M150 180 q 11 -7 22 0 q 11 7 22 0 q 11 -7 22 0 q 11 7 22 0 q 11 -7 22 0 q 11 7 22 0 q 11 -7 22 0" fill="none" stroke="#e0a106" stroke-width="2" marker-end="url(#f4ph)"/>
    <path d="M570 180 q -11 -7 -22 0 q -11 7 -22 0 q -11 -7 -22 0 q -11 7 -22 0 q -11 -7 -22 0 q -11 7 -22 0 q -11 -7 -22 0" fill="none" stroke="#e0a106" stroke-width="2" marker-end="url(#f4ph)"/>
    <text x="232" y="162" fill="#e0a106" font-size="10.5" text-anchor="middle">photon (carries A's state)</text>
    <text x="488" y="162" fill="#e0a106" font-size="10.5" text-anchor="middle">photon (carries B's state)</text>
    <!-- central beam-splitter + detectors -->
    <polygon points="360,166 374,180 360,194 346,180" fill="none" stroke="currentColor" stroke-width="2"/>
    <text x="360" y="214" fill="currentColor" font-size="11" text-anchor="middle">Bell-state measurement</text>
    <!-- bottom annotations -->
    <text x="360" y="266" fill="currentColor" font-size="12" text-anchor="middle">Innsbruck 2023: ions 230 m apart, 520 m of fiber, ~88% fidelity</text>
    <text x="360" y="285" fill="currentColor" font-size="11" text-anchor="middle" opacity="0.85">remembers for minutes AND emits a photon = a quantum-repeater node</text>
  </svg>
  <figcaption style="margin-top:.5rem;"><b>Figure 4.</b> Why an ion is a natural <em>network node</em>. Each ion, alone in its own trap in a separate lab, emits an optical photon entangled with its internal qubit state. The two photons race down fibers to a central beam-splitter; a coincidence "click" performs a Bell-state measurement that — without the ions ever interacting — leaves the two distant ions entangled. Innsbruck demonstrated exactly this in 2023 across $520$ m of fiber between ions $230$ m apart, at about $88\%$ fidelity <d-cite key="krutyanskiy2023entanglement"></d-cite>. An ion that both *remembers* for minutes and *hands its state to a photon* is precisely the brick a quantum repeater is built from.</figcaption>
</figure>

| | Superconducting | Trapped ion | Neutral atom | Photonic |
|---|---|---|---|---|
| **Qubit** | printed circuit (transmon) | a real atom (ion) | a real atom | a photon |
| **Gate speed** | very fast (~10–70 ns) | slow (~µs) | slow (~µs) | n/a (measurement) |
| **Coherence** | short (~0.1–1.7 ms) | very long (s–min) | long (s) | loss-limited |
| **Connectivity** | mostly nearest-neighbor | all-to-all | reconfigurable | hard (no interaction) |
| **Operating temp** | ~10 mK (dilution fridge) | room-temp vacuum | room-temp vacuum | room temperature |
| **As a network node** | needs transduction | natural (emits photons) | promising | it *is* the photon |

No platform wins every row, which is exactly why five of them are still racing. Superconducting out-sprints decoherence; the trapped ion out-lasts and out-connects it, and pays in microseconds per gate and in the difficulty of herding more than a hundred atoms into one trap. If your wish list is a cloud-accessible engineering juggernaut today, superconducting still leads; if it is record fidelity, long memory, all-to-all wiring, and a photon you can fire at a distant node, the ion is the one to beat. Either way, there is a different question hiding in the table's fourth column: if catching one real atom is this good but herding many is this hard, what if you did not strip the electron at all — and held a *neutral* atom in a tweezer of pure light, with thousands of traps conjured from a single laser? That is the next route in this series: **neutral atoms**.

---

**More in this series — [How to Build a Quantum Computer](/blog/2026/how-to-build-a-quantum-computer/):** [Superconducting](/blog/2026/superconducting-qubits/) · [Trapped ion](/blog/2026/trapped-ion-qubits/) · [Neutral atom](/blog/2026/neutral-atom-qubits/) · [Photonic](/blog/2026/photonic-qubits/) · [Other platforms](/blog/2026/other-qubit-platforms/)
