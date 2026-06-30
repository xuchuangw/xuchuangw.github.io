---
layout: distill
title: "Photonic qubits: computing with light that barely interacts"
description: "Write a qubit on a single photon and it flies down an optical fiber for free — the perfect quantum-network messenger. The catch is the same property that makes it fly: photons barely touch each other, so making two of them do a logic gate means abandoning the circuit model and computing by measurement. Here is how light became the field's best wire and its most awkward computer."
date: 2026-06-30
tags: quantum photonic
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
  - name: What a photonic qubit is
  - name: How it is built and controlled
  - name: Where it shines
  - name: The honest costs
  - name: State of the art
  - name: Where it sits
---

*Part of the [How to Build a Quantum Computer](/blog/2026/how-to-build-a-quantum-computer/) series.*

The previous three posts were all, secretly, about the same struggle: how to hold a piece of matter still. A superconducting qubit is a circuit faking an atom, cooled to a whisker above absolute zero so it stops twitching. A trapped ion is a real atom you grab by its charge and levitate in vacuum. A neutral atom is a real atom you pinch in a knot of light. Each platform spends most of its engineering budget on the same verb — *holding* — because a qubit that drifts away forgets. This post is about the platform that gives up on holding entirely, and picks a qubit that refuses to sit still by its very nature: a single particle of light. A photonic qubit cannot be trapped, cooled, or pinned; it is always moving at, well, the speed of light. That sounds like a fatal flaw, and for one job — computing — it nearly is. But for the *other* job this series keeps watching, networking, it is the closest thing to a cheat code anyone has found.

The photon's whole character fits on one line: it flies beautifully, it networks natively, and it absolutely hates sitting down to do arithmetic. Let us take that joke seriously, because the physics of computing with non-interacting light is one of the strangest and most ingenious corners of the whole field.

## What a photonic qubit is

Start, as always, with the two-level system. For a transmon it was a fabricated circuit; for an ion or a neutral atom it was two of a real atom's internal levels. Here the qubit is carried by a single **photon** — one quantum of the electromagnetic field — and the cleverness is that a lone photon offers *several* pairs of distinguishable states to choose from. You pick any one pair, call them $\vert 0\rangle$ and $\vert 1\rangle$, and you have your bit riding on a particle that travels at the speed of light. The common "alphabets":

- **Polarization.** Horizontal versus vertical, $\vert H\rangle$ and $\vert V\rangle$. The most intuitive encoding — it is literally the orientation of the light wave — and the one the foundational Bell-test experiments used.
- **Path, or dual-rail.** Send the photon down one of two waveguides or fibers. "Photon in the upper rail" is $\vert 0\rangle$; "photon in the lower rail" is $\vert 1\rangle$. In Fock-state notation, with mode $a$ the upper rail and mode $b$ the lower, those are the states $\vert 10\rangle$ (one photon in $a$, none in $b$) and $\vert 01\rangle$. A general dual-rail qubit is

  $$
  \vert\psi\rangle \;=\; \alpha\,\vert 10\rangle \;+\; \beta\,\vert 01\rangle ,
  $$

  a single photon in a superposition of *which path* it took. This is the encoding most on-chip photonic processors actually use, and the one the figures below assume.
- **Time-bin.** The photon arrives "early" or "late" — two time slots split by an interferometer. Robust in long fibers, where polarization gets scrambled.

Beyond these single-photon encodings sits a whole second philosophy — the **continuous-variable** route, which writes information into the *quadratures* of **squeezed light** (laser light whose quantum noise has been reshaped so that one property is quieter than the usual quantum limit, at the price of another being noisier). It splits into two machines that are easy to confuse and worth keeping apart. Its non-universal *sampling* cousin, **Gaussian boson sampling**, is what the Jiuzhang and Borealis record-setters below run — spectacular, fast, and with no error correction at all. Its fault-tolerant, *universal* version is different: it builds cluster states out of squeezed light and protects logical qubits with the Gottesman–Kitaev–Preskill (GKP) bosonic code — that is Xanadu's Aurora lane. For the story of *how light computes*, though, the single-photon dual-rail picture is the cleanest lens, so we will lean on it (and meet squeezed light again in the State-of-the-art section).

Two things make the photonic qubit feel different from everything before it the moment you meet it. The first is a temperature joke. Because a photon flying through glass or a waveguide barely couples to anything, the **optics run at room temperature** — no dilution fridge, no vacuum cathedral. And yet the machine is not fridge-free, because the two hardest components are cold: the **single-photon detectors** (superconducting nanowires, SNSPDs) need cooling to a few kelvin, and many **single-photon sources** (semiconductor quantum dots) want roughly 4 K. So a "room-temperature quantum computer" still runs a cryostat — just for the bouncers at the door who count photons in and out. The light is warm; the things watching the light are frozen.

The second difference is deeper, and it reshapes the entire engineering problem: a photonic qubit's dominant error is *nothing like* the others'. Superconducting and atomic qubits live in fear of **decoherence** — the slow leak of phase information into the environment, the $T_2$ clock ticking down. A photon in flight barely decoheres at all; it is gloriously isolated, which is exactly why it makes such a good messenger. Its weakness is blunter and more total: **loss**. A photon is either there or it is gone. Every fiber connector, every imperfect detector, every kilometer of glass has some chance of simply eating the photon — standard telecom fiber leaks about $0.2$ dB per kilometer — and when it does, the qubit does not slowly fade or pick up a small phase error. It *vanishes*, all at once. The slogan that organizes this entire platform is therefore: **lose a photon, lose the qubit.** Hold that thought; it is the hinge on which every later strength and cost turns.

## How it is built and controlled

Here is where the photon's nature stops being charming and starts being a genuine problem.

**Single-qubit gates are the easy, beautiful half.** Take a dual-rail qubit — one photon, two paths. A **beam splitter** mixes the two paths, and a **phase shifter** delays one relative to the other. In the Heisenberg picture a beam splitter just transforms the two modes' creation operators linearly into each other,

$$
\hat a^\dagger \;\to\; \cos\theta\,\hat a^\dagger + e^{i\varphi}\sin\theta\,\hat b^\dagger , \qquad
\hat b^\dagger \;\to\; -e^{-i\varphi}\sin\theta\,\hat a^\dagger + \cos\theta\,\hat b^\dagger ,
$$

and for a *single* photon that is a rotation on the Bloch sphere of $\{\vert 10\rangle,\vert 01\rangle\}$. One beam splitter alone is not quite enough for *every* gate, though: with only two knobs $(\theta,\varphi)$ it reaches a restricted family — note that both diagonal entries are the same $\cos\theta$, so a pure relative-phase (a $Z$ rotation) is off the menu. Add two phase shifters — making a **Mach–Zehnder interferometer** — and now you can reach *any* single-qubit gate you like, deterministically, with a "gate time" set by how long light takes to cross a single beam splitter or phase shifter: picoseconds. Single-qubit operations are where photons are happiest. On PsiQuantum's silicon-photonic chips, dual-rail state preparation and measurement reach a fidelity of $99.98\%$ <d-cite key="psiquantum2025omega"></d-cite>.

**Two-qubit gates are where the trouble lives** — and the trouble is fundamental physics, not bad engineering. To entangle two qubits you need them to *interact*: one qubit's state has to change something about the other. But in **linear optics, photons essentially do not interact.** Two beams of light pass straight through each other and emerge unchanged; that is why you can see across a crowded room without the light rays scattering off one another. And here is the deep reason it cannot be patched: what a beam-splitter network does to a million photons is completely fixed by what it does to *one* — there is no extra knob, anywhere in the optics, that lets two photons feel each other. No amount of beam-splitting gives two separate photons a way to push on one another. And a deterministic entangling gate, a controlled-$Z$ say, demands exactly the kind of *nonlinear* coupling — a phase that depends on whether *both* qubits are excited — that single optical photons stubbornly refuse to provide. You cannot build a CZ out of mirrors and beam splitters. Full stop.

So how does anyone entangle light at all? Two great ideas, and they are the intellectual heart of this post.

**Idea one: measurement-induced nonlinearity (the KLM scheme).** Even though photons do not interact, *measuring* them can fake an interaction. The seed is **Hong–Ou–Mandel interference** <d-cite key="hong1987interference"></d-cite>: send two identical photons into a 50:50 beam splitter, one from each side, and the two-photon amplitudes interfere so completely that the photons always leave *together*, never one out of each port. The "both-transmit" and "both-reflect" paths cancel:

$$
\vert 1,1\rangle \;\xrightarrow{\;\text{50:50 BS}\;}\; \tfrac{1}{\sqrt 2}\big(\vert 2,0\rangle - \vert 0,2\rangle\big) .
$$

The beam splitter that produces this bunching is perfectly *linear* — nothing nonlinear has happened yet. The *effective* nonlinearity appears only once we count photons: the act of detecting a particular number in a particular port is what reaches back and reshapes the surviving state. In 2001, Knill, Laflamme, and Milburn turned this into a recipe: combine linear optics with ancillary "helper" photons, photon-number-resolving detectors, and **feed-forward** (using a detector's click to choose what you do to the surviving photons), and you can implement a true entangling gate <d-cite key="knill2001klm"></d-cite>. The price is that the gate is **probabilistic**: it only works when the ancilla detectors fire in a particular pattern, which *heralds* success. A bare two-photon Bell measurement — the basic entangling measurement — succeeds at most $50\%$ of the time with linear optics and ordinary detectors, a hard ceiling proven by Calsamiglia and Lütkenhaus <d-cite key="calsamiglia2001bellanalyzer"></d-cite>; ancillary resources can push past it, but never trivially. KLM's deep result was that, by spending more and more ancillas and wrapping the gates in teleportation and error-correction, you can drive the success probability *toward* one and make universal photonic computing **efficient** — polynomial overhead, not exponential. A landmark of theory. Also, in practice, a lot of slot machines.

<figure class="l-body" style="text-align:center; margin:1.5rem auto; max-width:720px;">
  <svg viewBox="0 0 720 420" role="img" aria-label="A measurement-induced two-qubit entangling gate on dual-rail photonic qubits. Two data qubits, each a single photon in superposition over its pair of rails, enter a linear-optics network together with two ancilla helper photons. Inside the network, beam splitters mix the rails, including a coupling between a data rail and an ancilla rail. The two ancilla modes leave the network into photon-number detectors; their clicks feed forward classically to a phase correction on the data rails. The two data qubits emerge entangled, but only when the detectors herald success, with probability less than one." style="width:100%; height:auto; font-family:sans-serif;">
    <defs>
      <marker id="p1a" markerWidth="8" markerHeight="8" refX="6" refY="4" orient="auto"><path d="M0 0 L8 4 L0 8 Z" fill="currentColor"/></marker>
    </defs>
    <!-- qubit 1 rails in -->
    <line x1="60" y1="68" x2="250" y2="68" stroke="currentColor" stroke-width="1.6"/>
    <line x1="60" y1="100" x2="250" y2="100" stroke="currentColor" stroke-width="1.6"/>
    <circle cx="98" cy="68" r="7" fill="#14b8a6" fill-opacity="0.16" stroke="#14b8a6" stroke-width="1.7"/>
    <circle cx="98" cy="100" r="7" fill="#14b8a6" fill-opacity="0.16" stroke="#14b8a6" stroke-width="1.7"/>
    <path d="M84 68 Q76 84 84 100" fill="none" stroke="#14b8a6" stroke-width="1.2" opacity="0.75"/>
    <text x="60" y="54" fill="#14b8a6" font-size="12">qubit 1 &#160; &#x3B1;|10&#x27E9;+&#x3B2;|01&#x27E9;</text>
    <text x="52" y="72" fill="currentColor" font-size="10" text-anchor="end">a&#8321;</text>
    <text x="52" y="104" fill="currentColor" font-size="10" text-anchor="end">b&#8321;</text>
    <!-- qubit 2 rails in -->
    <line x1="60" y1="150" x2="250" y2="150" stroke="currentColor" stroke-width="1.6"/>
    <line x1="60" y1="182" x2="250" y2="182" stroke="currentColor" stroke-width="1.6"/>
    <circle cx="98" cy="150" r="7" fill="#14b8a6" fill-opacity="0.16" stroke="#14b8a6" stroke-width="1.7"/>
    <circle cx="98" cy="182" r="7" fill="#14b8a6" fill-opacity="0.16" stroke="#14b8a6" stroke-width="1.7"/>
    <path d="M84 150 Q76 166 84 182" fill="none" stroke="#14b8a6" stroke-width="1.2" opacity="0.75"/>
    <text x="60" y="136" fill="#14b8a6" font-size="12">qubit 2 &#160; &#x3B3;|10&#x27E9;+&#x3B4;|01&#x27E9;</text>
    <text x="52" y="154" fill="currentColor" font-size="10" text-anchor="end">a&#8322;</text>
    <text x="52" y="186" fill="currentColor" font-size="10" text-anchor="end">b&#8322;</text>
    <!-- ancilla rails in -->
    <line x1="60" y1="235" x2="250" y2="235" stroke="currentColor" stroke-width="1.6"/>
    <line x1="60" y1="270" x2="250" y2="270" stroke="currentColor" stroke-width="1.6"/>
    <circle cx="98" cy="235" r="7" fill="#e0a106" fill-opacity="0.32" stroke="#e0a106" stroke-width="2"/>
    <circle cx="98" cy="270" r="7" fill="#e0a106" fill-opacity="0.32" stroke="#e0a106" stroke-width="2"/>
    <text x="60" y="300" fill="#e0a106" font-size="12">ancilla photons (helpers)</text>
    <!-- network box -->
    <rect x="250" y="50" width="150" height="246" rx="6" fill="none" stroke="#4f7cff" stroke-width="1.8"/>
    <line x1="250" y1="68" x2="400" y2="68" stroke="currentColor" stroke-width="1.6" opacity="0.5"/>
    <line x1="250" y1="100" x2="400" y2="100" stroke="currentColor" stroke-width="1.6" opacity="0.5"/>
    <line x1="250" y1="150" x2="400" y2="150" stroke="currentColor" stroke-width="1.6" opacity="0.5"/>
    <line x1="250" y1="182" x2="400" y2="182" stroke="currentColor" stroke-width="1.6" opacity="0.5"/>
    <line x1="250" y1="235" x2="400" y2="235" stroke="currentColor" stroke-width="1.6" opacity="0.5"/>
    <line x1="250" y1="270" x2="400" y2="270" stroke="currentColor" stroke-width="1.6" opacity="0.5"/>
    <!-- beam-splitter glyphs inside the network -->
    <line x1="284" y1="76" x2="300" y2="92" stroke="currentColor" stroke-width="1.8"/>
    <line x1="318" y1="118" x2="334" y2="132" stroke="currentColor" stroke-width="1.8"/>
    <line x1="292" y1="158" x2="308" y2="174" stroke="currentColor" stroke-width="1.8"/>
    <line x1="306" y1="244" x2="322" y2="261" stroke="currentColor" stroke-width="1.8"/>
    <!-- the crucial data<->ancilla coupling -->
    <line x1="340" y1="201" x2="358" y2="217" stroke="currentColor" stroke-width="2.4"/>
    <circle cx="349" cy="209" r="3.4" fill="none" stroke="currentColor" stroke-width="1.4"/>
    <text x="312" y="62" fill="#4f7cff" font-size="11" text-anchor="middle">linear-optics network</text>
    <text x="312" y="312" fill="#4f7cff" font-size="9.5" text-anchor="middle">beam splitters + phase shifters</text>
    <!-- data outputs -->
    <line x1="400" y1="68" x2="638" y2="68" stroke="currentColor" stroke-width="1.6"/>
    <line x1="400" y1="100" x2="638" y2="100" stroke="currentColor" stroke-width="1.6"/>
    <line x1="400" y1="150" x2="638" y2="150" stroke="currentColor" stroke-width="1.6"/>
    <line x1="400" y1="182" x2="638" y2="182" stroke="currentColor" stroke-width="1.6"/>
    <!-- correction box across data rails -->
    <rect x="470" y="58" width="34" height="134" rx="4" fill="none" stroke="currentColor" stroke-width="1.6"/>
    <text x="487" y="130" fill="currentColor" font-size="15" text-anchor="middle">&#x3C6;</text>
    <text x="487" y="50" fill="currentColor" font-size="9.5" text-anchor="middle">correction</text>
    <!-- entanglement bracket on the right -->
    <path d="M636 68 Q652 68 652 125 Q652 182 636 182" fill="none" stroke="#14b8a6" stroke-width="1.8"/>
    <text x="658" y="121" fill="#14b8a6" font-size="11.5">entangled</text>
    <text x="658" y="136" fill="#14b8a6" font-size="11.5">pair</text>
    <!-- ancilla outputs to detectors -->
    <line x1="400" y1="235" x2="452" y2="235" stroke="currentColor" stroke-width="1.6"/>
    <line x1="400" y1="270" x2="452" y2="270" stroke="currentColor" stroke-width="1.6"/>
    <path d="M452 224 L452 246 L476 235 Z" fill="#e0a106" fill-opacity="0.25" stroke="#e0a106" stroke-width="1.8"/>
    <path d="M452 259 L452 281 L476 270 Z" fill="#e0a106" fill-opacity="0.25" stroke="#e0a106" stroke-width="1.8"/>
    <text x="486" y="239" fill="#e0a106" font-size="12">D</text>
    <text x="486" y="274" fill="#e0a106" font-size="12">D</text>
    <text x="452" y="302" fill="#e0a106" font-size="11">photon-number detection</text>
    <!-- feed-forward from detector up into the correction box -->
    <polyline points="476,235 510,235 510,192" fill="none" stroke="currentColor" stroke-width="1.4" stroke-dasharray="5 4" marker-end="url(#p1a)" opacity="0.9"/>
    <text x="516" y="220" fill="currentColor" font-size="11" text-anchor="start">feed-forward</text>
    <text x="360" y="402" fill="currentColor" font-size="13" text-anchor="middle">photons barely interact &#8212; the ancilla measurement supplies the nonlinearity; the gate is heralded, firing only with probability p &lt; 1</text>
  </svg>
  <figcaption style="margin-top:.5rem;"><b>Figure 1.</b> A measurement-induced (KLM-style) two-qubit entangling gate. Two dual-rail data qubits (teal — each one photon spread over both of its rails) and two ancilla helper photons (amber) enter a passive linear-optics network (blue). Inside, beam splitters mix the rails — including a coupling between a data rail and an ancilla rail (the bold mark), which is how a later detector click can reach back to the data. The two ancilla modes are measured by photon-number detectors; their outcome is <em>fed forward</em> as a correction $\varphi$ on the data rails, and the two qubits leave <em>entangled</em>. Because beam splitters cannot make photons interact, the entanglement comes entirely from the <em>measurement</em> — so the gate is <em>probabilistic</em>: it works only when the detectors herald success, otherwise the run is discarded and retried.</figcaption>
</figure>

**Idea two: stop running a circuit at all — compute by measuring (cluster states and fusion).** If gates are probabilistic and photons hate being stored, the whole "apply gate 1, then gate 2, then gate 3" picture is a bad fit. So photonics largely abandons it for a different model of computation entirely. In **measurement-based quantum computing**, due to Raussendorf and Briegel, you first build one big, highly entangled state — a **cluster state**, a lattice of qubits all linked together — and then you *compute by measuring its qubits one at a time*, choosing each measurement's basis based (by feed-forward) on earlier outcomes <d-cite key="raussendorf2001oneway"></d-cite>. The entanglement is the "program"; the measurements run it; the cluster is consumed as you go. This is a spectacular match for light, because all the hard, probabilistic entangling can be done *offline and in advance* — you keep firing your probabilistic gates until, by luck and multiplexing, a cluster state assembles — and then the actual computation is nothing but single-photon measurements, which photons are wonderful at.

The modern, hardware-minded refinement is **fusion-based quantum computing** (FBQC), introduced by Bartolucci and colleagues at PsiQuantum <d-cite key="bartolucci2023fusion"></d-cite>. Instead of building one enormous cluster, you mass-produce many tiny, identical, constant-sized **resource states** — small bundles of a few entangled photons each — and stitch them together with **fusion measurements**: destructive two-photon entangling measurements (essentially Bell measurements) that, when they succeed, weld two resource states into a larger entangled fabric. Each individual fusion is probabilistic and lossy, but the architecture is *designed around that*: with enough redundancy and multiplexing, and as long as photon loss stays below a hardware threshold, the surviving fusions knit together a fault-tolerant cluster. It is the assembly line that finally makes "compute by measurement" look like a manufacturable machine rather than a thought experiment. Figure 2 shows the core move.

<figure class="l-body" style="text-align:center; margin:1.5rem auto; max-width:700px;">
  <svg viewBox="0 0 720 388" role="img" aria-label="Fusion of two small entangled resource states into a larger cluster state. On the left, resource state A is a small graph of teal nodes joined by edges; on the right, resource state B is a mirror-image small graph. The innermost qubit of each, drawn as a hollow node with an amber cross, is sent into a central fusion measurement, a dashed amber box labelled fusion, approximately a Bell measurement, which consumes both of those photons. A downward arrow leads to a single larger cluster state at the bottom. The two fused photons are gone; their former neighbours are now joined by one new amber edge, leaving six nodes." style="width:100%; height:auto; font-family:sans-serif;">
    <defs>
      <marker id="p2a" markerWidth="9" markerHeight="9" refX="4.5" refY="4.5" orient="auto"><path d="M0 0 L9 4.5 L0 9 Z" fill="currentColor"/></marker>
    </defs>
    <!-- resource state A -->
    <text x="160" y="48" fill="#14b8a6" font-size="13" text-anchor="middle">resource state A</text>
    <line x1="120" y1="85" x2="195" y2="110" stroke="currentColor" stroke-width="1.6"/>
    <line x1="120" y1="135" x2="195" y2="110" stroke="currentColor" stroke-width="1.6"/>
    <line x1="195" y1="110" x2="300" y2="110" stroke="currentColor" stroke-width="1.6"/>
    <circle cx="120" cy="85" r="8" fill="#14b8a6" fill-opacity="0.30" stroke="#14b8a6" stroke-width="2"/>
    <circle cx="120" cy="135" r="8" fill="#14b8a6" fill-opacity="0.30" stroke="#14b8a6" stroke-width="2"/>
    <circle cx="195" cy="110" r="8" fill="#14b8a6" fill-opacity="0.30" stroke="#14b8a6" stroke-width="2"/>
    <!-- A's fused qubit: consumed (hollow + amber cross) -->
    <circle cx="300" cy="110" r="9" fill="none" stroke="#14b8a6" stroke-width="1.6" opacity="0.7"/>
    <line x1="294" y1="104" x2="306" y2="116" stroke="#e0a106" stroke-width="1.8"/>
    <line x1="294" y1="116" x2="306" y2="104" stroke="#e0a106" stroke-width="1.8"/>
    <!-- resource state B (mirror) -->
    <text x="560" y="48" fill="#14b8a6" font-size="13" text-anchor="middle">resource state B</text>
    <line x1="600" y1="85" x2="525" y2="110" stroke="currentColor" stroke-width="1.6"/>
    <line x1="600" y1="135" x2="525" y2="110" stroke="currentColor" stroke-width="1.6"/>
    <line x1="525" y1="110" x2="420" y2="110" stroke="currentColor" stroke-width="1.6"/>
    <circle cx="600" cy="85" r="8" fill="#14b8a6" fill-opacity="0.30" stroke="#14b8a6" stroke-width="2"/>
    <circle cx="600" cy="135" r="8" fill="#14b8a6" fill-opacity="0.30" stroke="#14b8a6" stroke-width="2"/>
    <circle cx="525" cy="110" r="8" fill="#14b8a6" fill-opacity="0.30" stroke="#14b8a6" stroke-width="2"/>
    <!-- B's fused qubit: consumed (hollow + amber cross) -->
    <circle cx="420" cy="110" r="9" fill="none" stroke="#14b8a6" stroke-width="1.6" opacity="0.7"/>
    <line x1="414" y1="104" x2="426" y2="116" stroke="#e0a106" stroke-width="1.8"/>
    <line x1="414" y1="116" x2="426" y2="104" stroke="#e0a106" stroke-width="1.8"/>
    <!-- fusion measurement box -->
    <line x1="309" y1="110" x2="330" y2="110" stroke="#e0a106" stroke-width="1.8" stroke-dasharray="4 3"/>
    <line x1="390" y1="110" x2="411" y2="110" stroke="#e0a106" stroke-width="1.8" stroke-dasharray="4 3"/>
    <rect x="330" y="86" width="60" height="48" rx="5" fill="#e0a106" fill-opacity="0.08" stroke="#e0a106" stroke-width="1.8" stroke-dasharray="5 4"/>
    <text x="360" y="108" fill="#e0a106" font-size="12.5" text-anchor="middle">fusion</text>
    <text x="360" y="124" fill="#e0a106" font-size="9.5" text-anchor="middle">&#8776; Bell meas.</text>
    <text x="360" y="156" fill="#e0a106" font-size="10.5" text-anchor="middle">both photons consumed</text>
    <!-- arrow down -->
    <line x1="360" y1="166" x2="360" y2="214" stroke="currentColor" stroke-width="1.6" marker-end="url(#p2a)"/>
    <text x="360" y="240" fill="currentColor" font-size="13" text-anchor="middle" font-weight="600">one larger cluster state</text>
    <!-- merged cluster bottom: 6 surviving nodes, neighbours welded -->
    <line x1="150" y1="290" x2="220" y2="310" stroke="currentColor" stroke-width="1.6"/>
    <line x1="150" y1="330" x2="220" y2="310" stroke="currentColor" stroke-width="1.6"/>
    <line x1="220" y1="310" x2="500" y2="310" stroke="#e0a106" stroke-width="2.8"/>
    <line x1="500" y1="310" x2="570" y2="290" stroke="currentColor" stroke-width="1.6"/>
    <line x1="500" y1="310" x2="570" y2="330" stroke="currentColor" stroke-width="1.6"/>
    <circle cx="150" cy="290" r="8" fill="#14b8a6" fill-opacity="0.30" stroke="#14b8a6" stroke-width="2"/>
    <circle cx="150" cy="330" r="8" fill="#14b8a6" fill-opacity="0.30" stroke="#14b8a6" stroke-width="2"/>
    <circle cx="220" cy="310" r="8" fill="#14b8a6" fill-opacity="0.30" stroke="#14b8a6" stroke-width="2"/>
    <circle cx="500" cy="310" r="8" fill="#14b8a6" fill-opacity="0.30" stroke="#14b8a6" stroke-width="2"/>
    <circle cx="570" cy="290" r="8" fill="#14b8a6" fill-opacity="0.30" stroke="#14b8a6" stroke-width="2"/>
    <circle cx="570" cy="330" r="8" fill="#14b8a6" fill-opacity="0.30" stroke="#14b8a6" stroke-width="2"/>
    <text x="360" y="300" fill="#e0a106" font-size="10.5" text-anchor="middle">new link</text>
    <text x="360" y="372" fill="currentColor" font-size="12.5" text-anchor="middle">the two fused photons are gone &#8212; their former neighbours inherit the new bond</text>
  </svg>
  <figcaption style="margin-top:.5rem;"><b>Figure 2.</b> Fusion-based quantum computing. Two small, constant-size entangled <em>resource states</em> (teal graphs) each send one photon into a <em>fusion</em> measurement (amber, roughly a Bell measurement). The fusion is <em>destructive</em>: it measures away both contributed photons (hollow, crossed-out nodes) and, when it succeeds, welds their surviving <em>neighbours</em> together — the new bond in amber. Eight qubits go in; the two fused ones are consumed; six remain, now joined into one larger cluster. Each fusion is probabilistic and lossy — capped near $50\%$ for bare linear optics <d-cite key="calsamiglia2001bellanalyzer"></d-cite> — so the machine mass-produces resource states and multiplexes many fusion attempts, knitting a fault-tolerant cluster from the ones that succeed.</figcaption>
</figure>

Notice the through-line of both ideas: photonics buys determinism with *numbers*. Rather than hope one probabilistic gate or one fusion pays off, you build thousands in parallel and use fast optical switches to route the lucky successes onward. That brute-force-and-elegant strategy, **multiplexing**, is the master key of the platform — and, as we are about to see, the source of its heaviest bill.

## Where it shines

Add up the photon's virtues and a clear identity emerges: it is a so-so computer wrapped around a world-class *network node*. Four strengths, the last of which is the one that matters most for this series.

**Room temperature.** The optical core needs no dilution fridge: a photon barely couples to anything, so the light itself runs warm. (Its sources and detectors are the cold exception, an asterisk the next section settles.)

**Almost no decoherence in flight.** Because a flying photon is so weakly coupled to its surroundings, it does not gather phase errors the way a transmon or an atom does sitting in its trap — there is essentially no $T_2$ clock ticking down mid-flight. The qubit that is hardest to *store* is, paradoxically, one of the easiest to *keep faithful while it travels*.

**Speed and manufacturability.** Single-qubit gates happen at the speed of light crossing a chip, and the chips themselves can be made in a commercial silicon-photonics foundry. PsiQuantum fabricated its Omega chipset on a standard semiconductor line at GlobalFoundries and reported component fidelities — $99.98\%$ state preparation and measurement, $99.50\%$ two-photon interference visibility between *independent* sources, $99.22\%$ two-qubit fusion — that read like a mature platform, not a lab curiosity <d-cite key="psiquantum2025omega"></d-cite>. (The crucial asterisk on all of those, which we honor in the next section: they are *conditional on the photon being detected* — they do not include loss.)

**It is born to network — the trump card.** This is where the photon stops being a runner-up and becomes the obvious choice. Every other platform, to send quantum information across a room or a city, must first *convert* its qubit into a photon that can enter an optical fiber. For trapped ions and neutral atoms that conversion is at least natural — an atom can emit a photon entangled with its internal state — but it still has to be coaxed and collected. For superconducting qubits it is a near-disaster: their information lives in ~5 GHz microwave photons that cannot travel down an optical fiber at all, so they need a microwave-to-optical **transducer**, a translation box that today is lossy and immature. The photonic qubit skips the entire problem, because **the qubit already *is* an optical photon.** No conversion, no transducer — write your state on a telecom-band photon and drop it straight into off-the-shelf fiber. Consequently the core operations of a quantum network — quantum key distribution, teleportation, entanglement distribution, the quantum repeaters that would tie distant nodes together — are all *native* to photons rather than bolt-on tricks.

<figure class="l-body" style="text-align:center; margin:1.5rem auto; max-width:700px;">
  <svg viewBox="0 0 720 360" role="img" aria-label="How each platform gets a qubit into an optical fiber. Top row: a superconducting qubit, carrying about 5 gigahertz microwave information, must pass through a microwave-to-optical transducer box, marked lossy and immature in amber and red, before it can enter the telecom fiber drawn in blue. Middle row: a trapped ion or neutral atom must emit and collect a photon, a natural but coaxed step, before the fiber. Bottom row: a photonic qubit, drawn in teal, runs straight into the telecom fiber with no intermediate box, because the qubit already is the photon." style="width:100%; height:auto; font-family:sans-serif;">
    <defs>
      <marker id="p3a" markerWidth="8" markerHeight="8" refX="6" refY="4" orient="auto"><path d="M0 0 L8 4 L0 8 Z" fill="currentColor"/></marker>
      <marker id="p3b" markerWidth="8" markerHeight="8" refX="6" refY="4" orient="auto"><path d="M0 0 L8 4 L0 8 Z" fill="#4f7cff"/></marker>
    </defs>
    <text x="360" y="26" fill="currentColor" font-size="14" text-anchor="middle" font-weight="600">Getting a qubit into an optical fiber</text>
    <!-- row 1: superconducting -->
    <rect x="24" y="58" width="150" height="48" rx="6" fill="none" stroke="currentColor" stroke-width="1.7"/>
    <text x="99" y="79" fill="currentColor" font-size="12" text-anchor="middle">Superconducting</text>
    <text x="99" y="95" fill="currentColor" font-size="10" text-anchor="middle">~5 GHz microwave</text>
    <line x1="174" y1="82" x2="214" y2="82" stroke="currentColor" stroke-width="1.6" marker-end="url(#p3a)"/>
    <rect x="220" y="56" width="168" height="52" rx="6" fill="#e0a106" fill-opacity="0.08" stroke="#e0a106" stroke-width="1.8"/>
    <text x="304" y="77" fill="#e0a106" font-size="11.5" text-anchor="middle">microwave&#8594;optical transducer</text>
    <text x="304" y="95" fill="#ef4444" font-size="10.5" text-anchor="middle">lossy &amp; immature</text>
    <line x1="388" y1="82" x2="430" y2="82" stroke="currentColor" stroke-width="1.6" marker-end="url(#p3a)"/>
    <path d="M432 82 H684" fill="none" stroke="#4f7cff" stroke-width="2.4" marker-end="url(#p3b)"/>
    <text x="556" y="74" fill="#4f7cff" font-size="10.5" text-anchor="middle">telecom fiber</text>
    <!-- row 2: ion / atom -->
    <rect x="24" y="160" width="150" height="48" rx="6" fill="none" stroke="currentColor" stroke-width="1.7"/>
    <text x="99" y="181" fill="currentColor" font-size="12" text-anchor="middle">Trapped ion /</text>
    <text x="99" y="197" fill="currentColor" font-size="12" text-anchor="middle">neutral atom</text>
    <line x1="174" y1="184" x2="214" y2="184" stroke="currentColor" stroke-width="1.6" marker-end="url(#p3a)"/>
    <rect x="220" y="158" width="168" height="52" rx="6" fill="none" stroke="currentColor" stroke-width="1.6"/>
    <text x="304" y="179" fill="currentColor" font-size="11.5" text-anchor="middle">emit + collect a photon</text>
    <text x="304" y="197" fill="currentColor" font-size="10" text-anchor="middle" opacity="0.8">natural, but must be coaxed</text>
    <line x1="388" y1="184" x2="430" y2="184" stroke="currentColor" stroke-width="1.6" marker-end="url(#p3a)"/>
    <path d="M432 184 H684" fill="none" stroke="#4f7cff" stroke-width="2.4" marker-end="url(#p3b)"/>
    <!-- row 3: photonic -->
    <rect x="24" y="262" width="150" height="48" rx="6" fill="none" stroke="#14b8a6" stroke-width="2"/>
    <text x="99" y="283" fill="#14b8a6" font-size="12" text-anchor="middle">Photonic</text>
    <text x="99" y="299" fill="#14b8a6" font-size="10" text-anchor="middle">the qubit is the photon</text>
    <path d="M174 286 H684" fill="none" stroke="#4f7cff" stroke-width="2.4" marker-end="url(#p3b)"/>
    <text x="430" y="277" fill="#14b8a6" font-size="11.5" text-anchor="middle">no transducer &#8212; straight into the fiber</text>
  </svg>
  <figcaption style="margin-top:.5rem;"><b>Figure 3.</b> Why the photon is the field's best network wire. To send a qubit down an optical fiber, every other platform must first turn it into light. A superconducting qubit needs a microwave→optical <em>transducer</em> (today lossy and immature); a trapped ion or neutral atom must emit and collect a photon (natural, but coaxed). The photonic qubit skips all of it — it is <em>already</em> a telecom-band photon, so it drops straight into the same fiber the internet runs on. No transducer, no conversion: here the qubit and the wire are one and the same.</figcaption>
</figure>

PsiQuantum demonstrated this directly with a chip-to-chip entangling link that distributed qubits across $42$ m of standard telecom fiber at $99.72\%$ fidelity <d-cite key="psiquantum2025omega"></d-cite>. Room-temperature optics, near-zero in-flight decoherence, foundry manufacturing, and telecom fiber that the entire internet already runs on: it is genuinely hard to imagine a qubit better suited to be the *wire* of a future quantum internet.

This is the lens the series keeps returning to. Of the five platforms, the photon may be the weakest stand-alone computer, yet it is the consensus best **network node** — because it never has to *become* a photon to travel. The debt is old and deep: the 2022 Nobel Prize in Physics went to Alain Aspect, John Clauser, and Anton Zeilinger for the experiments with entangled photons that turned Bell's inequality from philosophy into measurable physics and founded quantum information science <d-cite key="nobel2022entanglement"></d-cite>. Photons were the original quantum-information carriers, and they remain the only ones that move.

## The honest costs

Now settle the bill, because the same non-interaction that makes the photon a perfect messenger makes it an awkward computer, and the costs are as blunt as the strengths.

**Loss is the enemy, and it is a different *kind* of enemy.** Return to the slogan: lose a photon, lose the qubit. Where other platforms must keep their gate *errors* below a fault-tolerance threshold, photonics must keep its qubit *disappearance* rate below one — a tougher demand, because a lost photon is a whole missing qubit, not a small rotation error. There is one consolation: photon loss is an **erasure** error — you usually know *which* qubit went missing (its detector simply never clicked), and located errors are easier to correct than unlocated ones. Fusion-based architectures lean hard on exactly this, and Bartolucci and colleagues quote explicit per-component loss thresholds their codes can tolerate <d-cite key="bartolucci2023fusion"></d-cite>. But "explicit and finite" is not "generous": every connector, switch, and metre of fiber is another place to leak, and the loss budget for a useful machine is brutally tight. The entire platform is, at bottom, an arms race against the photon quietly vanishing.

**Probabilistic gates mean staggering overhead.** Multiplexing is clever, but at fault-tolerant scale the bookkeeping is sobering. Each logical operation rests on many probabilistic fusions; each fusion needs several resource states; each resource state needs several near-perfect single photons; and to make the probabilistic pieces behave deterministically you replicate everything many times over and switch between the successes. The honest estimate for a useful, universal photonic machine runs to **millions of components** — sources, beam splitters, switches, detectors, delay lines — all phase-stable and synchronized at once. And every one of those millions of components is another opportunity to lose a photon, which feeds straight back into the first problem.

**No good memory, and a synchronization headache.** A photon will not hold still, so "store this qubit for a moment while I wait for its partner" is genuinely hard. Today's stopgap is almost comic: to delay a photon you send it on a longer trip — literally a loop of optical fiber as a **delay line**. Xanadu's Aurora prototype carries about $13$ km of fiber for exactly this kind of timing and buffering <d-cite key="aghaeerad2025aurora"></d-cite>. It works, but it is the quantum-computing equivalent of "keep moving so you don't fall over," and it does not replace a true quantum memory; long-distance networking will still need dedicated memories and repeaters in the relay. On top of that, getting thousands of independently produced photons to arrive at the same beam splitter at the same instant, indistinguishable, is a hard synchronization problem in its own right.

**The components have to be nearly perfect — and some of them are cold.** The whole scheme assumes **near-deterministic single-photon sources** (you want exactly one photon, on demand, every time) and **high-efficiency detectors** (you cannot afford to miss the photons you do have). Reality is closing the gap but is not there: the best quantum-dot sources reach roughly $57\%$ end-to-end efficiency with $\sim97.5\%$ indistinguishability <d-cite key="tomm2021singlephoton"></d-cite>, and the best superconducting-nanowire detectors hit $98\%$ system efficiency at telecom wavelength <d-cite key="reddy2020snspd"></d-cite> — both excellent, both still short of the ruthless requirements that loss imposes, and both needing cryogenic cooling. So the "room-temperature computer" quietly runs a fridge for its sources and detectors after all — the one cold corner it cannot design away.

## State of the art

The photonic scoreboard splits cleanly in two, and the single most important habit for reading it is the series' golden rule, sharpened: **do not mistake a few thousand photons for a few thousand qubits.**

**The boson-sampling lane — big numbers, narrow task.** The headline "quantum advantage" results on this platform come from **Gaussian boson sampling** (GBS), a specialized experiment: inject squeezed light into a big interferometer and sample where the photons come out, a distribution believed hard to reproduce classically. USTC's **Jiuzhang 1.0** kicked it off in 2020 with up to $76$ detected photons and a claimed $\sim10^{14}$-fold speedup over classical simulation <d-cite key="zhong2020jiuzhang"></d-cite>; Xanadu's **Borealis** followed in 2022 with a programmable, time-multiplexed machine over $216$ squeezed modes <d-cite key="madsen2022borealis"></d-cite>; and in 2026 USTC's **Jiuzhang 4.0** pushed to $1{,}024$ squeezed states across $8{,}176$ modes, with detection events up to **3,050 photons**, producing a sample in $25.6\,\mu$s against an estimated $>10^{42}$ years for the best classical method on a leading supercomputer <d-cite key="liu2026jiuzhang4"></d-cite>. Genuinely staggering. But two caveats are load-bearing, and the careful reader keeps both in hand. First, **GBS is not universal computation** — it samples one fixed distribution, it cannot run an arbitrary algorithm, and it has no error correction; it is a physics demonstration, not a programmable computer. Second, the advantage claims have been a *moving target*: in 2024 Oh and colleagues introduced a classical tensor-network algorithm that exploits photon **loss** to spoof the output of earlier GBS experiments, undercutting some of their advantage claims <d-cite key="oh2024classicalgbs"></d-cite>. To its credit, Jiuzhang 4.0 was explicitly benchmarked against that very class of loss-based classical attack and designed to stay beyond its reach <d-cite key="liu2026jiuzhang4"></d-cite> — but the back-and-forth is itself the lesson: "advantage" is defined against the *best known* classical algorithm, and that bar keeps rising.

**The universal lane — small numbers, real architecture.** Measured as *programmable, universal* machines, photonic processors are still tiny, and the field is refreshingly honest about it. Xanadu's **Aurora**, published in *Nature* in 2025, is a $12$-qubit-scale prototype — but its form factor is the actual point: $35$ photonic chips across four fiber-networked server racks, $\sim13$ km of fiber, all at room temperature, stitching a cluster state *across separate chips* and running real-time measurement-based error correction <d-cite key="aghaeerad2025aurora"></d-cite>. It is a scale model of how a modular, networked photonic data center would grow, not a finished computer. Quandela, building around its own quantum-dot single-photon sources, has likewise fielded $12$-qubit machines — one delivered to France's CEA supercomputing center in 2025, with a larger successor on the roadmap <d-cite key="quandela2025lucy"></d-cite>. Million-qubit universal photonics, the regime where fusion-based fault tolerance would actually pay off, remains a roadmap, not a product.

**The players and their bets.** **PsiQuantum** is pursuing fusion-based, silicon-photonics fault tolerance at foundry scale, betting on its Omega chipset and a manufacturing partnership to reach a million qubits <d-cite key="psiquantum2025omega"></d-cite><d-cite key="bartolucci2023fusion"></d-cite>. **Xanadu** runs the continuous-variable / GKP line, from Borealis to Aurora <d-cite key="madsen2022borealis"></d-cite><d-cite key="aghaeerad2025aurora"></d-cite>. **USTC** owns the boson-sampling frontier with the Jiuzhang series <d-cite key="zhong2020jiuzhang"></d-cite><d-cite key="liu2026jiuzhang4"></d-cite>. **Quandela** sells quantum-dot single-photon hardware <d-cite key="quandela2025lucy"></d-cite>, and **ORCA Computing** works a time-bin, fiber-loop approach. Different encodings, different error-correction philosophies, one shared physical fact: the qubit is a photon. And beneath all of it sits the founding theory — KLM's 2001 proof that linear optics, measurement, and feed-forward are enough for universal computation <d-cite key="knill2001klm"></d-cite> — and the founding experiments, the entangled-photon Bell tests honored by the 2022 Nobel <d-cite key="nobel2022entanglement"></d-cite>.

The same three caveats that discipline every post in this series apply here, in their photonic dialect: a few thousand *photons* in a sampling machine are not a few thousand *qubits* in a computer; a component fidelity quoted *conditional on detection* is not the same number once loss is counted; and a boson-sampling advantage is a demonstration about one task, not a programmable, error-corrected computation.

## Where it sits

A photonic qubit is the field's **flying messenger**: not the strongest computer in the room, but the only qubit that travels by nature, and the consensus best node for a quantum network. Its strengths — room-temperature optics, near-zero in-flight decoherence, foundry manufacturing, and a qubit that drops straight into telecom fiber — and its weaknesses — total loss instead of gentle decoherence, probabilistic gates with millions-of-components overhead, no real memory, and cold sources and detectors — are two readings of the same fact: a photon barely interacts with anything, including the other photons you wish it would entangle with.

So the answer to this series' recurring question is, for once, lopsided. *Can it compute?* Yes, in principle — KLM proved it, and fusion-based architectures give a credible, if enormous, blueprint — but today's universal machines hold about a dozen qubits, and the road to a useful one runs through millions of near-perfect, low-loss components. *Can it network?* Better than anything else here. It does not need a transducer, it does not need to coax a photon out of an atom, it does not need to be collected from a cavity. It *is* the photon. Where the superconducting node's honest answer was "not yet" and the atomic nodes' was "natural" and "promising," the photon's is simply: **it is the wire.**

| | Superconducting | Trapped ion | Neutral atom | Photonic |
|---|---|---|---|---|
| **Qubit** | printed circuit (transmon) | a real atom (ion) | a real atom | a photon |
| **Gate speed** | very fast (~10–70 ns) | slow (~µs) | slow (~µs) | n/a (measurement) |
| **Coherence** | short (~0.1–1.7 ms) | very long (s–min) | long (s) | loss-limited |
| **Connectivity** | mostly nearest-neighbor | all-to-all | reconfigurable | hard (no interaction) |
| **Operating temp** | ~10 mK (dilution fridge) | room-temp vacuum | room-temp vacuum | room-temp optics (cold sources/detectors) |
| **As a network node** | needs transduction | natural (emits photons) | promising | it *is* the photon |

No platform wins every row — the whole reason five of them are still racing. Superconducting out-sprints decoherence; the trapped ion out-lasts and out-connects everyone; the neutral atom out-scales them; and the photon, last in this lineup for raw computing, is first and nearly uncontested for the one job none of the others can do without help — being the link that carries a qubit from one machine to the next. If your wish list is a general-purpose quantum computer today, the photon is not your pick. If your wish list is a *wire to connect every quantum computer together*, almost nothing else comes close. There is one route in this series still unbuilt — the platform that leaves light behind and returns to the solid state, to electron and nuclear spins in silicon and diamond, and to a quasiparticle that may not even exist. The sixth and final build: **solid-state spins and the rest**.

---

**More in this series — [How to Build a Quantum Computer](/blog/2026/how-to-build-a-quantum-computer/):** [Superconducting](/blog/2026/superconducting-qubits/) · [Trapped ion](/blog/2026/trapped-ion-qubits/) · [Neutral atom](/blog/2026/neutral-atom-qubits/) · [Photonic](/blog/2026/photonic-qubits/) · [Other platforms](/blog/2026/other-qubit-platforms/)
