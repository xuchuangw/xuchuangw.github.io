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

- A **hyperfine qubit** uses two ground-state sublevels split by the coupling between the electron's spin and the nucleus's. In $^{171}\mathrm{Yb}^+$ — the field's longtime workhorse — these are split by about $12.6$ GHz, a *microwave* frequency. The two states are so-called "clock states," prized because at the right magnetic-field bias their energy gap is, to first order, insensitive to stray magnetic noise. That insensitivity is the secret behind the absurd coherence times we will meet later.
- An **optical qubit** instead uses a ground state and a long-lived metastable excited state joined by a narrow *optical* transition — in $^{40}\mathrm{Ca}^+$, the $S_{1/2}\!\leftrightarrow\!D_{5/2}$ transition near $729$ nm, whose upper state lingers for about a second. The gap is hundreds of terahertz, so you drive it with a single, exquisitely stable laser rather than microwaves.

Here is the part that fabricated qubits openly envy. Every $^{171}\mathrm{Yb}^+$ ion is *fundamentally identical to every other* — not "matched to within manufacturing tolerance," but *the same*, because atoms are not manufactured. Two transmons coming off the same wafer have slightly different frequencies and need individual calibration; the field calls them snowflakes. Two ions of the same isotope have *exactly* the same transition frequencies, set by nature to a precision no foundry will ever touch. (The honest footnote: the atoms are identical, but their *environments* are not. Micromotion, stray fields, crosstalk, and position-dependent heating still vary ion to ion, so nobody actually skips calibration — they just start from a far better place.)

So the qubit itself is the easy part: nature supplies it, pre-matched, for free. Everything hard is about *holding* the thing still and *talking* to it without knocking it loose.

## How it is built and controlled

**Why you cannot just build a bowl.** Your instinct, holding a charged particle, is to surround it with electrodes shaped like a bowl and let it settle at the bottom. Nature forbids it. In the empty space between your electrodes the electric potential obeys Laplace's equation $\nabla^2\Phi = 0$, and a function with no sources has no local minimum — every "bowl" is secretly a saddle, curving up along one axis and down along another. This is **Earnshaw's theorem**: no arrangement of static charges can trap another charge in stable equilibrium. Push down in two directions and the potential springs a leak in the third, and your ion rolls out.

**The trick: spin the saddle.** Wolfgang Paul's insight, which shared the 1989 Nobel Prize in Physics <d-cite key="nobel1989iontrap"></d-cite>, was to stop fighting the saddle and start rotating it. Drive the electrodes with a fast radio-frequency voltage — typically tens of megahertz — so the saddle flips its uphill and downhill directions millions of times a second. At any instant the ion is on a downhill slope somewhere; but before it can slide off, the field reverses and that direction becomes uphill. Picture a ball on a saddle that you spin: at every frozen moment it is about to roll off, yet on average it stays put. The mathematics is the Mathieu equation, and over a range of drive parameters its solutions are bounded. Time-average the fast oscillation and the ion feels a smooth, bowl-shaped effective potential — the **pseudopotential**,

$$
\Phi_{\text{pseudo}}(\mathbf r) \;=\; \frac{q^2\,\lvert\mathbf E_0(\mathbf r)\rvert^2}{4\,m\,\Omega_{\text{RF}}^2},
$$

quadratic near the center, so the ion oscillates at a slow **secular frequency** $\omega_{\text{sec}}\ll\Omega_{\text{RF}}$ with a small fast jitter (micromotion) riding on top. A **linear Paul trap** arranges four rod electrodes carrying the RF to squeeze the ion radially, plus a pair of DC endcaps to push it inward axially. Several ions, all positive, repel one another and string out along the trap axis into an evenly spaced **linear chain** — the canonical picture of trapped-ion computing, and the subject of Figure 1.

<figure class="l-body" style="text-align:center; margin:1.5rem auto; max-width:720px;">
  <svg viewBox="0 0 720 360" role="img" aria-label="A linear Paul trap holding a chain of five ions. Two horizontal radio-frequency electrode rails run above and below the chain; amber DC endcap electrodes cap the left and right ends. Five teal ions sit evenly spaced along the central axis. Beneath them a wavy line and double-headed arrows mark a shared collective vibration, the phonon bus." style="width:100%; height:auto; font-family:sans-serif;">
    <defs>
      <marker id="t1a" markerWidth="8" markerHeight="8" refX="4" refY="4" orient="auto"><path d="M0 0 L8 4 L0 8 Z" fill="currentColor"/></marker>
    </defs>
    <!-- RF rails -->
    <rect x="150" y="58" width="430" height="16" rx="8" fill="none" stroke="#4f7cff" stroke-width="2"/>
    <rect x="150" y="286" width="430" height="16" rx="8" fill="none" stroke="#4f7cff" stroke-width="2"/>
    <text x="365" y="48" fill="#4f7cff" font-size="13" text-anchor="middle">RF electrode</text>
    <text x="365" y="324" fill="#4f7cff" font-size="13" text-anchor="middle">RF electrode (drives the spinning saddle, &#x3A9;&#8341;&#8347; &#8776; tens of MHz)</text>
    <!-- DC endcaps -->
    <rect x="120" y="150" width="16" height="60" rx="5" fill="none" stroke="#e0a106" stroke-width="2"/>
    <rect x="594" y="150" width="16" height="60" rx="5" fill="none" stroke="#e0a106" stroke-width="2"/>
    <text x="128" y="232" fill="#e0a106" font-size="12" text-anchor="middle">DC</text>
    <text x="602" y="232" fill="#e0a106" font-size="12" text-anchor="middle">DC</text>
    <!-- ion chain -->
    <line x1="186" y1="180" x2="544" y2="180" stroke="currentColor" stroke-width="1" stroke-dasharray="3 5" opacity="0.45"/>
    <g>
      <circle cx="210" cy="180" r="11" fill="#14b8a6" fill-opacity="0.22" stroke="#14b8a6" stroke-width="2.4"/>
      <circle cx="280" cy="180" r="11" fill="#14b8a6" fill-opacity="0.22" stroke="#14b8a6" stroke-width="2.4"/>
      <circle cx="350" cy="180" r="11" fill="#14b8a6" fill-opacity="0.22" stroke="#14b8a6" stroke-width="2.4"/>
      <circle cx="420" cy="180" r="11" fill="#14b8a6" fill-opacity="0.22" stroke="#14b8a6" stroke-width="2.4"/>
      <circle cx="490" cy="180" r="11" fill="#14b8a6" fill-opacity="0.22" stroke="#14b8a6" stroke-width="2.4"/>
    </g>
    <text x="350" y="135" fill="#14b8a6" font-size="13" text-anchor="middle">linear ion chain &#8212; each a single atom, charge +e</text>
    <!-- shared motional mode: sine + collective arrows -->
    <path d="M186 242 q 17.9 -16 35.8 0 q 17.9 16 35.8 0 q 17.9 -16 35.8 0 q 17.9 16 35.8 0 q 17.9 -16 35.8 0 q 17.9 16 35.8 0 q 17.9 -16 35.8 0 q 17.9 16 35.8 0 q 17.9 -16 35.8 0 q 17.9 16 35.8 0" fill="none" stroke="currentColor" stroke-width="2" opacity="0.65"/>
    <line x1="300" y1="266" x2="260" y2="266" stroke="currentColor" stroke-width="1.4" marker-start="url(#t1a)" marker-end="url(#t1a)" opacity="0.8"/>
    <line x1="470" y1="266" x2="430" y2="266" stroke="currentColor" stroke-width="1.4" marker-start="url(#t1a)" marker-end="url(#t1a)" opacity="0.8"/>
    <text x="365" y="222" fill="currentColor" font-size="13" text-anchor="middle">shared motional mode (phonon) &#8212; the quantum bus every ion plugs into</text>
  </svg>
  <figcaption style="margin-top:.5rem;"><b>Figure 1.</b> A linear Paul trap. Radio-frequency rails (blue) make the rotating saddle that confines the ions sideways; DC endcaps (amber) confine them along the axis. The mutual repulsion of the ions (teal) spreads them into an evenly spaced chain. Crucially, the whole chain vibrates as one: its collective normal modes (the wavy "phonon bus") are shared by every ion, and that shared motion is what entangling gates exploit.</figcaption>
</figure>

**Cooling.** A trapped ion still jiggles thermally, and that motion is the very thing the gates will use, so it must be cold and well-defined. Lasers do the cooling. Doppler cooling — a beam tuned just below an atomic transition, so the ion preferentially absorbs photons when moving toward the beam and gets nudged to a stop — brings it to millikelvin scales; resolved-sideband cooling then removes motional quanta one at a time until the ion sits essentially in its **motional ground state**, a kinetic temperature around a microkelvin. Note what kind of temperature this is: it describes how much the ion is *moving*, not a surrounding bath. And note what it is *not*: there is no dilution refrigerator. The trap sits in ultra-high vacuum, around $10^{-11}$ mbar — roughly a thousand times emptier than the space the ISS flies through — but the apparatus around it runs at room temperature. Vacuum emptier than low orbit, lasers fussing over it around the clock, chilled to a millionth of a degree above absolute zero in its motion: comfortably the most pampered atom in the universe.

**Single-qubit gates** are the easy half. Flip $\vert 0\rangle\leftrightarrow\vert 1\rangle$ on one ion with a resonant pulse: microwaves (or a pair of laser beams driving a stimulated Raman transition) for a hyperfine qubit, a narrow laser for an optical qubit. Tightly focused beams, or distinct microwave near-fields, address one ion at a time.

**Two-qubit gates** are where the genius lives — and where the shared vibration of Figure 1 pays off. You cannot entangle two ions by pushing them at each other directly; they are micrometers apart and you must not heat them. Instead you use their *collective motion* as an intermediary. Because the ions are coupled by their mutual repulsion, the chain has **normal modes** — the whole string sloshing in lockstep (the center-of-mass mode), or stretching and breathing — and each mode is a quantized harmonic oscillator whose excitations are **phonons**. These modes belong to *all* the ions at once. The trick, due first to Cirac and Zoller in 1995 <d-cite key="ciraczoller1995"></d-cite> and refined into the workhorse gate by Mølmer and Sørensen around 1999–2000 <d-cite key="molmer1999multiparticle"></d-cite>, is to make a laser exert a force on each ion *that depends on its internal qubit state* — a **spin-dependent force** — tuned to push on a shared motional mode.

Here is the mechanism, and it is worth slowing down for. Illuminate the two target ions with a **bichromatic** field: two tones placed symmetrically just above and just below the qubit frequency, each detuned by $\delta$ from a motional sideband. Together they produce a force on each ion proportional to its qubit operator $\hat\sigma_x$. Conditioned on the joint spin state, this force pushes the shared motional mode in different directions, sending it on a loop through phase space. The detuning is chosen so that after one gate time $t_{\text{gate}} = 2\pi/\delta$ the loop *closes* — the motion returns exactly to where it started and disentangles itself from the qubits — but the loop has enclosed an area, and that area becomes a **geometric phase** imprinted on the joint spin state. The collective effect is captured by

$$
H_{\text{MS}} \;\propto\; \hat S_x^{\,2}, \qquad \hat S_x \equiv \sum_i \hat\sigma_x^{(i)},
$$

and for two ions $\hat S_x^{\,2} = \hat\sigma_x^{(1)2} + \hat\sigma_x^{(2)2} + 2\,\hat\sigma_x^{(1)}\hat\sigma_x^{(2)}$ — that last cross term is the entangler, turning a product state into a maximally entangled Bell state. The deep virtue, and the reason the Mølmer–Sørensen gate displaced its predecessor, is that because the motion *returns to its starting point* the final entanglement does not depend on how many phonons were in the mode to begin with. The bus can be a little warm and the gate still works. Figure 2 sketches it.

<figure class="l-body" style="text-align:center; margin:1.5rem auto; max-width:680px;">
  <svg viewBox="0 0 720 320" role="img" aria-label="A Mølmer–Sørensen gate. Two teal ions sit at left and right, each shown as a qubit with up and down states. A bichromatic laser, drawn as two beams of slightly different color, illuminates both ions and exerts a state-dependent force. Between the ions a wavy line marks the shared motional mode that mediates the interaction. A small loop below indicates that the motion traces a closed loop in phase space and returns, leaving the two ions entangled." style="width:100%; height:auto; font-family:sans-serif;">
    <defs>
      <marker id="t2a" markerWidth="9" markerHeight="9" refX="4.5" refY="4.5" orient="auto"><path d="M0 0 L9 4.5 L0 9 Z" fill="currentColor"/></marker>
    </defs>
    <!-- bichromatic laser tones from top -->
    <line x1="300" y1="20" x2="345" y2="120" stroke="#ef4444" stroke-width="6" stroke-linecap="round" opacity="0.22"/>
    <line x1="300" y1="20" x2="345" y2="120" stroke="#ef4444" stroke-width="2" stroke-linecap="round"/>
    <line x1="420" y1="20" x2="375" y2="120" stroke="#4f7cff" stroke-width="6" stroke-linecap="round" opacity="0.22"/>
    <line x1="420" y1="20" x2="375" y2="120" stroke="#4f7cff" stroke-width="2" stroke-linecap="round"/>
    <text x="285" y="30" fill="#ef4444" font-size="12" text-anchor="end">&#x3C9;&#8320;&#8722;&#x3B4;</text>
    <text x="435" y="30" fill="#4f7cff" font-size="12" text-anchor="start">&#x3C9;&#8320;+&#x3B4;</text>
    <text x="360" y="52" fill="currentColor" font-size="12.5" text-anchor="middle">bichromatic beams &#8212; a spin-dependent force</text>
    <!-- two ions -->
    <circle cx="200" cy="150" r="16" fill="#14b8a6" fill-opacity="0.22" stroke="#14b8a6" stroke-width="2.6"/>
    <circle cx="520" cy="150" r="16" fill="#14b8a6" fill-opacity="0.22" stroke="#14b8a6" stroke-width="2.6"/>
    <text x="200" y="120" fill="#14b8a6" font-size="13" text-anchor="middle">ion 1</text>
    <text x="520" y="120" fill="#14b8a6" font-size="13" text-anchor="middle">ion 2</text>
    <!-- shared motional mode between them -->
    <path d="M222 150 q 13 -14 26 0 q 13 14 26 0 q 13 -14 26 0 q 13 14 26 0 q 13 -14 26 0 q 13 14 26 0 q 13 -14 26 0 q 13 14 26 0 q 13 -14 26 0 q 13 14 26 0 q 13 -14 26 0" fill="none" stroke="currentColor" stroke-width="2" opacity="0.7"/>
    <text x="360" y="128" fill="currentColor" font-size="12.5" text-anchor="middle">shared motional mode (the bus)</text>
    <!-- phase-space loop -->
    <ellipse cx="360" cy="232" rx="34" ry="22" fill="none" stroke="#e0a106" stroke-width="2"/>
    <path d="M392 226 a 34 22 0 0 1 -8 16" fill="none" stroke="#e0a106" stroke-width="2" marker-end="url(#t2a)"/>
    <text x="360" y="237" fill="#e0a106" font-size="11" text-anchor="middle">motion</text>
    <text x="360" y="296" fill="currentColor" font-size="12.5" text-anchor="middle">the loop closes &#8594; motion left cold, spins entangled (Bell state)</text>
    <!-- entanglement link -->
    <path d="M216 168 q 144 56 288 0" fill="none" stroke="#14b8a6" stroke-width="2" stroke-dasharray="5 4"/>
  </svg>
  <figcaption style="margin-top:.5rem;"><b>Figure 2.</b> The Mølmer–Sørensen gate. Two laser tones, detuned by $\delta$ above and below the qubit frequency, drive a force on each ion that depends on its spin. That force pushes a <em>shared</em> motional mode (the bus) around a closed loop in phase space; after time $t_{\text{gate}}=2\pi/\delta$ the motion returns to where it began — leaving it cold and uncorrelated with the qubits — while a geometric phase $H_{\text{MS}}\propto \hat S_x^{\,2}$ entangles the two internal states. Because the loop closes, the result barely cares how warm the bus was.</figcaption>
</figure>

The payoff of routing entanglement through a *shared* bus is **all-to-all connectivity**: every ion in the chain couples to the same collective modes, so any pair can be entangled directly, with no need to relay the state through a chain of intermediate neighbors. It is a group chat, not a corporate phone tree where every call is transferred desk to desk. Shorter circuits mean fewer operations, and fewer operations mean fewer chances to fail — a structural advantage we will weigh against the platform's structural curse, slowness, in a moment.

## Where it shines

Three numbers do most of the arguing for trapped ions: their fidelities, their coherence, and their connectivity. Read carefully, because the precision here is the whole point.

**Fidelity that strains belief.** A single-qubit gate is the operation ions do most flawlessly. Back in 2014 the Lucas group at Oxford demonstrated single-qubit gates on $^{43}\mathrm{Ca}^+$ with an error of about $1\times10^{-6}$ — "six nines," one slip in a million <d-cite key="harty2014highfidelity"></d-cite>. In June 2025 the same effort pushed that to an error of $1.5\times10^{-7}$, roughly **one error in 6.7 million operations** <d-cite key="smith2025singlequbit"></d-cite> — to put it in human terms, a typist that accurate could retype every Harry Potter book back to back and still, on average, not expect a single typo. Both records use *microwave* control rather than lasers, which sidesteps a fundamental laser-scattering error floor.

The honest practice, which separates careful people from press releases, is to keep the single-qubit and two-qubit records strictly apart, because the two-qubit gate is much harder. Its lab record has marched from $99.9\%$ in 2016 <d-cite key="ballance2016highfidelity"></d-cite> to above $99.99\%$ — past "four nines" — in 2025, again via all-electronic control <d-cite key="ionq2025twoqubit"></d-cite>. And on a *commercial, all-to-all* machine the best two-qubit fidelity is $99.921\%$, on Quantinuum's Helios <d-cite key="quantinuum2025helios"></d-cite>. Notice these are different categories of claim — single vs two-qubit, laboratory hero-run vs full-machine spec — and conflating them is the most common way trapped-ion marketing is misread. Much of this precision traces straight back to the identical-atoms point: when every qubit is the same atom with the same frequency, you are not fighting fabrication spread, and all-to-all connectivity keeps your circuits short.

**Coherence measured in minutes.** Where a transmon forgets in a fraction of a millisecond, an ion remembers for an almost comic length of time. A single $^{171}\mathrm{Yb}^+$ ion at Tsinghua (Kihwan Kim's group) held a quantum state coherent for more than **ten minutes** — about $660$ s — measured, in 2017 <d-cite key="wang2017tenminute"></d-cite>. In 2021 the same group reported an **estimated** coherence time exceeding **one hour** ($\approx 5500$ s) <d-cite key="wang2021onehour"></d-cite>; be precise that this number is extrapolated from data taken to under a thousand seconds, not a direct hour-long measurement. (A 2026 preprint from the same group pushes a two-ion decoherence-free-subspace encoding to an extrapolated $\sim 10.5$ hours <d-cite key="pi2026dfs"></d-cite> — striking, but a preprint, and again an extrapolation.) The joke writes itself: the atom remembers its own quantum state for the better part of a day, while I cannot reliably remember where I left my keys. The serious version of the joke is the entire reason ions make good network nodes, which we come to below.

**All-to-all connectivity**, already met in Figure 2, completes the case: any pair entangles directly. Taken together — record fidelities, minutes of coherence, full connectivity — these are exactly the properties you want if you care about *quality* of computation over raw speed and scale.

## The honest costs

Now settle the bill, because the same physics that buys all that precision charges for it.

**The gates are slow.** A two-qubit ion gate takes **microseconds** — sometimes longer; the careful 2016 record reached its $99.9\%$ fidelity at a $100\,\mu\text{s}$ gate time (with gates characterized out to $520\,\mu\text{s}$), and even fast ones live in the tens-of-microseconds range <d-cite key="ballance2016highfidelity"></d-cite> — against the **tens of nanoseconds** of a superconducting gate (Google's run around $25$–$34$ ns) <d-cite key="google2023surface"></d-cite>. That is roughly **100 to 1000 times slower**. The slowness is not incidental; it is structural. Entangling through a motional sideband is a weak process: the coupling is the bare laser Rabi frequency $\Omega$ reduced by the small **Lamb–Dicke parameter** $\eta\ll 1$ that measures how strongly light couples to the ion's motion, and the gate must also be slow enough to spectrally resolve a single motional mode and let its phase-space loop close. Both pressures push the gate time toward

$$
t_{\text{gate}} \;\sim\; \frac{2\pi}{\delta} \;\sim\; \frac{1}{\eta\,\Omega},
$$

which lands in microseconds. No clever pulse erases that scale entirely. And before anyone tries to sell slow gates as a feature: they are not, and you should be suspicious of anyone who says so. The honest counter is subtler and more interesting — what ultimately matters is not raw gate speed but **how many useful operations you complete before an error creeps in**, and very long coherence times multiplied by very high fidelities buy you an enormous number of those. It is the tortoise: slower per step, far fewer missteps, and it is the marathon, not the sprint, that quantum algorithms run.

**Scaling one chain is hard.** You cannot simply keep adding ions to a single string. The more ions share a trap, the denser and softer their motional spectrum becomes: modes crowd together, become harder to address individually, heat more easily, and slow the gates further. Today's leading single-chain machines hold only on the order of a hundred ions. Two escape routes are under active construction, and they map neatly onto the field's two leading companies. The first is the **QCCD** ("quantum charge-coupled device") architecture: physically *shuttle* ions between dedicated storage and interaction zones on a segmented chip, so every gate happens in a small, well-behaved group of two or three ions — Quantinuum's bet. The second is **photonic interconnect**: build many small, excellent traps and stitch them into one modular machine using photons — the same ion-emits-a-photon trick that, as we are about to see, also makes ions natural network nodes. This is IonQ's bet.

**Lasers and vacuum, everywhere.** A trapped-ion system is an optics cathedral. Each species needs a small orchestra of frequency-stabilized lasers — for cooling, state preparation, gates, and readout — plus the ultra-high vacuum ($\sim 10^{-11}$ mbar) that keeps stray gas molecules from knocking the ion out of the trap, plus electrode surfaces clean enough to suppress "anomalous heating," the stubborn, not-fully-understood noise that warms the motional modes the gates depend on. There is no dilution fridge, which is a real relief next to superconducting; but "room-temperature vacuum chamber wrapped in lasers" is not exactly a laptop either. Different cathedral, comparable upkeep.

## State of the art

The trapped-ion scoreboard is less about raw qubit counts — the headline-grabbing flex of the superconducting world — and more about fidelity, error correction, and the first real steps toward networking. Read each result for what it is.

**Quantinuum.** Honeywell's quantum unit merged with Cambridge Quantum to form Quantinuum, and its QCCD H-series has spent years quietly setting records — particularly in **quantum volume**, a whole-machine benchmark that rewards quality and connectivity rather than mere qubit count. In November 2025 it launched **Helios**: 98 physical qubits, the first commercial machine built on $^{137}\mathrm{Ba}^+$ (barium's visible $493$ nm light is kinder to optics and fiber than ytterbium's ultraviolet), with all-to-all connectivity, a single-qubit fidelity of $99.9975\%$ and a two-qubit fidelity of $99.921\%$ across all pairs <d-cite key="quantinuum2025helios"></d-cite>. It also exposed dozens of *logical* qubits — including 48 fully error-corrected ones — on top of those 98 physical ones. That last number matters more than the first: it is encoded qubits, the currency of fault tolerance, not just more raw atoms. Earlier, in 2024, a Microsoft–Quantinuum collaboration ran error correction on H2 hardware and reported logical error rates **11 to 800 times** below the matching physical baselines, across experiments using up to 12 logical qubits — results since validated in a peer-reviewed 2026 paper <d-cite key="microsoft2024logical"></d-cite>. The caveat that keeps it honest: an 800-fold improvement over a physical baseline is a demonstration of *better-than-physical encoded operations* on a handful of logical qubits, not a fault-tolerant computer — the prerequisite, not the destination.

**IonQ.** The other commercial heavyweight, IonQ pursues the modular, photonically-networked path. It long ran on $^{171}\mathrm{Yb}^+$ and has since moved to **barium**, whose friendlier wavelengths ease both optics and the photonic links its architecture depends on; its barium "Tempo" system reached a milestone benchmark in 2025 <d-cite key="ionq2025barium"></d-cite>. IonQ (via its acquisition of Oxford Ionics) also holds the laboratory two-qubit fidelity record above $99.99\%$ noted earlier, achieved with all-electronic control <d-cite key="ionq2025twoqubit"></d-cite>.

**The academic record-setters.** Behind the companies sit the labs that set the fidelity ceilings — Oxford's single-qubit results at the $10^{-7}$ level <d-cite key="smith2025singlequbit"></d-cite>, and the long lineage from NIST, where the *first* quantum logic gate of any kind was demonstrated in 1995 between the internal and motional states of a single $^{9}\mathrm{Be}^+$ ion <d-cite key="monroe1995logicgate"></d-cite>. The field's pedigree is hard to overstate: Paul shared the 1989 Nobel for the trap itself <d-cite key="nobel1989iontrap"></d-cite>, and David Wineland shared the 2012 Nobel for the trapped-ion quantum control that made all of this possible <d-cite key="nobel2012wineland"></d-cite>. The usual three caveats apply to every number above — a lab hero-run is not an in-machine median, a single-qubit gate is not a two-qubit gate, and a physical qubit is not a logical one — and trapped-ion practitioners, to their credit, tend to be unusually scrupulous about saying so.

## Where it sits

A trapped ion is a **slow, fussy, ferociously precise** qubit — and, almost uniquely, one that is equally credible as a quantum *memory*, a quantum *processor*, and a quantum *network node*. That triple identity is the through-line of this whole platform: store a state and the ion is a memory; entangle two and it is a processor; let one breathe out a photon and it is a node. The same charged speck of matter, held in nothing, does all three jobs we normally build separate machines for.

That networking role is not a footnote here — it is a genuine strength, and the reason this series keeps one eye on whether a qubit can *network* as well as compute. A superconducting qubit speaks in microwave photons that cannot travel down an optical fiber, so linking two of them over distance demands a lossy microwave-to-optical translation step that nobody has yet made work well. An ion has no such problem: it natively *emits an optical photon entangled with its own internal state*. Catch that photon, send it down a fiber, interfere it with a photon from a distant ion, and a successful measurement leaves the two faraway ions entangled — having never touched. This is demonstrated physics, not a hope: two ions about a metre apart were heralded into entanglement by Monroe's group back in 2007 <d-cite key="moehring2007entanglement"></d-cite>, and in 2023 an Innsbruck team entangled two ions in separate buildings across **520 m of fiber** (230 m apart) at about $88\%$ fidelity <d-cite key="krutyanskiy2023entanglement"></d-cite>. An ion that remembers for minutes *and* can hand its state to a photon is precisely the ingredient a quantum repeater — the backbone of any future quantum internet — is built from. For a researcher who cares about quantum *networks*, this is the row that matters most.

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
