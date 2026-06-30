---
layout: distill
title: "Other qubit platforms: silicon spins, diamond defects, and a qubit that may not exist"
description: "Beyond the big four lies a scrappier crowd of qubits, each betting everything on one breakthrough the front-runners cannot reach: a spin in silicon you could mass-produce on a chip line, a flaw in diamond born to network, and a Majorana quasiparticle that would protect itself in hardware — if it turns out to exist at all. A survey of the contenders still in the race."
date: 2026-06-30
tags: quantum spin-qubits topological
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
  - name: Why there are still more routes
  - name: Semiconductor spin qubits
  - name: Topological qubits
  - name: Color centers in diamond
  - name: The long tail
  - name: Where they sit
---

*Part of the [How to Build a Quantum Computer](/blog/2026/how-to-build-a-quantum-computer/) series.*

The four previous posts each followed one road to its horizon: a superconducting circuit faking an atom, a real atom grabbed by its charge, a thousand neutral atoms pinched in light, and a photon that refuses to sit still. Four industrial-scale highways, four well-funded bets. But the field guide to building a qubit does not stop at four pages. Off the main routes runs a scrappier, more fragmented crowd of platforms, and they do not pretend to be all-rounders. Each one stubbornly attacks a *single* breakthrough the front-runners cannot pull off — and bets the whole platform on it. This final deep-dive brings the contenders on stage: spins in silicon you could in principle stamp out on a chip line, color centers in diamond born to network, a topological qubit that would protect itself at the level of physics, and a long tail of honorable mentions. One of them might be the future. One of them might not even exist.

## Why there are still more routes

It is worth asking, before the tour, why anyone bothers. The big four already span fast-versus-precise, few-versus-many, compute-versus-network. What is left to want?

The honest answer is that every one of the big four pays a tax the others cannot waive. Superconducting and photonic machines cannot be *mass-produced* the way classical chips are — superconducting qubits are hand-tuned snowflakes, and a useful photonic computer needs millions of near-perfect components. Most platforms *cannot network* without coaxing a photon out of matter, and superconducting qubits cannot do even that without a lossy microwave-to-optical transducer. And every platform, without exception, is fighting the same brutal arithmetic of **quantum error correction**: thousands of noisy physical qubits spent to buy one good logical one.

The contenders in this post are, each, a wager against exactly one of those taxes. Semiconductor spin qubits bet that the answer to "you can't mass-produce them" is *use the existing semiconductor industry*. Color centers in diamond bet that the answer to "you can't network" is *a qubit that emits a photon and runs at room temperature*. Topological qubits make the most radical bet of all — that the answer to "error correction is ruinously expensive" is to build the protection into the hardware so there is far less to correct. The pattern that emerges is the cleanest in the whole series: **the squad that is good at scaling and the squad that is good at networking are almost never the same squad.** Let us meet them.

## Semiconductor spin qubits

The first contender hides its qubit inside the most studied material on Earth. The qubit is the **spin of a single electron** confined in a *gate-defined quantum dot* — a tiny puddle of one electron, pinched out of a two-dimensional electron gas by voltages on metal gates patterned over a silicon/silicon-germanium heterostructure. Spin-up is $\vert 0\rangle$, spin-down is $\vert 1\rangle$. (A close cousin, the route Bruce Kane proposed in 1998, instead stores the qubit in the *nuclear* spin of a single phosphorus donor atom implanted in silicon <d-cite key="kane1998silicon"></d-cite>.) The discreteness a transmon had to manufacture comes free here, exactly as it did for atoms: an electron's spin is a genuine two-level system, set by nature.

The blueprint is older than most of the hardware. In 1998 Daniel Loss and David DiVincenzo wrote down how to compute with these spins <d-cite key="loss1998quantumdots"></d-cite>. Single-qubit gates rotate the spin with an oscillating magnetic field (or, more practically, an electric drive plus a micromagnet gradient). The two-qubit gate is the elegant part: lower the tunnel barrier between two neighboring dots so their electron wavefunctions overlap, and the Pauli exclusion principle conjures a **Heisenberg exchange interaction** between the spins,

$$
H_{\text{ex}} = J(t)\,\mathbf{S}_1 \cdot \mathbf{S}_2 ,
$$

whose strength $J(t)$ you switch on and off with a gate voltage. Pulse $J$ for the right duration and you get a $\sqrt{\text{SWAP}}$ — a genuine entangling gate — in tens of nanoseconds. The whole logical apparatus, in other words, is *voltages on gates*, which is precisely what a semiconductor foundry already knows how to make.

<figure class="l-body" style="text-align:center; margin:1.5rem auto; max-width:720px;">
  <svg viewBox="0 0 720 380" role="img" aria-label="A gate-defined silicon quantum-dot spin qubit. A layered Si/SiGe heterostructure is drawn in cross-section, with a buried isotopically purified silicon-28 quantum well. Metal gate electrodes sit on top; their voltages pinch out a small potential well holding a single electron, shown as a teal dot with an up spin arrow labelled as the zero state and a down arrow as the one state. A second, neighbouring dot is shown with a tunable exchange coupling J between the two, the two-qubit gate." style="width:100%; height:auto; font-family:sans-serif;">
    <defs>
      <marker id="sq1a" markerWidth="8" markerHeight="8" refX="4" refY="4" orient="auto"><path d="M0 0 L8 4 L0 8 Z" fill="currentColor"/></marker>
    </defs>
    <!-- heterostructure layers -->
    <rect x="80" y="250" width="560" height="34" fill="currentColor" fill-opacity="0.05" stroke="currentColor" stroke-width="1.1"/>
    <rect x="80" y="216" width="560" height="34" fill="#14b8a6" fill-opacity="0.10" stroke="#14b8a6" stroke-width="1.4"/>
    <rect x="80" y="182" width="560" height="34" fill="currentColor" fill-opacity="0.05" stroke="currentColor" stroke-width="1.1"/>
    <text x="650" y="203" fill="currentColor" font-size="11" text-anchor="start">SiGe barrier</text>
    <text x="650" y="237" fill="#14b8a6" font-size="11" text-anchor="start">&#178;&#8312;Si well</text>
    <text x="650" y="271" fill="currentColor" font-size="11" text-anchor="start">SiGe barrier</text>
    <text x="80" y="305" fill="#14b8a6" font-size="11.5" text-anchor="start">isotopically purified &#178;&#8312;Si: nuclear-spin-free host</text>
    <!-- gate electrodes on top -->
    <rect x="150" y="150" width="36" height="22" rx="2" fill="none" stroke="currentColor" stroke-width="1.6"/>
    <rect x="206" y="150" width="36" height="22" rx="2" fill="#e0a106" fill-opacity="0.18" stroke="#e0a106" stroke-width="1.8"/>
    <rect x="262" y="150" width="36" height="22" rx="2" fill="none" stroke="currentColor" stroke-width="1.6"/>
    <rect x="430" y="150" width="36" height="22" rx="2" fill="none" stroke="currentColor" stroke-width="1.6"/>
    <rect x="486" y="150" width="36" height="22" rx="2" fill="#e0a106" fill-opacity="0.18" stroke="#e0a106" stroke-width="1.8"/>
    <rect x="542" y="150" width="36" height="22" rx="2" fill="none" stroke="currentColor" stroke-width="1.6"/>
    <text x="360" y="140" fill="currentColor" font-size="12.5" text-anchor="middle">gate voltages "pinch out" single-electron dots</text>
    <!-- dot 1 electron -->
    <circle cx="224" cy="233" r="11" fill="#14b8a6" fill-opacity="0.30" stroke="#14b8a6" stroke-width="2.2"/>
    <line x1="224" y1="241" x2="224" y2="225" stroke="#14b8a6" stroke-width="2.2" marker-end="url(#sq1a)"/>
    <text x="224" y="338" fill="#14b8a6" font-size="12.5" text-anchor="middle">|&#8593;&#x27E9; = |0&#x27E9;</text>
    <!-- dot 2 electron, spin down -->
    <circle cx="504" cy="233" r="11" fill="#14b8a6" fill-opacity="0.30" stroke="#14b8a6" stroke-width="2.2"/>
    <line x1="504" y1="225" x2="504" y2="241" stroke="#14b8a6" stroke-width="2.2" marker-end="url(#sq1a)"/>
    <text x="504" y="338" fill="#14b8a6" font-size="12.5" text-anchor="middle">|&#8595;&#x27E9; = |1&#x27E9;</text>
    <!-- exchange coupling J -->
    <line x1="240" y1="233" x2="488" y2="233" stroke="#4f7cff" stroke-width="1.6" stroke-dasharray="5 4" marker-start="url(#sq1a)" marker-end="url(#sq1a)"/>
    <text x="364" y="227" fill="#4f7cff" font-size="13" text-anchor="middle">tunable exchange J  &#8594; &#8730;SWAP</text>
  </svg>
  <figcaption style="margin-top:.5rem;"><b>Figure 1.</b> A silicon spin qubit. Voltages on metal gates pinch a single electron out of a buried, isotopically purified $^{28}$Si quantum well; the electron's spin is the qubit, $\vert{\uparrow}\rangle=\vert 0\rangle$ and $\vert{\downarrow}\rangle=\vert 1\rangle$. Lowering the barrier between two dots turns on a tunable Heisenberg exchange $J$ (blue) — the Loss–DiVincenzo two-qubit gate. The whole device is, in spirit, a few transistors, which is why it can be made on a standard CMOS line.</figcaption>
</figure>

Why *silicon* in particular, and why the strange superscript? Because the enemy of a spin qubit is a bath of *other* spins. Natural silicon contains about 4.7% of the isotope $^{29}\mathrm{Si}$, whose nuclear spin-$\tfrac12$ flickers a random magnetic field at the qubit and dephases it. Strip those out — enrich the crystal to nearly pure spin-zero $^{28}\mathrm{Si}$ — and you give the electron a "semiconductor vacuum" to live in, pushing coherence into the millisecond range and letting fidelities climb. Every high-fidelity result below was achieved in purified $^{28}\mathrm{Si}$; the isotopic purification is not a detail, it is the enabling trick.

And the headline bet is written into the qubit's birthplace: **this thing can, in principle, be built on the same 300 mm CMOS wafer lines that print the chip in your phone.** Intel made the point concrete in 2023 with "Tunnel Falls," a 12-qubit silicon spin chip fabricated in its commercial 300 mm fab using extreme-ultraviolet lithography — each qubit roughly 50 nm across, a million times smaller than a transmon <d-cite key="intel2023tunnelfalls"></d-cite>. That is the long-coveted mass-production dream: scaling by photolithography rather than by building a bigger laser-and-vacuum cathedral.

The performance has finally caught up to the dream. For years two-qubit gates were stuck below 99%, too slow and too noisy. Then in early 2022 three groups crossed the surface-code threshold within months of each other: a RIKEN-led team reached a 99.5% two-qubit and 99.8% single-qubit fidelity using fast electrical control <d-cite key="noiri2022fast"></d-cite>; a Delft group cleared the threshold on a two-qubit processor <d-cite key="xue2022surfacecode"></d-cite>; and a Princeton-led group reported a two-qubit fidelity exceeding 99.8% <d-cite key="mills2022twoqubit"></d-cite>. The march continued: in December 2025 Silicon Quantum Computing reported an 11-qubit processor built from individually placed phosphorus *donor* atoms in $^{28}$Si, with one- and multi-qubit gate fidelities ranging up to **99.99%** — matching the best trapped-ion numbers — and ran Grover's search at 98.9% accuracy with no error correction <d-cite key="sqc2025elevenqubit"></d-cite>. There is even a counterintuitive perk: because the qubit is so small and robust, it can run "hot." Where a transmon demands 10 mK, silicon spin qubits have executed a universal gate set *above 1 kelvin* <d-cite key="petit2020hot"></d-cite>, and a 2024 demonstration combined high fidelity with operation above 1 K <d-cite key="huang2024hot"></d-cite>; hole-spin qubits have run above 4 K <d-cite key="camenzind2022hole"></d-cite>. A degree above liquid helium is luxurious compared with a dilution fridge, and it leaves room on the cold plate for control electronics.

So what is the catch? Two of them. First, **it is still tiny.** The biggest working devices hold a dozen-ish qubits — Intel's 12, SQC's 11 — and charge noise plus uneven yield still means each dot is calibrated more or less by hand, the same snowflake problem superconducting qubits have. The gorgeous foundry roadmap and the current home address (about twelve qubits) are separated by a great deal of unsolved engineering. Second, **it does not shine.** A confined electron spin is not optically active; it emits no usable photon, so linking two silicon chips over fiber needs the same lossy microwave-to-optical transduction that haunts the superconducting platform. Silicon spin is the overachieving cousin who could in principle be mass-produced — but who is, for now, terrible at long-distance calls.

## Topological qubits

The next contender is the most beautiful idea in the room and the most contested claim in this entire series. **Read this section as the careful skeptic it is written for.**

The idea first. Every qubit so far stores information *somewhere* — in a circuit, an atom, a photon — and "somewhere" is exactly where noise can find it. A topological qubit would store information *nowhere in particular*. The vehicle is a **Majorana zero mode** (MZM): a peculiar excitation, predicted to live at the ends of a one-dimensional *topological superconductor*, that is its own antiparticle — half of an electron, in a sense. Alexei Kitaev showed in 2001 that a simple model wire can host exactly two such modes, one at each end <d-cite key="kitaev2001unpaired"></d-cite>. The trick is what happens when you pair them. Two Majoranas $\gamma_1$ and $\gamma_2$ combine into one ordinary fermionic mode,

$$
c = \tfrac12(\gamma_1 + i\gamma_2),
$$

which is either empty or filled — and *that* occupation, the shared fermion parity, is the qubit. The information is not at the left end or the right end; it is in the *correlation* between two modes that can sit microns apart. A local perturbation — a stray charge, a phonon, a wandering field — touches only one Majorana at a time, and a single Majorana carries no information at all. To corrupt the qubit you would have to act on *both ends at once*, which local noise cannot coordinate. The energy splitting between the two parity states is exponentially suppressed with the wire length, $\sim e^{-L/\xi}$, so the qubit is protected by *geometry*. That is **topological protection**: error resistance built into the hardware, before any error-correcting code is layered on top. If it worked, the punishing overhead of quantum error correction could shrink dramatically. This is the single most attractive promise in qubit engineering.

<figure class="l-body" style="text-align:center; margin:1.5rem auto; max-width:720px;">
  <svg viewBox="0 0 720 320" role="img" aria-label="A topological-superconductor nanowire. A semiconductor nanowire lies under a superconducting shell. Two Majorana zero modes, drawn as teal and amber half-discs, sit at the two ends of the wire. A label notes that one fermion mode is split into two spatially separated halves and that the qubit is the shared parity, delocalized across the whole wire. A red noise squiggle touches only the left end, and a note explains that local noise on one end cannot flip the parity; the splitting is exponentially small in the wire length." style="width:100%; height:auto; font-family:sans-serif;">
    <defs>
      <marker id="tp1a" markerWidth="8" markerHeight="8" refX="4" refY="4" orient="auto"><path d="M0 0 L8 4 L0 8 Z" fill="currentColor"/></marker>
    </defs>
    <!-- superconductor shell -->
    <rect x="150" y="120" width="420" height="26" rx="4" fill="#4f7cff" fill-opacity="0.12" stroke="#4f7cff" stroke-width="1.6"/>
    <text x="360" y="112" fill="#4f7cff" font-size="12" text-anchor="middle">superconductor</text>
    <!-- semiconductor nanowire -->
    <rect x="150" y="146" width="420" height="30" rx="6" fill="currentColor" fill-opacity="0.06" stroke="currentColor" stroke-width="1.6"/>
    <text x="360" y="166" fill="currentColor" font-size="12.5" text-anchor="middle">semiconductor nanowire (length L)</text>
    <!-- Majorana modes at ends -->
    <circle cx="150" cy="161" r="14" fill="#14b8a6" fill-opacity="0.35" stroke="#14b8a6" stroke-width="2.4"/>
    <text x="150" y="205" fill="#14b8a6" font-size="13" text-anchor="middle">&#947;&#8321;</text>
    <circle cx="570" cy="161" r="14" fill="#e0a106" fill-opacity="0.35" stroke="#e0a106" stroke-width="2.4"/>
    <text x="570" y="205" fill="#e0a106" font-size="13" text-anchor="middle">&#947;&#8322;</text>
    <text x="360" y="232" fill="currentColor" font-size="13" text-anchor="middle">one fermion split into two ends &#8594; qubit = shared parity (delocalized)</text>
    <!-- local noise on left end, crossed -->
    <path d="M120 100 q 8 -10 16 0 q 8 10 16 0" fill="none" stroke="#ef4444" stroke-width="2"/>
    <line x1="150" y1="105" x2="150" y2="140" stroke="#ef4444" stroke-width="1.6" stroke-dasharray="4 3" marker-end="url(#tp1a)"/>
    <line x1="138" y1="118" x2="162" y2="134" stroke="#ef4444" stroke-width="2.4"/>
    <text x="150" y="92" fill="#ef4444" font-size="11.5" text-anchor="middle">local noise</text>
    <!-- protection note -->
    <text x="360" y="266" fill="currentColor" font-size="12.5" text-anchor="middle">splitting &#8764; e^(&#8722;L/&#958;): touching one end can't flip it &#8212; in theory</text>
    <text x="360" y="294" fill="#ef4444" font-size="11.5" text-anchor="middle" font-style="italic">idealized picture; whether real devices host MZMs is disputed</text>
  </svg>
  <figcaption style="margin-top:.5rem;"><b>Figure 2.</b> The idealized topological qubit. A semiconductor–superconductor nanowire is predicted to host a Majorana zero mode at each end ($\gamma_1$, $\gamma_2$). One fermion mode is split into two spatially separated halves, and the qubit is their shared parity — stored non-locally, so a local perturbation on one end cannot read or flip it, and the parity splitting falls off as $e^{-L/\xi}$. <em>This is the theoretical promise. Whether any fabricated device actually realizes it is the contested question of the next paragraphs.</em></figcaption>
</figure>

Now the reality, stated plainly: **no topological qubit has been convincingly demonstrated, and the leading claims are actively disputed.** The history is a cautionary tale, and it must be told in full.

In 2018, a Delft–Microsoft team published a *Nature* paper claiming a quantized $2e^2/h$ conductance plateau as a smoking-gun signature of a Majorana zero mode <d-cite key="zhang2018quantized"></d-cite>. It was celebrated — and then it unravelled. After outside scientists flagged inconsistencies between the raw data and the figures, the authors re-examined the measurements, and in March 2021 the paper was **retracted** <d-cite key="zhang2021retraction"></d-cite>. A subsequent investigation found that data had been selectively cut and that datasets contradicting the central claim had been omitted; the lead and corresponding authors were judged to have been negligent. The episode is the field's open wound and the reason every later claim is met with such scrutiny.

Microsoft has continued, and made two further claims that remain contested. In 2023 its team reported devices "passing the topological gap protocol," a multi-step transport test meant to certify a topological phase <d-cite key="aghaee2023topogap"></d-cite>. In February 2025 it published, in *Nature*, an interferometric single-shot measurement of fermion parity in an InAs–Al nanowire device <d-cite key="microsoft2025parity"></d-cite> — the result behind the heavily publicized "Majorana 1" chip, announced with a claim of eight topological qubits and a roadmap to a million. Here the asterisks matter more than the headline. The 2025 paper *itself* states that its measurements "do not, by themselves, determine whether the low-energy states detected by interferometry are topological," and *Nature* appended an editor's note; the journal's editorial team concluded that the results "do not represent evidence for the presence of Majorana zero modes" in the devices <d-cite key="aps2025majoranaquestions"></d-cite>. In June 2026, physicist Henry Legg published a formal critique in *Nature*'s Matters Arising arguing that the relevant device regions are in fact highly disordered and gapless, that the signals could arise from trivial effects such as ordinary quantum dots, and that the analysis contained software errors and omitted transport data; Microsoft replied defending its method <d-cite key="legg2025comment"></d-cite>. The community remains, by and large, unconvinced — one prominent skeptic flatly called any 2025 topological-qubit claim "a fairy tale" <d-cite key="aps2025majoranaquestions"></d-cite>.

So weigh it honestly. The promise is the most beautiful in quantum computing: a qubit that corrects itself in hardware. The evidence, to date, is not there — there is no accepted topological qubit with a measured gate fidelity or coherence time, a retracted flagship paper, and live, published disputes over the most recent claims. It is the field's highest-risk, highest-reward bet, and the only intellectually honest verdict in 2026 is *not proven — a card still face-down.*

## Color centers in diamond

The third contender is the photonic platform's opposite number among the solids: bad at mass production, a natural at networking. Its qubit is the **electron spin of a nitrogen-vacancy (NV) center** — a point defect where a nitrogen atom sits next to a missing carbon in the diamond lattice. The defect's ground state is a *spin triplet*; pick two of its sublevels, say $m_s=0$ as $\vert 0\rangle$ and $m_s=-1$ as $\vert 1\rangle$, and you have a spin qubit you can drive with microwaves. The magic is the readout. Shine green laser light on an NV and it fluoresces — but the $m_s=0$ state glows noticeably *brighter* than $m_s=\pm1$, so counting photons tells you the spin state. That spin-dependent fluorescence lets you initialize, manipulate, and read out the qubit **optically, at room temperature** — and isotopically purified diamond gives these spins a dephasing time around $T_2 \approx 1.8$ ms at room temperature, the longest of any solid-state spin <d-cite key="balasubramanian2009ultralong"></d-cite>. A nearby nuclear spin — the nitrogen's own, or a $^{13}$C neighbor — serves as a long-lived **memory**, holding a quantum state for up to about a minute in a ten-qubit register <d-cite key="bradley2019tenqubit"></d-cite>. (The same spin-dependent optical response makes the NV a world-class *quantum sensor*: diamond magnetometry and thermometry are built on exactly this physics.)

But the reason the NV center earns its place in *this* researcher's series is **networking**, and here it is a genuine star. An NV electron spin can emit a photon **entangled with its own state** — a spin–photon entanglement. Send that photon down a fiber, interfere it with a photon from a distant NV, and a successful detection *swaps* the entanglement onto the two faraway spins: you have entangled two nodes that never touched. This is not hand-waving. In 2015 a Delft team led by Ronald Hanson used entangled NV spins 1.3 km apart to perform the first **loophole-free Bell test**, closing the locality and detection loopholes simultaneously and settling an 80-year-old argument about quantum nonlocality <d-cite key="hensen2015loopholefree"></d-cite>. The same group then built a **three-node quantum network** of NV centers, demonstrating entanglement distribution and swapping across all three <d-cite key="pompili2021multinode"></d-cite>, and went on to **teleport** a qubit between two non-neighboring nodes — relaying quantum information through an intermediate node, the basic move of a future quantum internet <d-cite key="hermans2022teleportation"></d-cite>. A cousin defect, the **silicon-vacancy (SiV)** center, has cleaner optics and better cavity coupling; in 2024 a Harvard team entangled two SiV nodes through 35 km of deployed telecom fiber looped under the streets of Boston, with nuclear-spin memories storing the entanglement and error detection built in <d-cite key="knaut2024telecom"></d-cite>. For a quantum-network researcher, this is the most directly relevant platform in the field.

The costs are the mirror image of the strengths. **Scaling is brutal:** defects nucleate at essentially random positions in the diamond, so assembling many into a large, precisely aligned array is a fabrication nightmare — there is no lithographic "place an NV here" the way there is for a transistor. **Photon collection is poor:** only a few percent of an NV's emission lands in the coherent zero-phonon line, and it comes out at 637 nm, well off the telecom band, so long hauls need wavelength conversion (the SiV-in-a-cavity approach is partly a fix for this). And network-grade coherence and optics generally want cooling to a few kelvin. None of this makes diamond a front-runner for *large-scale computing* — but as a *network node and sensor*, it pushes the solid state to its ceiling. Diamonds, it turns out, are a qubit's best friend: a flaw you talk to with green light, that moonlights as a magnetometer, and that can fire its state down a fiber to a node across the city.

## The long tail

Beyond the three main contenders runs a tail of platforms too early, too specialized, or too historic to headline — but worth knowing, if only to read the field's news correctly.

**Trapped electrons and electrons on solids.** Why trap a whole atom when the qubit lives on one electron? A small community traps *bare* electrons — historically floating on liquid helium, and more recently on a film of frozen neon. In 2022 a Chicago-led group integrated a single electron on solid neon into a superconducting-circuit (cQED) architecture and ran it as a charge qubit with surprisingly long coherence <d-cite key="zhou2022electronneon"></d-cite>. It is a genuinely new platform, years behind the leaders, but conceptually clean.

**Molecular qubits.** Individual ultracold polar molecules, held in optical tweezers like neutral atoms but with a far richer internal structure (rotational, vibrational, and spin states), have been proposed as qubits for years. In 2023 a Princeton group achieved **on-demand entanglement of two individually controlled molecules** in a tweezer array, using their dipole–dipole interaction to make a Bell pair <d-cite key="holland2023molecules"></d-cite> — a foundational proof of principle, not yet a processor.

**Nuclear-spin ensembles (NMR).** The oldest qubit platform of all is also the most cautionary. Liquid-state nuclear magnetic resonance — radio pulses driving the nuclear spins of atoms in a molecule — ran the *first* quantum algorithms: Grover search in the late 1990s and, famously, the first physical run of Shor's algorithm, factoring 15 with a seven-spin molecule in 2001 <d-cite key="vandersypen2001shor"></d-cite>. But NMR fundamentally **does not scale**: the signal from a thermal ensemble shrinks exponentially with qubit number, and the "qubits" are an average over $\sim10^{18}$ molecules rather than individually controlled. It is of textbook-historic value now — a reminder that running an algorithm once is not the same as building a computer.

One honest caution to close the tail, because it trips up almost every popular ranking: **do not confuse qubit *counts* across architectures.** D-Wave's Advantage2 carries more than 4,400 superconducting flux qubits — far more than any gate-model machine <d-cite key="dwave2025advantage2"></d-cite>. But it is a **quantum annealer**: it relaxes toward the solution of an optimization problem, and it is *not* a universal gate-model computer. Its 4,400 qubits and the ~100 qubits of a gate-model chip are simply different things, and cannot be compared head-to-head. It is a four-thousand-key piano that plays one kind of chord — more keys does not mean it can play the whole songbook.

## Where they sit

Line the contenders up and the survey's thesis snaps into focus: **each bets on a different breakthrough, patching exactly where the front-runners fall short.** Silicon spin bets on *mass production* — qubits off a CMOS line — and is delivering real fidelity but only a dozen qubits, with no native way to network. Color centers bet on *networking and sensing* — a room-temperature qubit that emits an entangled photon — and own the solid-state networking records, but cannot be scaled into a large processor. Topological bets on *hardware-level error correction* — the most disruptive promise in the field — and remains, after a retraction and live disputes, unproven. Their shared soft spot is consistent too: all are small-scale today (roughly a dozen working qubits each) with younger, more fragmented communities than the big four.

| | Silicon spin | Topological (Majorana) | Color center (NV/SiV) |
|---|---|---|---|
| **Qubit** | spin of one electron in a quantum dot | non-local parity of two Majorana modes | electron spin of a diamond defect |
| **Headline bet** | mass-produce on CMOS lines | hardware-level error protection | room-temperature network node |
| **Best fidelity** | up to 99.99% (donor, 2025) | none demonstrated (disputed) | high, but few qubits |
| **Coherence** | ms (electron), s (nuclear) | unmeasured | ms at room temp; ~minute memory |
| **Operating temp** | ~0.1 K, even &gt;1 K ("hot") | ~10 mK (and unproven) | room temp; few K for networking |
| **As a network node** | needs transduction | n/a (not built) | natural and proven |
| **Status** | real, ~12 qubits | not proven | real, networking-focused |

No row is won by the same column, which is the whole point — and it rhymes with the four big platforms, where likewise no one wins every row. That is the through-line this series has chased from the first post: there is no universally best qubit, only different trades. The fastest, the most precise, the most scalable, the one born to network, the one you could mass-produce, the one that might rewrite error correction — each has its gift and its tax.

And so the account closes, six builds deep. Superconducting is fast; trapped ions are precise; neutral atoms scale; photons fly; and the solid-state contenders each chase a single breakthrough — none of them wins every row. Notice, finally, the lesson that matters most for a quantum *network*: the squad that is best at scaling (silicon spin) and the squad that is best at networking (color centers) are two different squads, and no single solid-state route yet has it all. The likeliest future is not one qubit taking the crown, but a *quantum network* stitching different qubits together — a superconducting or atomic processor here, a diamond node there, photons carrying entanglement between them — each platform doing the one job it is best at. Which is, when you think about it, exactly the bet a quantum-network researcher is paid to make. All six builds, seen. Now the interesting question is not which one wins, but how you wire them together.
