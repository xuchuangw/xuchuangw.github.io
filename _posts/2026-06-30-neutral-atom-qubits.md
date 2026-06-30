---
layout: distill
title: "Neutral-atom qubits: a thousand atoms in a lattice of light"
description: "Pinch a neutral atom in nothing but focused light, split one laser into thousands of those pinches, then rearrange the atoms like a board game — here is how the LEGO of quantum computing went from a trapping trick to the platform now leading on sheer qubit count and error-corrected logical qubits, and the slippery costs it pays for the lead."
date: 2026-06-30
tags: quantum neutral-atom rydberg
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
  - name: What a neutral-atom qubit is
  - name: How it is built and controlled
  - name: Why it scales
  - name: The honest costs
  - name: State of the art
  - name: Where it sits
---

*Part of the [How to Build a Quantum Computer](/blog/2026/how-to-build-a-quantum-computer/) series.*

The previous post left us with a teasing question. A superconducting qubit is a circuit faking an atom; a trapped ion is a real atom you grab by its electric charge — precise, but a single chain tops out near a hundred. So: if catching one real atom is this good and herding many is this hard, what if you did not strip the electron at all, and held a *neutral* atom in a pinch of pure light?

You lose the charge handle that made the ion easy to grip — but you gain something extraordinary in exchange. A single laser beam, passed through the right optics, can be carved into *thousands* of independent traps at once, each cradling one atom, and you can pick those atoms up and set them down somewhere else mid-computation.

If the trapped ion is a master craftsman carving one perfect chain, the neutral atom is a child with an enormous box of identical LEGO bricks: not the finest single piece, but you can build *big*, and rearrange as you go. That box is the reason this platform now holds the records for raw qubit count and for error-corrected logical qubits at the same time. Let us see how light alone holds an atom still — and what it costs to herd thousands of them.

## What a neutral-atom qubit is

Start, as always, with the two-level system. Here it is the genuine article, same as the ion: a single neutral atom, its electron count intact. The usual choices fall into two families. The **alkali** atoms — rubidium-87 and cesium-133 — store the qubit in two hyperfine sublevels of the electronic ground state; in $^{87}\mathrm{Rb}$ these hyperfine "clock states" — the microwave levels atomic clocks are built on — are split by about $6.8$ GHz. The **alkaline-earth-like** atoms split the labor by whether the isotope carries nuclear spin: the fermionic $^{171}\mathrm{Yb}$, with nuclear spin $\tfrac12$, carries a clean two-state *nuclear-spin* qubit that barely notices magnetic noise, while the bosonic $^{88}\mathrm{Sr}$ — zero nuclear spin to use — instead encodes its qubit on a razor-narrow optical-clock transition. Either way, you pick two of the atom's own levels, call them $\vert 0\rangle$ and $\vert 1\rangle$, and the discreteness a transmon had to manufacture comes free, because an atom's electrons simply cannot sit between levels.

And here the neutral atom inherits the trapped ion's best birthright, the one fabricated qubits openly envy: **every atom of a given isotope is fundamentally identical to every other.** Not "matched to manufacturing tolerance" — *the same*, set by nature to a precision no foundry will ever reach. There are no snowflakes here, no per-qubit frequency that drifted because one oxide barrier came out a nanometer thick. When your array holds three thousand atoms, it holds three thousand copies of the *same* qubit. (The same footnote the ions earned applies here: the atoms are identical, but their local environments — stray fields, laser intensity, position in the trap — are not, so nobody actually skips calibration. They just start from a place no engineered qubit can.)

So the qubit itself is, once again, nature's free gift. The entire art of this platform is in two verbs: *holding* thousands of these slippery, chargeless atoms still with nothing but light, and *talking* to them — making them interact on demand without knocking them loose. That art is the rest of this post.

## How it is built and controlled

**Gripping an atom with light.** A neutral atom carries no charge, so you cannot push it around with electrodes the way you herd an ion. What you *can* do is exploit the fact that light is an oscillating electric field, and that field induces a tiny dipole in the atom. Focus a laser beam tuned *below* the atom's resonance (red-detuned) to a micron-scale waist, and the induced dipole is pulled toward the region of highest intensity — the focal point. The atom sits in a potential well shaped like the light itself,

$$
U(\mathbf r) \;\approx\; \frac{3\pi c^2}{2\,\omega_0^3}\,\frac{\Gamma}{\Delta}\,I(\mathbf r),
$$

where $I(\mathbf r)$ is the intensity, $\Gamma$ the natural linewidth, and $\Delta=\omega-\omega_0<0$ the red detuning. That sign is the whole trick: with $\Delta<0$, $U\propto\Gamma/\Delta$ is negative, so $U$ is lowest where $I$ is highest, and the atom is trapped at the bright focus of the beam. This is an **optical tweezer** — a single tightly focused laser acting as a bowl of light a fraction of a millikelvin deep. The technique earned Arthur Ashkin a share of the 2018 Nobel Prize in Physics <d-cite key="ashkin2018nobel"></d-cite>, and the laser cooling that makes atoms slow enough to catch earned the 1997 prize before it <d-cite key="chu1997nobel"></d-cite>. (Worth saying plainly, because the press loves to muddle the family tree: *neither* of those is the 2025 prize, which went to the superconducting-circuit side.)

The leap from one tweezer to a quantum computer is an exercise in optics. Send the trapping beam through a **spatial light modulator** or a pair of crossed **acousto-optic deflectors**, and you split it into hundreds or thousands of independent foci — a whole grid of tweezers conjured from a single laser. The build then goes in three steps. First, a **magneto-optical trap** laser-cools a dilute cloud of atoms to the microkelvin range. Second, the tweezer grid dips into that cold cloud and each focus grabs an atom. Third — the clever part — the array is *rearranged* into the shape you actually want.

<figure class="l-body" style="text-align:center; margin:1.5rem auto; max-width:720px;">
  <svg viewBox="0 0 720 400" role="img" aria-label="Assembling a defect-free atom register, in two panels. At top, one laser passes through a spatial light modulator or acousto-optic deflectors and fans out into a grid of traps. The left panel shows a freshly loaded array in which only about half the trap sites hold an atom, at random. A large arrow labelled image and rearrange points to the right panel, where mobile tweezers have compressed the survivors into a smaller, fully filled block — a defect-free register." style="width:100%; height:auto; font-family:sans-serif;">
    <defs>
      <marker id="na1a" markerWidth="9" markerHeight="9" refX="4.5" refY="4.5" orient="auto"><path d="M0 0 L9 4.5 L0 9 Z" fill="currentColor"/></marker>
    </defs>
    <!-- optics: one laser -> SLM/AOD -> fan of traps over the left panel -->
    <line x1="160" y1="14" x2="126" y2="40" stroke="#4f7cff" stroke-width="1.6" opacity="0.7"/>
    <line x1="160" y1="14" x2="194" y2="40" stroke="#4f7cff" stroke-width="1.6" opacity="0.7"/>
    <rect x="122" y="40" width="76" height="9" rx="2" fill="none" stroke="#4f7cff" stroke-width="1.6"/>
    <line x1="135" y1="49" x2="95" y2="136" stroke="#4f7cff" stroke-width="1" opacity="0.35"/>
    <line x1="160" y1="49" x2="160" y2="136" stroke="#4f7cff" stroke-width="1" opacity="0.35"/>
    <line x1="185" y1="49" x2="225" y2="136" stroke="#4f7cff" stroke-width="1" opacity="0.35"/>
    <text x="214" y="32" fill="#4f7cff" font-size="11.5" text-anchor="start">one laser, split into</text>
    <text x="214" y="47" fill="#4f7cff" font-size="11.5" text-anchor="start">thousands of traps</text>
    <!-- LEFT PANEL: raw load, ~half the sites empty -->
    <!-- row 1 y=150 -->
    <circle cx="95" cy="150" r="12" fill="none" stroke="currentColor" stroke-width="1" stroke-dasharray="3 3" opacity="0.5"/>
    <circle cx="95" cy="150" r="7" fill="#14b8a6" fill-opacity="0.25" stroke="#14b8a6" stroke-width="2"/>
    <circle cx="160" cy="150" r="12" fill="none" stroke="currentColor" stroke-width="1" stroke-dasharray="3 3" opacity="0.5"/>
    <circle cx="225" cy="150" r="12" fill="none" stroke="currentColor" stroke-width="1" stroke-dasharray="3 3" opacity="0.5"/>
    <!-- row 2 y=215 -->
    <circle cx="95" cy="215" r="12" fill="none" stroke="currentColor" stroke-width="1" stroke-dasharray="3 3" opacity="0.5"/>
    <circle cx="160" cy="215" r="12" fill="none" stroke="currentColor" stroke-width="1" stroke-dasharray="3 3" opacity="0.5"/>
    <circle cx="225" cy="215" r="12" fill="none" stroke="currentColor" stroke-width="1" stroke-dasharray="3 3" opacity="0.5"/>
    <circle cx="225" cy="215" r="7" fill="#14b8a6" fill-opacity="0.25" stroke="#14b8a6" stroke-width="2"/>
    <!-- row 3 y=280 -->
    <circle cx="95" cy="280" r="12" fill="none" stroke="currentColor" stroke-width="1" stroke-dasharray="3 3" opacity="0.5"/>
    <circle cx="160" cy="280" r="12" fill="none" stroke="currentColor" stroke-width="1" stroke-dasharray="3 3" opacity="0.5"/>
    <circle cx="160" cy="280" r="7" fill="#14b8a6" fill-opacity="0.25" stroke="#14b8a6" stroke-width="2"/>
    <circle cx="225" cy="280" r="12" fill="none" stroke="currentColor" stroke-width="1" stroke-dasharray="3 3" opacity="0.5"/>
    <circle cx="225" cy="280" r="7" fill="#14b8a6" fill-opacity="0.25" stroke="#14b8a6" stroke-width="2"/>
    <text x="160" y="320" fill="currentColor" font-size="12.5" text-anchor="middle">raw load: ~50% filled, at random</text>
    <!-- MIDDLE: image + rearrange arrow -->
    <text x="320" y="200" fill="currentColor" font-size="12.5" text-anchor="middle">image + rearrange</text>
    <line x1="268" y1="220" x2="372" y2="220" stroke="currentColor" stroke-width="2.2" marker-end="url(#na1a)"/>
    <!-- RIGHT PANEL: defect-free block, survivors compressed (4 atoms in, 4 atoms out) -->
    <circle cx="460" cy="183" r="12" fill="none" stroke="currentColor" stroke-width="1" stroke-dasharray="3 3" opacity="0.5"/>
    <circle cx="460" cy="183" r="7" fill="#14b8a6" fill-opacity="0.25" stroke="#14b8a6" stroke-width="2"/>
    <circle cx="525" cy="183" r="12" fill="none" stroke="currentColor" stroke-width="1" stroke-dasharray="3 3" opacity="0.5"/>
    <circle cx="525" cy="183" r="7" fill="#14b8a6" fill-opacity="0.25" stroke="#14b8a6" stroke-width="2"/>
    <circle cx="460" cy="248" r="12" fill="none" stroke="currentColor" stroke-width="1" stroke-dasharray="3 3" opacity="0.5"/>
    <circle cx="460" cy="248" r="7" fill="#14b8a6" fill-opacity="0.25" stroke="#14b8a6" stroke-width="2"/>
    <circle cx="525" cy="248" r="12" fill="none" stroke="currentColor" stroke-width="1" stroke-dasharray="3 3" opacity="0.5"/>
    <circle cx="525" cy="248" r="7" fill="#14b8a6" fill-opacity="0.25" stroke="#14b8a6" stroke-width="2"/>
    <text x="492" y="300" fill="currentColor" font-size="12.5" text-anchor="middle">defect-free block</text>
  </svg>
  <figcaption style="margin-top:.5rem;"><b>Figure 1.</b> Assembling a defect-free register. One laser, split by a spatial light modulator or a pair of acousto-optic deflectors, fans out into a whole grid of micron-scale traps (dashed rings), each holding at most one atom (teal). Loading is probabilistic, so roughly half the sites come up empty, at random (left). A set of mobile tweezers then images the array and compresses the survivors into a smaller, fully filled block — the defect-free register the computation needs (right).</figcaption>
</figure>

**Why rearrangement is unavoidable.** When a tweezer dips into the cold cloud, it does not reliably catch exactly one atom. A beautiful piece of physics called the **collisional blockade** ensures it catches *zero or one* — never two, because a pair of atoms in so small a volume undergoes a light-assisted collision that ejects both — but it cannot decide *which*. Schlosser and colleagues showed in 2001 that this mechanism locks the average occupancy at almost exactly $0.5$ atoms per trap <d-cite key="schlosser2001subpoissonian"></d-cite>. So a freshly loaded array of a thousand traps comes up *half empty*, at random — useless as a register. The fix, demonstrated in 2016 by the Endres and Barredo–Browaeys groups, is **atom-by-atom assembly**: image the array to see which sites loaded, then use a second set of mobile tweezers to physically pick up atoms and drop them into the holes, building a *defect-free* target pattern in one or two dimensions <d-cite key="endres2016assembly"></d-cite><d-cite key="barredo2016assembler"></d-cite>. It is, almost literally, a tiny robotic claw machine that wins every time. That same ability to move atoms around will return, when we tally why it scales, as a feature rather than a chore.

**Single-qubit gates** are the easy half: a resonant microwave pulse (for hyperfine qubits) or a pair of laser beams (a Raman transition, or a direct optical-clock drive) flips $\vert 0\rangle\leftrightarrow\vert 1\rangle$, on one atom or, with a global field, on all of them.

**Two-qubit gates** are where the genius lives — and the mechanism is the most charming in all of quantum computing. The problem is that two neutral atoms in their ground states barely feel each other; they are tiny and far apart. The solution is to make them, briefly, *enormous*. Drive an atom's outer electron up to a **Rydberg state** of high principal quantum number $n$ — in the tens, typically $n\approx 50$–$80$ — and the electron's orbit balloons. A Rydberg atom's size grows as $n^2$, so at $n=70$ it is hundreds of nanometers across, thousands of times larger than a ground-state atom: a fragile, bloated giant with a correspondingly giant electric dipole. Because the dipole matrix elements scale as $n^2$, the interaction between two Rydberg atoms is colossal — the van der Waals coefficient scales as $C_6\propto n^{11}$ <d-cite key="saffman2010rydberg"></d-cite>. Two atoms that ignored each other as ground-state specks shove each other hard the instant both go Rydberg.

That shove is the gate, through an effect named the **Rydberg blockade**, proposed by Jaksch and colleagues in 2000 and extended by Lukin and colleagues in 2001 <d-cite key="jaksch2000fastgates"></d-cite><d-cite key="lukin2001dipoleblockade"></d-cite>. Suppose you shine a laser of Rabi frequency $\Omega$ tuned to drive the $\vert 1\rangle\to\vert r\rangle$ Rydberg transition on two nearby atoms. Excite the first atom to $\vert r\rangle$, and its interaction $V(R)=C_6/R^6$ with the second atom *shifts that second atom's Rydberg level out of resonance*. If the two atoms sit closer than the **blockade radius** $R_b$ — the distance at which the interaction shift equals the drive strength,

$$
\frac{C_6}{R_b^{6}} \;=\; \hbar\Omega \qquad\Longrightarrow\qquad R_b \;=\; \left(\frac{C_6}{\hbar\Omega}\right)^{1/6} \;\propto\; n^{11/6},
$$

then the laser simply *cannot* excite both atoms at once: the pair is locked into "at most one of you may be a giant." For $n\approx 70$ atoms, $R_b$ runs to several microns — comfortably larger than the typical few-micron spacing in the array — so neighbors blockade each other reliably. This conditional "you may, but then you may not" is exactly the logical structure of a controlled gate. Turning it into a *phase* gate is the final flourish. A single carefully shaped pulse drives both atoms up toward $\vert r\rangle$ and back down again: when only one of the pair began in $\vert 1\rangle$, it completes a clean round trip and picks up a definite phase. But when *both* began in $\vert 1\rangle$, the blockade forbids the doubly-excited state, so the $\vert 11\rangle$ branch takes a different path and accumulates a *different* phase. That extra, conditional phase on $\vert 11\rangle$ alone — not the blockade by itself — is the native **controlled-Z**. This global-pulse protocol (Levine, Pichler and colleagues, 2019)<d-cite key="levine2019parallel"></d-cite> lands in a few hundred nanoseconds<d-cite key="evered2023highfidelity"></d-cite>. Figure 2 shows the blockade that makes it possible.

<figure class="l-body" style="text-align:center; margin:1.5rem auto; max-width:680px;">
  <svg viewBox="0 0 720 360" role="img" aria-label="The Rydberg blockade. A left atom is driven to a giant Rydberg state, drawn amber and puffed up with a dashed halo, surrounded by a dashed blockade-radius circle that reaches past a second atom on the right. The second atom sits within the blockade radius. An energy-level inset on the right shows that the second atom's Rydberg level is pushed up by the interaction energy V, detuning it from the drive, so its excitation is blocked." style="width:100%; height:auto; font-family:sans-serif;">
    <defs>
      <marker id="na2a" markerWidth="9" markerHeight="9" refX="4.5" refY="4.5" orient="auto"><path d="M0 0 L9 4.5 L0 9 Z" fill="currentColor"/></marker>
      <marker id="na2b" markerWidth="8" markerHeight="8" refX="4" refY="4" orient="auto"><path d="M0 0 L8 4 L0 8 Z" fill="#4f7cff"/></marker>
    </defs>
    <!-- blockade radius -->
    <circle cx="200" cy="190" r="168" fill="#e0a106" fill-opacity="0.05" stroke="#e0a106" stroke-width="1.4" stroke-dasharray="6 5"/>
    <text x="200" y="28" fill="#e0a106" font-size="12.5" text-anchor="middle">blockade radius R<tspan baseline-shift="sub" font-size="smaller">b</tspan></text>
    <!-- atom A: driven to Rydberg, puffed -->
    <circle cx="200" cy="190" r="30" fill="#e0a106" fill-opacity="0.12" stroke="#e0a106" stroke-width="1.2" stroke-dasharray="3 3"/>
    <circle cx="200" cy="190" r="15" fill="#e0a106" fill-opacity="0.30" stroke="#e0a106" stroke-width="2.4"/>
    <text x="200" y="246" fill="#e0a106" font-size="13" text-anchor="middle">atom A &#8594; |r&#x27E9; (excited)</text>
    <!-- drive on A -->
    <line x1="160" y1="150" x2="182" y2="174" stroke="#4f7cff" stroke-width="2" marker-end="url(#na2b)"/>
    <text x="150" y="146" fill="#4f7cff" font-size="12" text-anchor="end">&#x3A9;</text>
    <!-- separation (R, atom A to atom B) -->
    <line x1="232" y1="190" x2="322" y2="190" stroke="currentColor" stroke-width="1" stroke-dasharray="4 4" opacity="0.5"/>
    <text x="277" y="180" fill="currentColor" font-size="11.5" text-anchor="middle">R &lt; R<tspan baseline-shift="sub" font-size="smaller">b</tspan></text>
    <!-- atom B: stays ground, sits inside the blockade circle -->
    <circle cx="336" cy="190" r="11" fill="#14b8a6" fill-opacity="0.25" stroke="#14b8a6" stroke-width="2.4"/>
    <text x="336" y="246" fill="#14b8a6" font-size="13" text-anchor="middle">atom B: blocked</text>
    <!-- drive on B (crossed out) -->
    <line x1="336" y1="150" x2="336" y2="172" stroke="#4f7cff" stroke-width="2" marker-end="url(#na2b)"/>
    <line x1="328" y1="156" x2="344" y2="170" stroke="#ef4444" stroke-width="2.2"/>
    <!-- energy inset for atom B -->
    <line x1="560" y1="300" x2="560" y2="70" stroke="currentColor" stroke-width="1.2"/>
    <text x="548" y="60" fill="currentColor" font-size="11.5" text-anchor="middle">E</text>
    <line x1="540" y1="280" x2="660" y2="280" stroke="#14b8a6" stroke-width="2.4"/>
    <text x="668" y="284" fill="#14b8a6" font-size="12">|1&#x27E9;</text>
    <!-- bare Rydberg level (where drive points) -->
    <line x1="540" y1="150" x2="660" y2="150" stroke="currentColor" stroke-width="1.6" stroke-dasharray="5 4" opacity="0.6"/>
    <text x="668" y="154" fill="currentColor" font-size="11.5" opacity="0.7">|r&#x27E9; bare</text>
    <!-- shifted Rydberg level -->
    <line x1="540" y1="108" x2="660" y2="108" stroke="#ef4444" stroke-width="2.4"/>
    <text x="668" y="112" fill="#ef4444" font-size="12">|r&#x27E9; + V</text>
    <!-- drive arrow on inset -->
    <line x1="556" y1="280" x2="556" y2="152" stroke="#4f7cff" stroke-width="2" marker-end="url(#na2b)"/>
    <text x="528" y="216" fill="#4f7cff" font-size="12" text-anchor="middle">&#x3A9;</text>
    <!-- shift bracket -->
    <line x1="600" y1="150" x2="600" y2="108" stroke="#ef4444" stroke-width="1.2" marker-start="url(#na2a)" marker-end="url(#na2a)"/>
    <text x="612" y="132" fill="#ef4444" font-size="12">shift V</text>
    <text x="600" y="332" fill="currentColor" font-size="12.5" text-anchor="middle">V &#8811; &#x210F;&#x3A9; &#8594; the drive misses &#8594; B cannot be excited</text>
  </svg>
  <figcaption style="margin-top:.5rem;"><b>Figure 2.</b> The Rydberg blockade. Once atom A is driven to a giant Rydberg state $\vert r\rangle$, its strong van der Waals interaction $V=C_6/R^6$ pushes atom B's own Rydberg level up by $V$ (right inset). If the two atoms sit within the blockade radius $R_b$, that shift far exceeds the drive strength $\hbar\Omega$, so the laser is off-resonant for B and its excitation is forbidden — "only one of you may be a giant." This conditional rule is the logical heart of the native controlled-Z gate: a single shaped pulse turns it into a conditional phase on $\vert 11\rangle$ that entangles the two atoms.</figcaption>
</figure>

**Reconfigurable wiring.** One more control trick sets neutral atoms apart. The blockade only entangles atoms that are close together — but the claw machine that assembled the array can also *move atoms during the computation*. Pick up a qubit, glide it across the chip to sit beside any partner, run the blockade gate, glide it back (Figure 3). This **atom shuttling** turns a fixed grid into an effectively all-to-all connected machine, with the routing chosen on the fly <d-cite key="bluvstein2024logical"></d-cite>. The catch is in the clock: a move takes of order hundreds of microseconds, far longer than a gate, so you buy flexible connectivity with *time*. Hold that trade; it comes back with a price tag attached.

<figure class="l-body" style="text-align:center; margin:1.5rem auto; max-width:720px;">
  <svg viewBox="0 0 720 300" role="img" aria-label="Atom shuttling for reconfigurable connectivity. Two qubits, A and B, sit far apart on a lattice line, well outside each other's blockade radius, so they do not interact. A curved arrow shows a mobile tweezer gliding qubit B across the array to sit beside qubit A, where an amber blockade circle now encloses both and a controlled-Z gate fires. A second, fainter curved arrow glides B back to its home site. A note marks that each move costs hundreds of microseconds, far longer than the gate it enables." style="width:100%; height:auto; font-family:sans-serif;">
    <defs>
      <marker id="na3a" markerWidth="9" markerHeight="9" refX="4.5" refY="4.5" orient="auto"><path d="M0 0 L9 4.5 L0 9 Z" fill="currentColor"/></marker>
    </defs>
    <!-- lattice sites -->
    <circle cx="80" cy="200" r="12" fill="none" stroke="currentColor" stroke-width="1" stroke-dasharray="3 3" opacity="0.3"/>
    <circle cx="200" cy="200" r="12" fill="none" stroke="currentColor" stroke-width="1" stroke-dasharray="3 3" opacity="0.3"/>
    <circle cx="320" cy="200" r="12" fill="none" stroke="currentColor" stroke-width="1" stroke-dasharray="3 3" opacity="0.3"/>
    <circle cx="440" cy="200" r="12" fill="none" stroke="currentColor" stroke-width="1" stroke-dasharray="3 3" opacity="0.3"/>
    <circle cx="560" cy="200" r="12" fill="none" stroke="currentColor" stroke-width="1" stroke-dasharray="3 3" opacity="0.3"/>
    <!-- move-over arc -->
    <path d="M552 188 C 470 72 250 72 176 190" fill="none" stroke="currentColor" stroke-width="1.8" marker-end="url(#na3a)"/>
    <text x="364" y="58" fill="currentColor" font-size="12.5" text-anchor="middle">glide the partner over</text>
    <!-- return arc -->
    <path d="M168 212 C 280 270 450 270 552 212" fill="none" stroke="currentColor" stroke-width="1.4" stroke-dasharray="5 4" opacity="0.5" marker-end="url(#na3a)"/>
    <text x="430" y="252" fill="currentColor" font-size="11.5" text-anchor="middle" opacity="0.65">then glide back</text>
    <!-- blockade -->
    <circle cx="120" cy="200" r="66" fill="#e0a106" fill-opacity="0.06" stroke="#e0a106" stroke-width="1.4" stroke-dasharray="6 5"/>
    <text x="120" y="116" fill="#e0a106" font-size="12.5" text-anchor="middle">blockade &#8594; CZ</text>
    <!-- control A -->
    <circle cx="80" cy="200" r="8" fill="#14b8a6" fill-opacity="0.30" stroke="#14b8a6" stroke-width="2.4"/>
    <text x="80" y="238" fill="currentColor" font-size="12.5" text-anchor="middle">A</text>
    <!-- moved B -->
    <circle cx="160" cy="200" r="8" fill="#14b8a6" fill-opacity="0.30" stroke="#14b8a6" stroke-width="2.4"/>
    <text x="160" y="238" fill="currentColor" font-size="12.5" text-anchor="middle">B</text>
    <!-- ghost B start -->
    <circle cx="560" cy="200" r="8" fill="#14b8a6" fill-opacity="0.12" stroke="#14b8a6" stroke-width="2" opacity="0.5"/>
    <text x="560" y="238" fill="currentColor" font-size="12.5" text-anchor="middle" opacity="0.6">B (start)</text>
    <text x="560" y="176" fill="currentColor" font-size="11.5" text-anchor="middle" opacity="0.7">far: R &#8811; R<tspan baseline-shift="sub" font-size="smaller">b</tspan></text>
    <!-- time tag -->
    <text x="360" y="290" fill="#e0a106" font-size="12.5" text-anchor="middle">each move &#8776; 100s of &#181;s  &#8811;  CZ gate &#8776; 100s of ns</text>
  </svg>
  <figcaption style="margin-top:.5rem;"><b>Figure 3.</b> Reconfigurable wiring, billed by the millisecond. Two qubits parked far apart on the lattice lie well outside each other's blockade radius ($R \gg R_b$) and cannot interact. To entangle them, a mobile tweezer lifts one out, glides it next to its partner — now inside $R_b$, the pair runs a controlled-Z — then carries it home. Any qubit can be wired to any other this way (effectively all-to-all connectivity), but every move costs hundreds of microseconds, far longer than the gate it enables.</figcaption>
</figure>

## Why it scales

Lay out the ledger and the neutral atom's defining virtue is not raw speed — its gates beat an ion's but trail a transmon's, and slow readout drags the clock — it is **scale**, and the error-correction headroom that scale unlocks.

**Numbers from one laser.** Because the array is conjured optically rather than fabricated qubit by qubit, growing it means splitting the beam into more spots, not threading more wires into a fridge. In 2023 Atom Computing crossed a symbolic line — a $1{,}225$-site array holding **1,180 atoms**, the first gate-model platform past a thousand qubits <d-cite key="atomcomputing2023kilo"></d-cite>. Pasqal loaded **more than 1,000 atoms** in a single shot in 2024 <d-cite key="pasqal2024kiloatom"></d-cite>. And in 2025 a Caltech group ran the count to **6,100 atoms** in about 12,000 tweezer sites — an order-of-magnitude jump, all from one apparatus <d-cite key="manetsch2025tweezer"></d-cite>. No other platform produces qubits this cheaply per qubit. (The asterisk on that 6,100 waits in the next section.)

**Identical, and reconfigurable, and cool enough.** Identical atoms (above) means no fabrication spread to fight across thousands of qubits. Atom shuttling means any pair can be made neighbors, so circuits stay short instead of relaying through chains of SWAP gates. And the whole apparatus runs at **room temperature** — there is no dilution refrigerator, only (and this is not nothing) a rack of phase-locked lasers and an ultra-high-vacuum chamber. You save the fridge; you do not save the optics table.

**Coherence in the seconds — and that is enough.** Held quiet between operations, these qubits remember for a satisfyingly long time. (The trap light is not free here: it shifts $\vert 0\rangle$ and $\vert 1\rangle$ by slightly different amounts and would slowly dephase the qubit, so the headline coherence numbers are taken with the tweezer briefly off, or at a "magic" wavelength tuned to push both levels equally.) The Caltech cesium array measured a hyperfine coherence time of $12.6$ seconds <d-cite key="manetsch2025tweezer"></d-cite>; nuclear-spin qubits in alkaline-earth atoms reach the tens of seconds <d-cite key="atomcomputing2023kilo"></d-cite>. That is shorter than a trapped ion's minutes-to-hours, but it misses the point to treat it as a loss. Seconds of coherence against gates that take microseconds buys you a vast number of operations — and for a machine built to run *error correction*, where you need many qubits surviving many cycles, "lots of decent qubits" beats "a few heroic ones." Which is exactly where this platform has planted its flag.

**The error-correction edge.** Scale plus all-to-all connectivity plus mid-circuit measurement is precisely the toolkit quantum error correction wants. And the platform turns one of its own weaknesses into a tool: when an atom is lost, or a Rydberg excitation leaks out of the qubit's two levels, the mishap can often be *detected* and relabeled as an "erasure" — an error whose *location* is known — and quantum codes tolerate erasures at a much higher rate than ordinary blind errors <d-cite key="wu2022erasure"></d-cite><d-cite key="ma2023erasure"></d-cite><d-cite key="scholl2023erasure"></d-cite>. A leak you can see coming is a leak you can partly correct. Put it together and, as of 2026, the neutral-atom platform leads on the *number* of **logical qubits** — the encoded, error-resistant qubits that actually matter for fault tolerance — and on the most complete fault-tolerance demonstration yet, even as trapped ions still hold the edge on per-logical-qubit *fidelity*. The headline results run from a 48-logical-qubit processor in 2024 to a below-threshold, fully fault-tolerant architecture on 448 atoms in 2025 <d-cite key="bluvstein2024logical"></d-cite><d-cite key="bluvstein2025faulttolerant"></d-cite>. If the question is "can we gather *enough* physical qubits, and distill *enough* logical ones," this is, right now, where you would place your bet.

## The honest costs

Now settle the bill. The same chargelessness that lets light hold thousands of atoms also makes them slippery in ways that charged ions never are.

**Atoms run off, and loading is a coin flip.** Two related leaks. The first we already met: loading is the ~50% coin flip <d-cite key="schlosser2001subpoissonian"></d-cite> that forces every array to be imaged and rearranged before the first gate — useful overhead, but overhead. (Enhanced-loading tricks — gray-molasses cooling during the load, for one — now push single-site filling to roughly $90\%$, well above that bare one-in-two <d-cite key="brown2019graymolasses"></d-cite>, shrinking the rearrangement bill without abolishing it.) The second is worse for long runs: a trapped atom is only weakly held, and over seconds it is gradually knocked out by collisions with stray background gas; the array slowly develops holes. For a computation that should run for minutes or hours, atom loss is an existential problem, not a nuisance. The fix is equal parts absurd and ingenious: a Harvard–MIT–QuEra collaboration bolted an **atomic conveyor belt** onto the machine, injecting fresh atoms at a furious clip — up to **300,000 per second** loaded into the array's tweezers — so holes can be refilled as fast as they open. With it they kept a **3,000-atom array coherent and running for more than two hours**, cycling more than 50 million atoms through the system without ever losing the stored quantum information <d-cite key="chiu2025continuous"></d-cite>. It sounds like bailing a leaky boat, and that is exactly what it is — except they bail faster than it leaks, indefinitely. The leak is managed, not abolished.

**It is slow — but not where you'd think.** The two-qubit gate itself is quick: hundreds of nanoseconds, faster than an ion's, though it can't touch a transmon's. The real clock penalties live elsewhere. Readout is slow and not gentle: you read a qubit's state by scattering many photons off it (fluorescence imaging), which takes about a *millisecond* to tens of milliseconds and can heat or eject the very atom you measured, so mid-circuit readout must be done carefully and locally. And the reconfigurable-connectivity superpower we met earlier bills by the move — every shuttled atom costs that hundreds-of-microseconds tax.

**Gate fidelity only recently caught up.** For years this was the platform's soft spot: two-qubit gates lagged the ions and the best transmons. That changed in 2023, when an Evered–Lukin demonstration reported a two-qubit fidelity of **99.5%** on up to 60 atoms in parallel — the first neutral-atom gates clearly *above* the surface-code error-correction threshold, using fast single-pulse gates, a low-phase-noise Rydberg laser, and better cooling <d-cite key="evered2023highfidelity"></d-cite>. That is genuinely good and improving, and commercial systems now quote figures in the same neighborhood — but read it precisely: it sits a notch below the trapped ion's best two-qubit numbers and well below ions' "six-nines" *single*-qubit gates. The blockade gate is also only as stable as the lasers that drive it, and the giant Rydberg state is touchy in several ways at once. In the alkalis the jump up to $\vert r\rangle$ is a two-photon climb through a short-lived intermediate level, and stray photons scattered along the way are a leading error. And because the red-detuned tweezer actually *expels* a giant Rydberg atom rather than holding it, the trap must be flicked off mid-gate, feeding a little heating and loss each time. Add the Rydberg state's own finite lifetime (it decays spontaneously and under the room's blackbody glow), laser phase noise, and stray-field drift, and you have the error budget that now dominates. The giant atom is powerful and delicate in equal measure.

**The big asterisk.** That eye-popping 6,100-atom array is, today, a quantum *register* — a memory and a testbed for transport and imaging — not a 6,100-qubit *computer*. Entangling gates have not been run across all of them <d-cite key="manetsch2025tweezer"></d-cite>. The number is a statement about how far the trapping scales, which is real and important, but it is not the same claim as "6,100 working qubits." Keeping that distinction straight is most of what separates careful reporting from hype.

## State of the art

The neutral-atom scoreboard is, remarkably, strong on *both* fronts the other platforms normally have to choose between: raw qubit count *and* error correction. Read each result for exactly what it is.

**The logical-qubit run.** The platform's signature credential is encoded qubits. In 2024 a Harvard-led team (Bluvstein and colleagues) ran a logical processor on up to 280 physical atoms that produced **48 logical qubits**, using *transversal* gates — logic applied to the encoded qubits atom-by-atom, so a single physical fault cannot cascade into a logical one — and reconfigurable connectivity to run circuits no prior machine could: the result that opened the neutral-atom error-correction era <d-cite key="bluvstein2024logical"></d-cite>. Then, in November 2025, the same collaboration stitched every ingredient together at once on **up to 448 atoms** — the most complete fault-tolerance demonstration any platform has shown. They ran repeated rounds of error correction on a surface code at two sizes, encoding each logical qubit first in a "distance-3" patch and then in a larger "distance-5" patch (a bigger patch carries more redundancy and survives more faults), and watched the logical error rate *fall* by $2.14\times$ as they grew it. That is the whole game — errors going *down* as you add qubits, instead of *up*, is the "below-threshold" crossover the entire field has been chasing. Onto that they bolted a denser code ($[[16,6,4]]$: sixteen physical qubits carrying six logical ones, code distance four) and a *universal* set of logic gates, again built transversally so faults stay contained <d-cite key="bluvstein2025faulttolerant"></d-cite>. The authors are careful: this proves the *mechanisms* of fault tolerance below threshold, not a finished computer.

**The commercial and continuous milestones.** On the company side, in late 2024 Microsoft and Atom Computing entangled **24 logical qubits** in a cat state — a single Schrödinger's-cat-style superposition spread across all 24 at once — on a neutral-atom processor, the largest number of entangled logical qubits reported at the time, with logical error rates several times below the physical baseline <d-cite key="reichardt2024logical"></d-cite>. And the continuous-operation run above solved the "machine dies in seconds" problem that had quietly capped every earlier demonstration <d-cite key="chiu2025continuous"></d-cite>.

**The players.** It is a crowded, fast field. **QuEra** runs Aquila, a publicly accessible 256-atom *analog* quantum simulator on the cloud <d-cite key="wurtz2023aquila"></d-cite>, and co-authors the Harvard fault-tolerance work. **Atom Computing** (with Microsoft) builds gate-model machines on ytterbium and crossed the 1,000-qubit line first <d-cite key="atomcomputing2023kilo"></d-cite>. **Pasqal** carries the European flag with kilo-atom arrays <d-cite key="pasqal2024kiloatom"></d-cite>; **Infleqtion** works in cesium; and the academic engines — Lukin, Greiner and Vuletić across Harvard and MIT, and Endres at Caltech — set most of the records the companies productize. Above them sit two Nobel foundations: the 1997 prize for laser cooling and the 2018 prize to Ashkin for the optical tweezers themselves <d-cite key="chu1997nobel"></d-cite><d-cite key="ashkin2018nobel"></d-cite>.

Three caveats, the same ones that govern every platform in this series, keep the scoreboard honest: a physical qubit is not a logical qubit, a lab hero-run is not an in-machine median, and a below-threshold *demonstration* is not yet a fault-tolerant *computation*. Neutral-atom practitioners, to their credit, tend to say so themselves.

## Where it sits

A neutral-atom machine is the field's **scale-and-error-correction contender**: not the fastest gates or the single finest qubit, but the easiest route to *many* identical qubits and the logical-qubit headroom that fault tolerance demands. Its weaknesses are the flip side of the same coin — atoms that load by coin-flip and slowly leak away, slow and delicate readout, a Rydberg-laser error budget, and the time tax on every atom you move.

And then the question this series keeps asking: can it *network* as well as compute? Here the neutral atom rates **good, and rising**. Like an ion, an atom can emit a photon entangled with its own internal state, so it can serve as a network node. The thrilling recent twist is the *wavelength*: in 2025 the Covey group at Illinois entangled a single $^{171}\mathrm{Yb}$ atom with a photon at **1389 nm — in the telecom band**, carried with low loss by modern fiber and far better suited to it than the visible light most atomic qubits emit <d-cite key="covey2025telecom"></d-cite>. That sidesteps the very problem that haunts superconducting qubits: no lossy microwave-to-optical conversion, just a photon born ready for the fiber. The weak spot is *collection* — gathering those photons efficiently, ideally with an optical cavity, is still being engineered, so the node can speak, just not yet loudly enough to be reliably heard. That earns neutral atoms a "promising" rather than the ion's "natural" or the photon's "it *is* the photon."

| | Superconducting | Trapped ion | Neutral atom | Photonic |
|---|---|---|---|---|
| **Qubit** | printed circuit (transmon) | a real atom (ion) | a real atom | a photon |
| **Gate speed** | very fast (~10–70 ns) | slow (~µs) | medium (~0.1–1 µs) | n/a (measurement) |
| **Coherence** | short (~0.1–1.7 ms) | very long (s–hr) | long (s) | loss-limited |
| **Connectivity** | mostly nearest-neighbor | all-to-all | reconfigurable | hard (no interaction) |
| **Operating temp** | ~10 mK (dilution fridge) | room-temp vacuum | room-temp vacuum | room temperature |
| **As a network node** | needs transduction | natural (emits photons) | promising | it *is* the photon |

No platform wins every row — the whole reason five of them are still racing. Superconducting out-sprints decoherence; the trapped ion out-lasts and out-connects everyone; the neutral atom out-*scales* them, trading top-end per-qubit quality for a box of thousands of identical bricks and the error-correction headroom that comes with it. If your wish list is a cloud-accessible engineering juggernaut today, superconducting still leads; if it is record fidelity and a triple-threat memory-processor-node, the ion is the one to beat; if it is *many* qubits, *many* logical qubits, and a clear path to fault tolerance, the neutral atom is the route now setting the pace. But notice what every platform so far has had to fight for: holding a piece of matter still and quiet long enough to compute. The next route stops fighting that battle entirely — by choosing a qubit that refuses to sit still at all, that flies down a fiber by its very nature, and is the consensus best quantum-network node. The fourth build: **photonic**.

---

**More in this series — [How to Build a Quantum Computer](/blog/2026/how-to-build-a-quantum-computer/):** [Superconducting](/blog/2026/superconducting-qubits/) · [Trapped ion](/blog/2026/trapped-ion-qubits/) · [Neutral atom](/blog/2026/neutral-atom-qubits/) · [Photonic](/blog/2026/photonic-qubits/) · [Other platforms](/blog/2026/other-qubit-platforms/)
