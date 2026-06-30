---
layout: distill
title: "Superconducting qubits: the circuit that fakes an atom"
description: "Cool a printed-circuit chip colder than deep space and it starts impersonating an atom — here is how that fake atom became quantum computing's loudest, fastest, most milestone-heavy front-runner, and what it still cannot do."
date: 2026-06-30
tags: quantum superconducting transmon
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
  - name: What a superconducting qubit is
  - name: How it is built and controlled
  - name: Why it is a front-runner
  - name: The honest costs
  - name: State of the art
  - name: Where it sits
---

*Part of the [How to Build a Quantum Computer](/blog/2026/how-to-build-a-quantum-computer/) series.*

Most qubit platforms spend enormous effort trying to *catch* a real atom — trapping it with lasers, levitating it in a vacuum, holding their breath so it does not drift away. Superconducting qubits do the opposite. They build the atom. You pattern a little circuit onto a wafer with the same lithography that prints classical processors, cool it to a whisker above absolute zero, and the circuit politely starts behaving like an atom: discrete energy levels, quantized transitions, the works. This is the route Google and IBM bet on, and it is the loudest, best-funded lane in the field. It is also, at its core, faintly absurd — one of humanity's most advanced computers runs on a *fake atom* that is far bigger than a real one. Let us take the joke seriously, because the physics underneath it is genuinely beautiful.

## What a superconducting qubit is

Start with the question every qubit platform has to answer: *what makes a good two-level system?* A real atom is a good qubit because its electrons can only occupy a few discrete energy levels. Pick the lowest two, call them $\vert 0\rangle$ and $\vert 1\rangle$, and you have somewhere to store a bit of quantum information. The thing a superconducting qubit must reproduce is precisely that **discreteness** — and, less obviously, an *uneven* spacing between the levels.

Here is why evenness is fatal. The simplest superconducting circuit that oscillates is an **LC resonator**: an inductor $L$ and a capacitor $C$ trading energy back and forth, like a mass on a spring. Quantize it and its Hamiltonian (its energy written as a quantum operator) is the textbook harmonic oscillator,

$$
H_{LC} = \frac{\hat Q^2}{2C} + \frac{\hat\Phi^2}{2L}, \qquad E_n = \hbar\omega\left(n+\tfrac{1}{2}\right), \quad \omega = \frac{1}{\sqrt{LC}} .
$$

The energy levels form a perfectly even ladder: every rung is separated by the same $\hbar\omega$. That sounds tidy, and it is exactly the problem. If you send in a microwave pulse tuned to drive $\vert 0\rangle\to\vert 1\rangle$, that same pulse is *equally* resonant with $\vert 1\rangle\to\vert 2\rangle$, $\vert 2\rangle\to\vert 3\rangle$, and on up the ladder — so trying to flip your bit just keeps climbing the excitation straight out of the computational subspace. A harmonic oscillator, for all its elegance, makes a hopeless qubit. You need a ladder whose rungs are *unequally* spaced, so that a pulse resonant with $0\to1$ is detuned from $1\to2$ and leaves the higher levels alone.

<figure class="l-body" style="text-align:center; margin:1.5rem auto; max-width:720px;">
  <svg viewBox="0 0 720 360" role="img" aria-label="Two energy-level ladders side by side. The LC oscillator on the left has four evenly spaced levels labelled 0 to 3, with both the 0-to-1 and 1-to-2 gaps marked as equal h-bar omega. The transmon on the right has levels whose spacing shrinks with energy; the lowest two levels are highlighted as the qubit, the 0-to-1 gap is h-bar omega-01 and the smaller 1-to-2 gap is h-bar omega-01 minus the magnitude of alpha." style="width:100%; height:auto; font-family:sans-serif;">
    <defs>
      <marker id="f1ah" markerWidth="8" markerHeight="8" refX="4" refY="4" orient="auto"><path d="M0 0 L8 4 L0 8 Z" fill="currentColor"/></marker>
    </defs>
    <line x1="40" y1="322" x2="40" y2="118" stroke="currentColor" stroke-width="1.5" marker-end="url(#f1ah)"/>
    <text x="26" y="222" fill="currentColor" font-size="14" transform="rotate(-90 26 222)" text-anchor="middle">Energy</text>
    <polyline points="110,120 130,223 150,284 170,305 190,284 210,223 230,120" fill="none" stroke="currentColor" stroke-width="1.4" stroke-dasharray="4 4" opacity="0.4"/>
    <line x1="127" y1="295" x2="213" y2="295" stroke="currentColor" stroke-width="2"/>
    <line x1="127" y1="248" x2="213" y2="248" stroke="currentColor" stroke-width="2"/>
    <line x1="127" y1="201" x2="213" y2="201" stroke="currentColor" stroke-width="2"/>
    <line x1="127" y1="154" x2="213" y2="154" stroke="currentColor" stroke-width="2"/>
    <text x="221" y="299" fill="currentColor" font-size="13">|0&#x27E9;</text>
    <text x="221" y="252" fill="currentColor" font-size="13">|1&#x27E9;</text>
    <text x="221" y="205" fill="currentColor" font-size="13">|2&#x27E9;</text>
    <text x="221" y="158" fill="currentColor" font-size="13">|3&#x27E9;</text>
    <line x1="105" y1="295" x2="105" y2="248" stroke="currentColor" stroke-width="1.3" marker-start="url(#f1ah)" marker-end="url(#f1ah)"/>
    <line x1="105" y1="248" x2="105" y2="201" stroke="currentColor" stroke-width="1.3" marker-start="url(#f1ah)" marker-end="url(#f1ah)"/>
    <text x="70" y="276" fill="currentColor" font-size="13">&#x210F;&#x03C9;</text>
    <text x="70" y="229" fill="currentColor" font-size="13">&#x210F;&#x03C9;</text>
    <text x="170" y="345" fill="currentColor" font-size="15" text-anchor="middle" font-weight="600">LC oscillator &#8212; harmonic</text>
    <polyline points="450,150 473,211 495,261 518,294 540,305 563,294 585,261 608,211 630,150" fill="none" stroke="currentColor" stroke-width="1.4" stroke-dasharray="4 4" opacity="0.4"/>
    <line x1="497" y1="295" x2="583" y2="295" stroke="#14b8a6" stroke-width="2.6"/>
    <line x1="497" y1="248" x2="583" y2="248" stroke="#14b8a6" stroke-width="2.6"/>
    <line x1="497" y1="210" x2="583" y2="210" stroke="currentColor" stroke-width="2"/>
    <line x1="497" y1="182" x2="583" y2="182" stroke="currentColor" stroke-width="2"/>
    <text x="591" y="299" fill="#14b8a6" font-size="13">|0&#x27E9;</text>
    <text x="591" y="252" fill="#14b8a6" font-size="13">|1&#x27E9;</text>
    <text x="591" y="214" fill="currentColor" font-size="13">|2&#x27E9;</text>
    <text x="591" y="186" fill="currentColor" font-size="13">|3&#x27E9;</text>
    <path d="M621 247 h6 v50 h-6" fill="none" stroke="#14b8a6" stroke-width="1.5"/>
    <text x="634" y="276" fill="#14b8a6" font-size="12">qubit</text>
    <line x1="475" y1="295" x2="475" y2="248" stroke="currentColor" stroke-width="1.3" marker-start="url(#f1ah)" marker-end="url(#f1ah)"/>
    <text x="423" y="276" fill="currentColor" font-size="13">&#x210F;&#x03C9;&#8320;&#8321;</text>
    <line x1="475" y1="248" x2="475" y2="210" stroke="#e0a106" stroke-width="1.3" marker-start="url(#f1ah)" marker-end="url(#f1ah)"/>
    <text x="402" y="232" fill="#e0a106" font-size="12">&#x210F;&#x03C9;&#8320;&#8321;&#8722;|&#x03B1;|</text>
    <text x="540" y="345" fill="currentColor" font-size="15" text-anchor="middle" font-weight="600">Transmon &#8212; anharmonic</text>
  </svg>
  <figcaption style="margin-top:.5rem;"><b>Figure 1.</b> A harmonic LC oscillator (left) has evenly spaced levels, so any pulse that drives $0\to1$ also drives $1\to2$ and leaks the state upward. The transmon (right) sits in a cosine potential whose rungs bunch together with energy: the $1\to2$ transition is detuned from $0\to1$ by the anharmonicity $\alpha$, isolating the lowest two levels (teal) as a clean qubit. (The shrinkage is exaggerated for visibility; a real transmon's anharmonicity is only a few percent of $\omega_{01}$.)</figcaption>
</figure>

The other half of the picture is what is actually doing the oscillating. It is tempting to imagine one lonely electron sloshing around, but the truth is stranger and more wonderful. Below its critical temperature the metal becomes a **superconductor**, and its conduction electrons pair up into **Cooper pairs** that condense into a single coherent quantum state — billions of charge carriers described by *one* macroscopic wavefunction, marching in lockstep. The "atom" you have built is enormous: a collective quantum object the size of a circuit, behaving as if it were a single particle with discrete energy levels. The 2025 Nobel Prize in Physics went to John Clarke, Michel Devoret, and John Martinis for the 1980s experiments that nailed down exactly this — that a macroscopic electrical circuit can tunnel and occupy quantized energy levels like a single quantum object <d-cite key="clarke2025nobel"></d-cite>. So before your circuit computes anything, it has already earned a remarkable certificate: it is genuinely, measurably quantum. Congratulations to your circuit.

## How it is built and controlled

The component that turns a boring LC resonator into a usable artificial atom is the **Josephson junction**: two superconductors separated by an insulating barrier a couple of nanometers thick. Cooper pairs tunnel coherently across that gap, and Brian Josephson's 1962 prediction <d-cite key="josephson1962possible"></d-cite> tells you how. If the algebra below blurs together, here is the one fact to carry past it: this junction is the only *nonlinear* element in the circuit, and that nonlinearity is why the energy ladder can come out uneven. The supercurrent through the junction and the voltage across it obey

$$
I = I_c \sin\phi, \qquad V = \frac{\hbar}{2e}\,\frac{d\phi}{dt},
$$

where $\phi$ is the quantum phase difference across the junction and $I_c$ is its critical current. Integrate the voltage relation and you find the junction stores energy as a function of phase:

$$
U(\phi) = -E_J\cos\phi, \qquad E_J = \frac{\hbar I_c}{2e} = \frac{I_c\,\Phi_0}{2\pi},
$$

with $\Phi_0 = h/2e$ the flux quantum. That cosine is the whole trick. A linear inductor stores energy as $\tfrac12\Phi^2/L$ — a parabola, which gives the even ladder. The junction behaves like a *nonlinear* inductor, and the curvature of $-E_J\cos\phi$ changes as you climb it. Expand it about the bottom of the well:

$$
-E_J\cos\phi \;=\; -E_J + \tfrac{1}{2}E_J\,\phi^2 - \tfrac{1}{24}E_J\,\phi^4 + \cdots
$$

The quadratic term is just a harmonic oscillator (even rungs); the quartic term is the anharmonicity that squeezes the rungs together as the energy rises — exactly the unevenness Figure 1 demanded.

Putting the junction in parallel with a capacitor gives the **transmon**, the design Jens Koch and colleagues introduced at Yale in 2007 <d-cite key="koch2007transmon"></d-cite> and still the workhorse of the field. The design collapses onto a single dimensionless knob — the ratio $E_J/E_C$, set by how large you make the capacitor. Its Hamiltonian is

$$
H = 4E_C\,(\hat n - n_g)^2 - E_J\cos\hat\phi,
$$

where $\hat n$ counts Cooper pairs that have crossed the junction, $\hat\phi$ is the conjugate phase, $E_J$ is the Josephson energy above, and $E_C = e^2/2C_\Sigma$ is the charging energy set by the total capacitance. Treating the cosine to leading order, the qubit frequency and the anharmonicity come out as

$$
\hbar\omega_{01} \approx \sqrt{8E_J E_C} - E_C, \qquad \alpha \equiv \hbar(\omega_{12}-\omega_{01}) \approx -E_C .
$$

To put numbers on it: a typical transmon runs with $E_J/h \sim 15$–$20$ GHz and $E_C/h \sim 0.2$–$0.3$ GHz, so $\omega_{01}/2\pi \approx 5$ GHz while the anharmonicity $\lvert\alpha\rvert/2\pi$ is only about 200–300 MHz — a few percent of the transition frequency. That sliver of unevenness is the entire margin separating a working qubit from a leaky oscillator, which is why "small anharmonicity" is a phrase the field says nervously.

<figure class="l-body" style="text-align:center; margin:1.5rem auto; max-width:640px;">
  <svg viewBox="100 0 540 320" role="img" aria-label="Transmon circuit schematic: a closed loop with a large shunt capacitor on the left branch and a Josephson junction, drawn as a box with a diagonal cross, on the right branch. A dot on the top wire and a dot on the bottom wire mark the two superconducting islands. A microwave drive line, labelled about 5 gigahertz, couples capacitively to the circuit from the lower left. A label notes the transmon regime, E_J over E_C much greater than one." style="width:100%; height:auto; font-family:sans-serif;">
    <line x1="250" y1="80" x2="470" y2="80" stroke="currentColor" stroke-width="2"/>
    <line x1="250" y1="240" x2="470" y2="240" stroke="currentColor" stroke-width="2"/>
    <line x1="250" y1="80" x2="250" y2="146" stroke="currentColor" stroke-width="2"/>
    <line x1="250" y1="174" x2="250" y2="240" stroke="currentColor" stroke-width="2"/>
    <line x1="214" y1="146" x2="286" y2="146" stroke="currentColor" stroke-width="2.4"/>
    <line x1="214" y1="174" x2="286" y2="174" stroke="currentColor" stroke-width="2.4"/>
    <text x="150" y="166" fill="currentColor" font-size="15">C<tspan font-size="11" dy="4">&#x3A3;</tspan></text>
    <text x="120" y="186" fill="currentColor" font-size="11.5">shunt cap</text>
    <line x1="470" y1="80" x2="470" y2="132" stroke="currentColor" stroke-width="2"/>
    <line x1="470" y1="188" x2="470" y2="240" stroke="currentColor" stroke-width="2"/>
    <rect x="442" y="132" width="56" height="56" rx="4" fill="none" stroke="#14b8a6" stroke-width="2.2"/>
    <line x1="442" y1="132" x2="498" y2="188" stroke="#14b8a6" stroke-width="2.2"/>
    <line x1="498" y1="132" x2="442" y2="188" stroke="#14b8a6" stroke-width="2.2"/>
    <text x="512" y="153" fill="#14b8a6" font-size="15">Josephson</text>
    <text x="512" y="172" fill="#14b8a6" font-size="15">junction</text>
    <text x="512" y="191" fill="currentColor" font-size="12.5">E<tspan font-size="10" dy="3">J</tspan><tspan dy="-3">, C</tspan><tspan font-size="10" dy="3">J</tspan></text>
    <circle cx="360" cy="80" r="3.4" fill="currentColor"/>
    <circle cx="360" cy="240" r="3.4" fill="currentColor"/>
    <text x="360" y="70" fill="currentColor" font-size="11.5" text-anchor="middle">island</text>
    <text x="360" y="258" fill="currentColor" font-size="11.5" text-anchor="middle">island</text>
    <path d="M120 240 c4 -11 12 -11 16 0 c4 11 12 11 16 0 c4 -11 12 -11 16 0 c4 11 12 11 16 0" fill="none" stroke="#4f7cff" stroke-width="2"/>
    <line x1="184" y1="240" x2="192" y2="240" stroke="#4f7cff" stroke-width="2"/>
    <line x1="192" y1="228" x2="192" y2="252" stroke="#4f7cff" stroke-width="2.2"/>
    <line x1="200" y1="228" x2="200" y2="252" stroke="#4f7cff" stroke-width="2.2"/>
    <line x1="200" y1="240" x2="250" y2="240" stroke="#4f7cff" stroke-width="2"/>
    <text x="158" y="272" fill="#4f7cff" font-size="11.5" text-anchor="middle">~5 GHz drive</text>
    <text x="360" y="290" fill="currentColor" font-size="14" text-anchor="middle">transmon regime: &#160; E<tspan font-size="10.5" dy="3">J</tspan><tspan dy="-3"> / E</tspan><tspan font-size="10.5" dy="3">C</tspan><tspan dy="-3" font-size="14"> &#8811; 1</tspan></text>
  </svg>
  <figcaption style="margin-top:.5rem;"><b>Figure 2.</b> The transmon: a Josephson junction (the box-and-cross symbol, a nonlinear inductor) shunted by a large capacitor. A dot marks each of the two superconducting **islands**, whose Cooper-pair imbalance is the operator $\hat n$; a microwave line couples in capacitively to drive the qubit, while readout happens separately, through a dispersively coupled resonator (below). Running deep in the regime $E_J/E_C \gg 1$ flattens the qubit's sensitivity to stray charge noise.</figcaption>
</figure>

Why "transmon" rather than the earlier **Cooper pair box**, the very first solid-state qubit, demonstrated by Nakamura and colleagues in 1999 <d-cite key="nakamura1999coherent"></d-cite>? The Cooper pair box ran at small $E_J/E_C$, where the levels are wonderfully anharmonic but agonizingly sensitive to stray electric charge — a single drifting electron on a nearby surface would yank the qubit frequency around and dephase it in nanoseconds. Koch's insight was that pushing the capacitor large, into $E_J/E_C \gg 1$ (today typically 50–100), suppresses that charge sensitivity *exponentially* while costing you only a *polynomially* small anharmonicity <d-cite key="koch2007transmon"></d-cite>. You give up a little of the unevenness you fought to get, and in exchange the qubit stops caring about charge noise. That trade — quantified in one 2007 paper — is why essentially every large superconducting processor today is built from transmons.

<figure class="l-body" style="text-align:center; margin:1.5rem auto; max-width:680px;">
  <svg viewBox="0 0 720 360" role="img" aria-label="Two schematic curves versus the ratio E_J over E_C on a logarithmic axis from 1 to 100. A red charge-sensitivity curve starts high at small ratio and crashes exponentially toward zero by a ratio of about ten. A teal anharmonicity curve starts high and declines only gently, polynomially, across the whole range. A shaded blue band near 50 to 100 marks the transmon sweet spot; the small-ratio end is labelled the Cooper-pair box, very anharmonic but charge-noisy." style="width:100%; height:auto; font-family:sans-serif;">
    <rect x="574" y="48" width="86" height="252" fill="#4f7cff" fill-opacity="0.18" stroke="#4f7cff" stroke-width="1" stroke-dasharray="3 3"/>
    <text x="617" y="38" fill="#4f7cff" font-size="12" text-anchor="middle">transmon</text>
    <text x="617" y="52" fill="#4f7cff" font-size="12" text-anchor="middle">sweet spot</text>
    <line x1="80" y1="300" x2="680" y2="300" stroke="currentColor" stroke-width="1.4"/>
    <line x1="80" y1="300" x2="80" y2="45" stroke="currentColor" stroke-width="1.4"/>
    <text x="60" y="175" fill="currentColor" font-size="12" transform="rotate(-90 60 175)" text-anchor="middle">relative magnitude</text>
    <line x1="90" y1="300" x2="90" y2="305" stroke="currentColor" stroke-width="1.2"/>
    <text x="90" y="318" fill="currentColor" font-size="11" text-anchor="middle">1</text>
    <line x1="226" y1="300" x2="226" y2="305" stroke="currentColor" stroke-width="1.2"/>
    <text x="226" y="318" fill="currentColor" font-size="11" text-anchor="middle">3</text>
    <line x1="375" y1="300" x2="375" y2="305" stroke="currentColor" stroke-width="1.2"/>
    <text x="375" y="318" fill="currentColor" font-size="11" text-anchor="middle">10</text>
    <line x1="511" y1="300" x2="511" y2="305" stroke="currentColor" stroke-width="1.2"/>
    <text x="511" y="318" fill="currentColor" font-size="11" text-anchor="middle">30</text>
    <line x1="660" y1="300" x2="660" y2="305" stroke="currentColor" stroke-width="1.2"/>
    <text x="660" y="318" fill="currentColor" font-size="11" text-anchor="middle">100</text>
    <text x="382" y="346" fill="currentColor" font-size="13" text-anchor="middle">E<tspan font-size="9.5" dy="3">J</tspan><tspan dy="-3"> / E</tspan><tspan font-size="9.5" dy="3">C</tspan><tspan dy="-3">&#160; (log scale)</tspan></text>
    <polyline points="90,70 118,104 140,162 176,222 226,266 289,291 375,299 480,300 660,300" fill="none" stroke="#ef4444" stroke-width="2.6"/>
    <polyline points="90,70 150,112 226,150 300,182 375,202 450,219 511,231 574,243 660,252" fill="none" stroke="#14b8a6" stroke-width="2.6"/>
    <line x1="220" y1="66" x2="248" y2="66" stroke="#ef4444" stroke-width="2.6"/>
    <text x="254" y="70" fill="currentColor" font-size="12.5">charge sensitivity &#8212; crashes exponentially</text>
    <line x1="220" y1="90" x2="248" y2="90" stroke="#14b8a6" stroke-width="2.6"/>
    <text x="254" y="94" fill="currentColor" font-size="12.5">anharmonicity &#124;&#x03B1;&#124;/&#x03C9;&#8320;&#8321; &#8212; falls only polynomially</text>
    <text x="175" y="290" fill="currentColor" font-size="11.5" text-anchor="middle">&#8592; Cooper-pair box (charge-noisy)</text>
  </svg>
  <figcaption style="margin-top:.5rem;"><b>Figure 3.</b> The trade that makes the transmon: pushing $E_J/E_C$ to $\approx 50$–$100$ buys near-total immunity to charge noise (red) for the price of a modestly smaller anharmonicity (teal). The far-left corner — sharply anharmonic but charge-noisy — is the original Cooper-pair box. (Vertical scale is schematic.)</figcaption>
</figure>

Two engineering facts about how the thing is made and cooled seed every later virtue and vice:

- **Fabrication.** Aluminum, niobium, or tantalum films on silicon or sapphire, patterned by the same lithography that makes CPUs. Because no two thin oxide barriers come out identical, every junction is a little different — each qubit is a snowflake with its own frequency, needing its own calibration. Hold that thought; it comes due in the cost section.
- **Refrigeration.** The chip lives at the bottom of a dilution refrigerator at roughly **10–20 millikelvin** — over a hundred times colder than the 2.7 K cosmic microwave background. Only that cold makes the metal superconduct *and* quiets thermal noise enough for quantum behavior to survive. That chandelier of gold-plated plates you have seen in every quantum-computing press photo is the fridge, and it is fussier than any wine cellar.

To **operate** the qubit you send microwave pulses — typically near 5 GHz, resonant with $\omega_{01}$ — down a control line. A calibrated pulse a few tens of nanoseconds long rotates $\vert 0\rangle\leftrightarrow\vert 1\rangle$ (a single-qubit gate). The anharmonicity sets a hard speed limit: a gate cannot run much faster than about $1/\lvert\alpha\rvert$ — a few nanoseconds — without driving population up into $\vert 2\rangle$, so pulses are deliberately shaped (the standard trick, *DRAG*, adds an out-of-phase component that cancels the leakage) to stay inside the qubit subspace.

Two-qubit gates split the field into two camps, and the split explains why an IBM chip and a Google chip look so different despite using the same transmon. Google and many others make their qubits **frequency-tunable**: they replace the single junction with a two-junction **SQUID** loop whose effective $E_J$ — and hence $\omega_{01}$ — is set by a magnetic flux threaded through it, then entangle a pair by briefly tuning the two into resonance (or through a tunable coupler) to run a fast CZ or iSWAP gate. IBM takes the other road — **fixed-frequency** transmons driven purely by microwaves, entangled through the **cross-resonance** effect: drive one qubit at its neighbor's frequency and the pair picks up a conditional rotation, no tuning required. Tunability buys speed; fixed frequency buys immunity to flux noise. You pay for whichever knob you keep.

One more operation, and it is the one the build-it story usually forgets: you have to **read the answer out**. You do not measure the transmon directly — you couple it to a separate microwave **readout resonator** and work in the *dispersive* regime, where qubit and resonator are far detuned. There the qubit's state pulls the resonator's frequency one way for $\vert 0\rangle$ and the other for $\vert 1\rangle$ (a shift $\pm\chi$), so you bounce a probe tone off the resonator, read the phase it returns with, and learn the qubit state without ever landing a real photon on the qubit. This whole framework — artificial atoms exchanging microwave photons with a cavity — is **circuit quantum electrodynamics (circuit QED)**, the architecture the field is built on. Readout is the slowest, noisiest step in the stack (hundreds of nanoseconds, around ~99% fidelity), which is why it looms large in every error budget and why each chip carries Purcell filters (which keep the qubit from radiating away down its readout line) and near-quantum-limited amplifiers to pull the signal out faster and cleaner.

## Why it is a front-runner

Superconducting qubits lead the field for three reasons that all trace back to that fabrication-and-control story: they are **fast, manufacturable, and crowded**.

**Fast.** Gate times are tens of nanoseconds. Google's processors, for instance, run single-qubit gates in about **25 ns** and two-qubit (CZ) gates in about **34 ns** <d-cite key="google2023surface"></d-cite>; across the field single-qubit gates land in the ~10–50 ns range and two-qubit gates around ~25–70 ns. That is roughly **100 to 1000 times faster than trapped-ion gates**, which take microseconds <d-cite key="ballance2016highfidelity"></d-cite>. In quantum computing, speed is hard currency: coherence is finite, so the faster each gate, the more operations you finish before the qubit forgets. Put concretely, a ~30 ns gate against a ~100 µs coherence time leaves room for only a few thousand operations before the state blurs — which is exactly why per-gate error has to be driven toward $10^{-3}$ and below, and why error correction is not optional but structural.

**Manufacturable.** Because qubits are *printed*, the whole apparatus of semiconductor manufacturing — lithography, integration, on-chip wiring, foundry processes — is available. Scaling up means making a bigger chip, not building a bigger laser-and-vacuum cathedral. This is why the raw qubit-count records belong to this platform, and why IBM, Google, and a crowd of startups can iterate on hardware every year.

**Crowded.** Nearly every quantum-computing headline of the past decade debuted on superconducting hardware, which means a deep, fast-moving ecosystem of tools, talent, and money. Fidelities reflect the maturity: Google's Willow processor reports single-qubit gate fidelity around **99.97%** and a best-case two-qubit (CZ) fidelity around **99.88%**, each benchmarked one gate at a time <d-cite key="google2024willow"></d-cite>. Those numbers are excellent — but every one carries an asterisk, and reading fidelity specs correctly is most of the battle. That is the subject of the next section.

## The honest costs

Now settle the bill. Superconducting's weaknesses are as real as its strengths, and they are not bugs to be patched so much as the flip side of the same design choices.

**The cold, and the wiring wall.** A dilution refrigerator is expensive and finicky, but the deeper problem is what scaling does inside it. Every qubit needs its own control and readout lines threaded from room temperature down to 10 mK, and every one of those lines carries heat and noise. IBM's 1121-qubit **Condor** processor reportedly packs *over a mile* of high-density cryogenic wiring into a single fridge <d-cite key="ibm2023condor"></d-cite>. You cannot simply keep adding wires forever — the heat load and the physical congestion become a hard wall. This, not the qubits themselves, is the most concrete obstacle to brute-force scaling, and it is why the field is pivoting toward cryogenic control electronics and multiplexing.

**Coherence is short.** Two numbers matter here: $T_1$, how long the excited state survives before it relaxes (energy loss), and $T_2$, how long the qubit keeps its phase before it dephases — bounded by $T_2 \le 2T_1$, and usually $T_2$ is both the shorter and the harder-won. In typical transmons both sit around **0.1–0.4 ms** <d-cite key="kjaergaard2020superconducting"></d-cite><d-cite key="place2021tantalum"></d-cite>. The culprits are concrete, not mysterious: two-level-system (TLS) defects in the amorphous oxides on surfaces and interfaces, stray non-equilibrium quasiparticles, and Purcell decay leaking energy out through the readout and control lines. That is precisely why a decade of materials work — swapping niobium for tantalum, cleaning up interfaces to starve the TLS bath — pays off, culminating in a Princeton-led group pushing a 2D transmon's $T_1$ to a record **1.68 ms** in 2025 <d-cite key="bland2025tantalum"></d-cite>. (Cosmic rays and ambient radiation occasionally dump energy across the whole chip at once, causing the correlated, multi-qubit error bursts that the surface code — which assumes errors strike independently — least likes to see.) Even that record is *thousands of times* shorter than the seconds-scale coherence of neutral atoms and the seconds-to-minutes coherence of trapped ions. Superconducting copes by being fast: it is the fable's hare with the moral inverted — it wins precisely *because* it never lets itself nap.

**Snowflakes and nearest neighbors.** The fabrication spread comes due here. Because every junction is slightly different, every qubit must be individually tuned, and some pairs land at colliding frequencies that have to be designed around. Connectivity is mostly nearest-neighbor on a 2D grid, so entangling a distant pair means relaying the information through a chain of SWAP gates — the opposite of the all-to-all connectivity ions enjoy. Tunable couplers help switch interactions on and off and suppress crosstalk, but crosstalk remains the platform's perennial headache.

Put those together and the in-machine numbers are soberer than the lab records. On real multi-qubit processors the **median two-qubit gate fidelity** is around 99.5%: Rigetti's 84-qubit Ankaa-3 reports a median two-qubit fidelity of **99.5%** <d-cite key="rigetti2024ankaa"></d-cite>, and USTC's 105-qubit Zuchongzhi 3.0 reports about **99.62%** <d-cite key="ustc2025zuchongzhi"></d-cite>. Three distinctions keep the marketing honest, and they trip up almost every popular summary:

1. **Single-qubit is not two-qubit.** The best single-qubit gates of any superconducting qubit — fluxonium, a junction shunted by a large **superinductor** rather than a capacitor — exceed 99.99% <d-cite key="somoroff2023fluxonium"></d-cite>; two-qubit gates are the hard part and run a notch or two lower. When someone quotes "four nines," check which gate they mean.
2. **A lab record is not an in-machine median.** Those headline fidelities are achieved on a handful of qubits under ideal tune-up; the *median* across a hundred-qubit chip is meaningfully worse, and the median is what runs your circuit.
3. **A physical qubit is not a logical qubit.** At current quantum-error-correction overhead, those 1121 physical qubits buy only about one to a few *usable* logical qubits — the exact count set by the target error rate, since each protected logical qubit devours hundreds of physical ones. Error correction is an overhead, not a discount.

And the gap that frames the whole endeavor: running large-scale algorithms — Shor-scale factoring, fault-tolerant chemistry — calls for logical error rates of roughly $10^{-10}$ or lower, and commonly $10^{-12}$–$10^{-15}$ for cracking real cryptographic keys, because total error grows with the astronomical gate count <d-cite key="fowler2012surface"></d-cite>. That is a chasm below today's ~$10^{-3}$ physical gate errors; a logical error of $10^{-6}$ is a near-term, modest-circuit milestone, not the destination. Closing that gap is the entire point of quantum error correction, and it is the field's hardest current problem.

## State of the art

The superconducting scoreboard is a parade of hard-won milestones, each of which means *less* than the headline and *more* than the cynics allow. The trick is to read each one precisely.

**2019 — Sycamore and "quantum supremacy."** Google's 53-qubit Sycamore sampled a random quantum circuit in about 200 seconds and claimed a classical supercomputer would need on the order of 10,000 years to match it <d-cite key="arute2019supremacy"></d-cite>. It was a real landmark — the first experimental claim that a programmable quantum device had outrun classical hardware on *some* task. But the "10,000 years" estimate did not survive contact with cleverer classical algorithms: a 2022 tensor-network method reproduced the sampling task in about **15 hours on a GPU cluster** <d-cite key="pan2022solving"></d-cite>, collapsing the claimed gap. The lasting lesson is that "supremacy" claims are a moving target, defined against the *best known* classical algorithm, which keeps improving.

**2024 — Willow goes below threshold.** Google's 105-qubit **Willow** chip ran surface codes at code distances 3, 5, and 7 and showed the logical error rate *dropping* by a factor $\Lambda \approx 2.14$ each time the code grew <d-cite key="google2024willow"></d-cite>. This is the long-promised "below threshold" regime: error correction that *helps*, with the encoded qubit outliving its best physical component. It is arguably more important than 2019 — but read the fine print. What Willow demonstrated is a quantum **memory** that gets better with scale, not a quantum *computation*. Storing a logical qubit faithfully is the prerequisite for fault-tolerant computing, not the thing itself.

**2025 — "Quantum Echoes" and *verifiable* advantage.** In October 2025 Google reported, again on Willow, a measurement of an out-of-time-order correlator (an "echo" probing how quantum information scrambles) running roughly **13,000 times faster** than the best known classical algorithm <d-cite key="google2025echoes"></d-cite>. The load-bearing word is **verifiable**: unlike the 2019 random-sampling bitstrings, whose correctness was hard to confirm, this result is a stable physical observable that another quantum computer can reproduce and cross-check. That is a meaningful step up in rigor. The honest caveat, which Google states plainly, is that this is still a *physics-simulation* task — measuring quantum dynamics — not a general-purpose useful computation; the molecular-structure application they demonstrated alongside it is validated against experiment but is not itself beyond classical reach at this scale.

**The qubit-count flex.** IBM's **Condor** reached **1121 physical qubits** in 2023 <d-cite key="ibm2023condor"></d-cite> — a "we can build it this big" demonstration that was never productized. The actual workhorses are smaller and better: IBM's 156-qubit **Heron** <d-cite key="ibm2024heron"></d-cite> and 120-qubit **Nighthawk** <d-cite key="ibm2025nighthawk"></d-cite>, and Google's 105-qubit Willow. The race stopped being about raw qubit count years ago.

**The players, and their bets.** Here the milestones resolve into a single argument: *different error-correction philosophies, one shared transmon.* IBM (Condor / Heron / Nighthawk) is betting on quantum LDPC codes — its "gross code" packs 12 logical qubits into 144 data qubits, far cheaper than the surface code's overhead <d-cite key="bravyi2024ldpc"></d-cite>. Google (Willow) is driving the surface code below threshold. AWS's **Ocelot** is built from bosonic "cat qubits" that suppress one error type in hardware, leaving the code less to fix <d-cite key="putterman2025ocelot"></d-cite>. USTC fields Zuchongzhi 3.0 <d-cite key="ustc2025zuchongzhi"></d-cite>; Rigetti, IQM, and others round out the field. Four bets, one circuit — and it is that circuit's macroscopic-quantum bedrock that just earned its 1980s pioneers (Clarke, Devoret, Martinis) the 2025 Physics Nobel <d-cite key="clarke2025nobel"></d-cite>, a prize for the foundation, never for any one computer.

## Where it sits

Superconducting qubits are a **fast but high-maintenance front-runner**. They win on speed, manufacturability, and ecosystem; they pay for it in cryogenics, short coherence, fabrication spread, and one weakness that does not show up on any gate-fidelity spec: they are terrible at networking.

That last point deserves a sentence, because this series keeps one eye on whether a qubit can *network* as well as compute. A superconducting qubit speaks in ~5 GHz microwave photons, and microwave photons cannot travel down an optical fiber the way telecom-band light does — glass is transparent only near 200 THz, some four orders of magnitude higher in frequency, and a lone 5 GHz photon would in any case drown in the thermal noise of any room-temperature link. Linking two superconducting processors over fiber requires **microwave-to-optical quantum transduction**, a translation step whose efficiency — especially in the low-added-noise regime a true quantum link demands — is still only a few percent in practice, a few tens of percent at the most optimistic edge <d-cite key="han2021microwaveoptical"></d-cite><d-cite key="lauk2020transduction"></d-cite>. No two superconducting processors have yet been linked by an optical quantum channel. As a computing core, superconducting is a front-runner; as a future quantum-internet node, its honest answer is "not yet."

| | Superconducting | Trapped ion | Neutral atom | Photonic |
|---|---|---|---|---|
| **Qubit** | printed circuit (transmon) | a real atom (ion) | a real atom | a photon |
| **Gate speed** | very fast (~10–70 ns) | slow (~µs) | slow (~µs) | n/a (measurement) |
| **Coherence** | short (~0.1–1.7 ms) | very long (s–min) | long (s) | loss-limited |
| **Connectivity** | mostly nearest-neighbor | all-to-all | reconfigurable | hard (no interaction) |
| **Operating temp** | ~10 mK (dilution fridge) | room-temp vacuum | room-temp vacuum | room temperature |
| **As a network node** | needs transduction | natural (emits photons) | promising | it *is* the photon |

No platform wins every row, which is the whole reason five of them are still in the race. If you want a cloud-accessible, general-purpose, engineering-leading quantum computer *today*, superconducting is the most realistic pick — a math genius who happens to live in a refrigerator and cannot use a phone. But if your wish list includes long memory and a photon you can fire at a distant node, the next routes in this series are about to look very attractive. Up next: what happens when you stop *faking* the atom and trap a real one — **trapped ions**.

---

**More in this series — [How to Build a Quantum Computer](/blog/2026/how-to-build-a-quantum-computer/):** [Superconducting](/blog/2026/superconducting-qubits/) · [Trapped ion](/blog/2026/trapped-ion-qubits/) · [Neutral atom](/blog/2026/neutral-atom-qubits/) · [Photonic](/blog/2026/photonic-qubits/) · [Other platforms](/blog/2026/other-qubit-platforms/)
