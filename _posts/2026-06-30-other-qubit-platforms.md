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

The contenders in this post are, each, a wager against exactly one of those taxes. Semiconductor spin qubits bet that the answer to "you can't mass-produce them" is *use the existing semiconductor industry*. Color centers in diamond bet that the answer to "you can't network" is *a qubit that emits a photon and runs at room temperature*. Topological qubits make the most radical bet of all — that the answer to "error correction is ruinously expensive" is to build the protection into the hardware so there is far less to correct. The pattern that emerges is the cleanest in the whole series: **the team that scales best and the team that networks best are almost never the same team.** Let us meet them.

## Semiconductor spin qubits

The first contender hides its qubit inside the most studied material on Earth. The qubit is the **spin of a single electron** confined in a *gate-defined quantum dot* — a tiny puddle of one electron, pinched out of a two-dimensional electron gas by voltages on metal gates patterned over a silicon/silicon-germanium heterostructure. Spin-up is $\vert 0\rangle$, spin-down is $\vert 1\rangle$. (A close cousin, the route Bruce Kane proposed in 1998, instead stores the qubit in the *nuclear* spin of a single phosphorus donor atom implanted in silicon <d-cite key="kane1998silicon"></d-cite>.) The discreteness a transmon (the superconducting qubit of the first post) had to manufacture comes free here, exactly as it did for atoms: an electron's spin is a genuine two-level system, set by nature.

The blueprint is older than most of the hardware. In 1998 Daniel Loss and David DiVincenzo wrote down how to compute with these spins <d-cite key="loss1998quantumdots"></d-cite>. Single-qubit gates rotate the spin with an oscillating magnetic field — or, more practically, with an electric drive and a micromagnet gradient, a trick called *electric-dipole spin resonance* (EDSR) that lets you flip a spin with a voltage instead of a coil. The two-qubit gate is the elegant part: lower the tunnel barrier between two neighboring dots so their electron wavefunctions overlap, and the Pauli exclusion principle conjures a **Heisenberg exchange interaction** between the spins,

$$
H_{\text{ex}} = J(t)\,\mathbf{S}_1 \cdot \mathbf{S}_2 ,
$$

whose strength $J(t)$ you switch on and off with a gate voltage. Pulse $J$ for the right duration and you get a $\sqrt{\text{SWAP}}$ — a genuine entangling gate — in tens of nanoseconds. The whole logical apparatus, in other words, is *voltages on gates*, which is precisely what a semiconductor foundry already knows how to make.

Reading the answer out is the subtle part, because a lone electron spin is far too faint to detect directly. The trick is to convert spin into *charge*: Pauli spin blockade (or energy-selective tunneling) makes the electron's ability to hop to a neighbor depend on its spin, and a nearby charge sensor — a single-electron transistor or sensor dot, increasingly read by fast radio-frequency reflectometry — registers that hop in a single shot. Spin in, charge out, photon never required.

<figure class="l-body" style="text-align:center; margin:1.5rem auto; max-width:720px;">
  <svg viewBox="0 0 720 320" role="img" aria-label="A gate-defined silicon quantum-dot spin qubit. A layered Si/SiGe heterostructure is drawn in cross-section, with a buried isotopically purified silicon-28 quantum well. Two metal plunger gates and a barrier gate sit on top; the plunger voltages pinch out two adjacent single-electron dots, one with an up spin labelled the zero state and one with a down spin labelled the one state. Lowering the central barrier gate turns on a short-range Heisenberg exchange J between the two neighbouring dots, the two-qubit gate." style="width:100%; height:auto; font-family:sans-serif;">
    <defs>
      <marker id="sqSpin" markerUnits="userSpaceOnUse" markerWidth="7" markerHeight="7" refX="3.5" refY="3.5" orient="auto-start-reverse"><path d="M0 0 L7 3.5 L0 7 Z" fill="#14b8a6"/></marker>
      <marker id="sqJ" markerWidth="9" markerHeight="9" refX="4.5" refY="4.5" orient="auto-start-reverse"><path d="M0 0 L9 4.5 L0 9 Z" fill="#4f7cff"/></marker>
    </defs>
    <text x="360" y="32" fill="currentColor" font-size="12.5" text-anchor="middle">plunger voltages pinch out two single-electron dots; the barrier gate between them tunes J</text>
    <!-- gate stack: plunger, barrier, plunger -->
    <rect x="312" y="60" width="36" height="22" rx="2" fill="#e0a106" fill-opacity="0.18" stroke="#e0a106" stroke-width="1.8"/>
    <rect x="352" y="60" width="36" height="22" rx="2" fill="currentColor" fill-opacity="0.06" stroke="currentColor" stroke-width="1.6"/>
    <rect x="392" y="60" width="36" height="22" rx="2" fill="#e0a106" fill-opacity="0.18" stroke="#e0a106" stroke-width="1.8"/>
    <text x="330" y="96" fill="#e0a106" font-size="10" text-anchor="middle">plunger</text>
    <text x="370" y="96" fill="currentColor" font-size="10" text-anchor="middle">barrier</text>
    <text x="410" y="96" fill="#e0a106" font-size="10" text-anchor="middle">plunger</text>
    <!-- barrier-gate-to-J connector -->
    <line x1="370" y1="82" x2="370" y2="156" stroke="currentColor" stroke-width="1.1" stroke-dasharray="3 3" opacity="0.45"/>
    <!-- heterostructure cross-section -->
    <rect x="150" y="120" width="440" height="22" fill="currentColor" fill-opacity="0.05" stroke="currentColor" stroke-width="1.1"/>
    <rect x="150" y="142" width="440" height="42" fill="#14b8a6" fill-opacity="0.10" stroke="#14b8a6" stroke-width="1.4"/>
    <rect x="150" y="184" width="440" height="22" fill="currentColor" fill-opacity="0.05" stroke="currentColor" stroke-width="1.1"/>
    <text x="600" y="135" fill="currentColor" font-size="11" text-anchor="start">SiGe</text>
    <text x="600" y="167" fill="#14b8a6" font-size="11" text-anchor="start">&#178;&#8312;Si well</text>
    <text x="600" y="199" fill="currentColor" font-size="11" text-anchor="start">SiGe</text>
    <!-- dot 1 electron, spin up -->
    <circle cx="330" cy="163" r="14" fill="none" stroke="currentColor" stroke-width="0.9" opacity="0.4"/>
    <circle cx="330" cy="163" r="12" fill="#14b8a6" fill-opacity="0.5" stroke="#14b8a6" stroke-width="2.4"/>
    <line x1="330" y1="175" x2="330" y2="151" stroke="#14b8a6" stroke-width="1.6" marker-end="url(#sqSpin)"/>
    <!-- dot 2 electron, spin down -->
    <circle cx="410" cy="163" r="14" fill="none" stroke="currentColor" stroke-width="0.9" opacity="0.4"/>
    <circle cx="410" cy="163" r="12" fill="#14b8a6" fill-opacity="0.5" stroke="#14b8a6" stroke-width="2.4"/>
    <line x1="410" y1="151" x2="410" y2="175" stroke="#14b8a6" stroke-width="1.6" marker-end="url(#sqSpin)"/>
    <!-- short-range exchange J through the barrier -->
    <line x1="346" y1="163" x2="394" y2="163" stroke="#4f7cff" stroke-width="2" stroke-dasharray="4 3" marker-start="url(#sqJ)" marker-end="url(#sqJ)"/>
    <text x="360" y="232" fill="#4f7cff" font-size="12.5" text-anchor="middle">tunable exchange J  &#8594;  &#8730;SWAP (two-qubit gate)</text>
    <text x="330" y="258" fill="#14b8a6" font-size="12" text-anchor="middle">|&#8593;&#x27E9; = |0&#x27E9;</text>
    <text x="410" y="258" fill="#14b8a6" font-size="12" text-anchor="middle">|&#8595;&#x27E9; = |1&#x27E9;</text>
  </svg>
  <figcaption style="margin-top:.5rem;"><b>Figure 1.</b> A silicon spin qubit. Plunger-gate voltages pinch single electrons out of a buried, isotopically purified $^{28}$Si quantum well; each electron's spin is a qubit, $\vert{\uparrow}\rangle=\vert 0\rangle$ and $\vert{\downarrow}\rangle=\vert 1\rangle$. Lowering the *barrier* gate between two adjacent dots turns on a short-range, tunable Heisenberg exchange $J$ (blue) — the Loss–DiVincenzo two-qubit gate, a $\sqrt{\text{SWAP}}$ in tens of nanoseconds. The whole device is, in spirit, a few transistors, which is why it can be made on a standard CMOS line.</figcaption>
</figure>

Why *silicon* in particular, and why the strange superscript? Because the enemy of a spin qubit is a bath of *other* spins. Natural silicon contains about 4.7% of the isotope $^{29}\mathrm{Si}$, whose nuclear spin-$\tfrac12$ flickers a random magnetic field at the qubit and dephases it. Strip those out — enrich the crystal to nearly pure spin-zero $^{28}\mathrm{Si}$ — and you give the electron a "semiconductor vacuum" to live in, pushing coherence into the millisecond range and letting fidelities climb. Every high-fidelity result below was achieved in purified $^{28}\mathrm{Si}$; the isotopic purification is not a detail, it is the enabling trick.

And the headline bet is written into the qubit's birthplace: **this thing can be built on the same 300 mm CMOS wafer lines that print the chip in your phone.** Intel made the point concrete in 2023 with "Tunnel Falls," a 12-qubit silicon spin chip fabricated in its commercial 300 mm fab using extreme-ultraviolet lithography — each qubit roughly 50 nm across, thousands of times smaller than a transmon in linear size, and millions of times smaller in footprint <d-cite key="intel2023tunnelfalls"></d-cite>. That is the long-coveted mass-production dream: scaling by photolithography rather than by building a bigger laser-and-vacuum cathedral.

The performance has finally caught up to the dream. For years two-qubit gates were stuck below 99% — too slow, too noisy to error-correct. Then, in early 2022, the dam broke: three independent groups vaulted the ~99% surface-code threshold within months of one another <d-cite key="noiri2022fast"></d-cite><d-cite key="xue2022surfacecode"></d-cite><d-cite key="mills2022twoqubit"></d-cite>, and the march only accelerated. The current high-water mark came in December 2025, when Silicon Quantum Computing reported an 11-qubit processor built from phosphorus *donor* atoms placed one at a time in $^{28}$Si, with single-qubit gate fidelities reaching **99.99%** — among the highest reported on any solid-state chip <d-cite key="sqc2025elevenqubit"></d-cite>. An earlier four-qubit donor processor from the same group had already run Grover's search with every gate above the fault-tolerant threshold, finding the marked state at 98.9% of the ideal success probability with no error correction at all <d-cite key="thorvaldson2025grover"></d-cite>.

There is even a counterintuitive perk: because a spin qubit is so small and so robust, it can run *hot*. Where a transmon demands roughly 10 mK, silicon spin qubits have executed a universal gate set *above 1 kelvin* <d-cite key="petit2020hot"></d-cite><d-cite key="huang2024hot"></d-cite>, and hole-spin variants have operated above 4 K <d-cite key="camenzind2022hole"></d-cite>. A jump from a few millikelvin to a kelvin or more sounds trivial, but it is transformative: it unlocks far more cooling power than a dilution fridge offers at base temperature, leaving room on the cold plate for the classical control electronics every large processor will need.

So what is the catch? Two of them. First, **it is still tiny.** The biggest working devices hold a dozen-ish qubits — Intel's 12, SQC's 11 — and charge noise plus uneven yield still means each dot is calibrated more or less by hand, the same snowflake problem superconducting qubits have. And the charge noise is not an incidental nuisance; it is the bill for the platform's own strengths. The very electrical and spin–orbit coupling that lets you drive gates fast with EDSR and run the qubit hot is also the channel through which a stray electric field reaches in and dephases the spin — fast control and good isolation are pulling on the same rope. Second, **it does not shine.** A confined electron spin is not optically active; it emits no usable photon, so linking two silicon chips over fiber needs the same lossy microwave-to-optical transduction that haunts the superconducting platform. Silicon spin is the overachieving cousin who could in principle be mass-produced — but who is, for now, terrible at long-distance calls.

## Topological qubits

The next contender is the most beautiful idea in the room — and the most contested claim in this entire series. **Read it with your skeptic's hat on; that is the only sober way through.**

The idea first. Every qubit so far stores information *somewhere* — in a circuit, an atom, a photon — and "somewhere" is exactly where noise can find it. A topological qubit would store information *nowhere in particular*. The vehicle is a **Majorana zero mode** (MZM): a peculiar excitation, predicted to live at the ends of a one-dimensional *topological superconductor*, that is its own antiparticle — half of an electron, in a sense. Alexei Kitaev showed in 2001 that a simple model wire can host exactly two such modes, one at each end <d-cite key="kitaev2001unpaired"></d-cite>. The trick is what happens when you pair them. Two Majoranas $\gamma_1$ and $\gamma_2$ combine into one ordinary fermionic mode,

$$
c = \tfrac12(\gamma_1 + i\gamma_2),
$$

which is either empty or filled — and *that* occupation, the shared fermion parity, is the qubit. (Strictly, a usable logical qubit needs *four* Majoranas — two pairs sharing a fixed total parity, because total fermion parity is conserved — but this two-mode picture captures the non-locality and is the right intuition for the idea.) The information is not at the left end or the right end; it is in the *correlation* between two modes that can sit microns apart. A local perturbation — a stray charge, a phonon, a wandering field — touches only one Majorana at a time, and a single Majorana carries no information at all. To corrupt the qubit you would have to act on *both ends at once*, which local noise cannot coordinate. The energy splitting between the two parity states is exponentially suppressed with the wire length, $\sim e^{-L/\xi}$, so the qubit is protected by *geometry*. That is **topological protection**: error resistance built into the hardware, before any error-correcting code is layered on top. If it worked, the hardware itself would be suppressing errors for free.

And the *computation* is meant to be just as robust as the memory. You operate on the qubit not by pulsing fields but by **braiding** — physically moving the Majoranas around one another. These excitations are *non-Abelian anyons*, which means that swapping two of them transforms the parity state in a way that depends only on *which* worldlines crossed, not on how fast or how precisely you moved them; the gate, like the memory, is protected by topology. The real limit is that braiding alone is not enough: it generates only the *Clifford* gates, the subset a classical computer can efficiently simulate. To reach universal quantum computation you still need one non-topological ingredient — a "magic state" distilled at real overhead to supply the missing T-gate. Topology, in other words, would shrink the error-correction bill dramatically, but not abolish it.

<figure class="l-body" style="text-align:center; margin:1.5rem auto; max-width:720px;">
  <svg viewBox="0 0 720 320" role="img" aria-label="A topological-superconductor nanowire. A semiconductor nanowire lies under a superconducting shell. Two Majorana zero modes, drawn as two identical teal discs, sit at the two ends of the wire and are tied together as two halves of one shared fermion mode. The qubit is their shared parity, delocalized across the whole wire. A red noise squiggle reaches the left end but is blocked by a cross, and a note explains that local noise on one end cannot flip the parity; the splitting is exponentially small in the wire length." style="width:100%; height:auto; font-family:sans-serif;">
    <defs>
      <marker id="tpNoise" markerWidth="8" markerHeight="8" refX="4" refY="4" orient="auto-start-reverse"><path d="M0 0 L8 4 L0 8 Z" fill="#ef4444"/></marker>
    </defs>
    <!-- superconductor shell -->
    <rect x="150" y="120" width="420" height="26" rx="4" fill="#4f7cff" fill-opacity="0.12" stroke="#4f7cff" stroke-width="1.6"/>
    <text x="360" y="112" fill="#4f7cff" font-size="12" text-anchor="middle">superconductor</text>
    <!-- semiconductor nanowire -->
    <rect x="150" y="146" width="420" height="30" rx="6" fill="currentColor" fill-opacity="0.06" stroke="currentColor" stroke-width="1.6"/>
    <text x="360" y="166" fill="currentColor" font-size="12.5" text-anchor="middle">semiconductor nanowire (length L)</text>
    <!-- parity tie: two halves of one fermion -->
    <path d="M150 178 Q 360 200 570 178" fill="none" stroke="#14b8a6" stroke-width="1.4" stroke-dasharray="5 4" opacity="0.75"/>
    <text x="360" y="214" fill="#14b8a6" font-size="12" text-anchor="middle">one shared fermion mode  c = &#189;(&#947;&#8321; + i&#947;&#8322;)</text>
    <!-- both Majoranas identical teal -->
    <circle cx="150" cy="161" r="14" fill="#14b8a6" fill-opacity="0.35" stroke="#14b8a6" stroke-width="2.4"/>
    <text x="150" y="200" fill="#14b8a6" font-size="13" text-anchor="middle">&#947;&#8321;</text>
    <circle cx="570" cy="161" r="14" fill="#14b8a6" fill-opacity="0.35" stroke="#14b8a6" stroke-width="2.4"/>
    <text x="570" y="200" fill="#14b8a6" font-size="13" text-anchor="middle">&#947;&#8322;</text>
    <text x="360" y="236" fill="currentColor" font-size="12.5" text-anchor="middle">the qubit is their shared parity &#8212; stored non-locally, not at either end</text>
    <!-- local noise, blocked -->
    <text x="150" y="84" fill="#ef4444" font-size="11.5" text-anchor="middle">local noise</text>
    <path d="M126 92 q 8 -9 16 0 q 8 9 16 0" fill="none" stroke="#ef4444" stroke-width="2"/>
    <line x1="150" y1="100" x2="150" y2="128" stroke="#ef4444" stroke-width="1.6" stroke-dasharray="4 3" marker-end="url(#tpNoise)"/>
    <line x1="143" y1="131" x2="157" y2="145" stroke="#ef4444" stroke-width="2.4"/>
    <line x1="157" y1="131" x2="143" y2="145" stroke="#ef4444" stroke-width="2.4"/>
    <!-- protection note -->
    <text x="360" y="270" fill="currentColor" font-size="12.5" text-anchor="middle">splitting &#8764; e<tspan dy="-5" font-size="9">&#8722;L/&#958;</tspan><tspan dy="5">: touching one end can&#8217;t flip it &#8212; in theory</tspan></text>
    <text x="360" y="296" fill="#ef4444" font-size="11.5" text-anchor="middle" font-style="italic">idealized picture; whether real devices host MZMs is disputed</text>
  </svg>
  <figcaption style="margin-top:.5rem;"><b>Figure 2.</b> The idealized topological qubit — the conceptual one-pair picture; an operable qubit encodes parity in *two* such pairs. A semiconductor–superconductor nanowire is predicted to host a Majorana zero mode at each end ($\gamma_1$, $\gamma_2$). One fermion mode is split into two spatially separated halves, and the qubit is their shared parity — stored non-locally, so a local perturbation on one end cannot read or flip it, and the parity splitting falls off as $e^{-L/\xi}$. <em>This is the theoretical promise. Whether any fabricated device actually realizes it is the contested question of the next paragraphs.</em></figcaption>
</figure>

Now the reality, stated plainly: **no topological qubit has been convincingly demonstrated, and the leading claims are actively disputed.** The history is a cautionary tale, and it must be told in full.

In 2018, a Delft–Microsoft team published a *Nature* paper claiming a quantized $2e^2/h$ conductance plateau as a smoking-gun signature of a Majorana zero mode <d-cite key="zhang2018quantized"></d-cite>. It was celebrated — and then it unraveled. After outside scientists flagged inconsistencies between the raw data and the figures, the authors re-examined the measurements, and in March 2021 the paper was **retracted** <d-cite key="zhang2021retraction"></d-cite>. A subsequent investigation found that data had been selectively cut and that datasets contradicting the central claim had been omitted; the lead and corresponding authors were judged to have been negligent. The episode is the field's open wound and the reason every later claim is met with such scrutiny.

Microsoft has continued, and made two further claims that remain contested. In 2023 its team reported devices "passing the topological gap protocol," a multi-step transport test meant to certify a topological phase <d-cite key="aghaee2023topogap"></d-cite>. In February 2025 it published, in *Nature*, an interferometric single-shot measurement of fermion parity in an InAs–Al nanowire device <d-cite key="microsoft2025parity"></d-cite> — the result behind the heavily publicized "Majorana 1" chip, announced with a claim of eight topological qubits and a roadmap to a million. Here the asterisks matter more than the headline. The 2025 paper *itself* states that its measurements "do not, by themselves, determine whether the low-energy states detected by interferometry are topological," and *Nature* appended an editor's note flagging that its peer reviewers found the results "do not represent evidence for the presence of Majorana zero modes" in the devices <d-cite key="aps2025majoranaquestions"></d-cite>. Physicist Henry Legg published a detailed critique in *Nature* (2026) arguing that the relevant device regions are in fact highly disordered and gapless, that the signals could arise from trivial effects such as ordinary quantum dots, and that the analysis contained software errors and omitted transport data; Microsoft published a formal reply defending its method <d-cite key="legg2025comment"></d-cite>. The community remains, by and large, unconvinced — one prominent skeptic flatly called any 2025 topological-qubit claim "a fairy tale" <d-cite key="aps2025majoranaquestions"></d-cite>.

So weigh it. The promise is extraordinary: a qubit that corrects itself in hardware. The evidence, to date, is not there: no accepted topological qubit with a measured gate fidelity or coherence time, a retracted flagship paper, and live, published disputes over the most recent claims. It is the field's highest-risk, highest-reward bet, and the only intellectually honest verdict in 2026 is *not proven — a card still face-down.*

## Color centers in diamond

The third contender is the solid-state mirror of the photonic platform — and the near-opposite of silicon spin: bad at mass production, a natural at networking. Its qubit is the **electron spin of a nitrogen-vacancy (NV) center** — a point defect where a nitrogen atom sits next to a missing carbon in the diamond lattice. The defect's ground state is a *spin triplet*; pick two of its sublevels, say $m_s=0$ as $\vert 0\rangle$ and $m_s=-1$ as $\vert 1\rangle$, and you have a spin qubit you can drive with microwaves. The magic is the readout. Shine green laser light on an NV and it fluoresces — but the $m_s=0$ state glows noticeably *brighter* than $m_s=\pm1$, so counting photons tells you the spin state. That spin-dependent fluorescence lets you initialize, manipulate, and read out the qubit **optically, at room temperature** — and in isotopically purified diamond these spins reach a Hahn-echo coherence time $T_2 \approx 1.8$ ms, among the longest *room-temperature* electron-spin coherences in a solid <d-cite key="balasubramanian2009ultralong"></d-cite>. A nearby nuclear spin — the nitrogen's own, or a $^{13}$C neighbor — serves as a long-lived **memory**, holding a quantum state for up to about a minute in a ten-qubit register <d-cite key="bradley2019tenqubit"></d-cite>. (The same spin-dependent optical response makes the NV a world-class *quantum sensor*: diamond magnetometry and thermometry are built on exactly this physics.)

But the reason the NV center earns its place in *this* researcher's series is **networking**, and here it is a genuine star. An NV electron spin can emit a photon **entangled with its own state** — a spin–photon entanglement. Send that photon down a fiber, interfere it with a photon from a distant NV, and a successful detection *swaps* the entanglement onto the two faraway spins: you have entangled two nodes that never touched. This is not hand-waving. In 2015 a Delft team led by Ronald Hanson used entangled NV spins 1.3 km apart to perform the first **loophole-free Bell test**, closing the locality and detection loopholes simultaneously and settling an 80-year-old argument about quantum nonlocality <d-cite key="hensen2015loopholefree"></d-cite>. The same group then built a **three-node quantum network** of NV centers, demonstrating entanglement distribution and swapping across all three <d-cite key="pompili2021multinode"></d-cite>, and went on to **teleport** a qubit between two non-neighboring nodes — relaying quantum information through an intermediate node, the basic move of a future quantum internet <d-cite key="hermans2022teleportation"></d-cite>. A cousin defect, the **silicon-vacancy (SiV)** center, has cleaner optics and better cavity coupling; in 2024 a Harvard team entangled two SiV nodes through 35 km of deployed telecom fiber looped under the streets of Boston, with nuclear-spin memories storing the entanglement and error detection built in <d-cite key="knaut2024telecom"></d-cite>.

<figure class="l-body" style="text-align:center; margin:1.5rem auto; max-width:720px;">
  <svg viewBox="0 0 720 360" role="img" aria-label="A nitrogen-vacancy centre in diamond and how it networks. Panel A, the qubit and optical readout: a nitrogen-vacancy defect in the diamond lattice is excited by a green 532 nanometre laser and emits red fluorescence; the spin state m sub s equals 0, the zero state, glows bright while m sub s equals minus 1, the one state, stays dim, so counting red photons reads the spin. Panel B, networking: two NV nodes each emit a photon entangled with its spin; the two photons meet at a beam splitter, and a single detector click entangles the two distant spins that never met." style="width:100%; height:auto; font-family:sans-serif;">
    <defs>
      <marker id="nvBlue" markerWidth="8" markerHeight="8" refX="4" refY="4" orient="auto-start-reverse"><path d="M0 0 L8 4 L0 8 Z" fill="#4f7cff"/></marker>
      <marker id="nvRed" markerWidth="8" markerHeight="8" refX="4" refY="4" orient="auto-start-reverse"><path d="M0 0 L8 4 L0 8 Z" fill="#ef4444"/></marker>
      <marker id="nvTeal" markerWidth="9" markerHeight="9" refX="4.5" refY="4.5" orient="auto-start-reverse"><path d="M0 0 L9 4.5 L0 9 Z" fill="#14b8a6"/></marker>
    </defs>
    <line x1="360" y1="44" x2="360" y2="334" stroke="currentColor" stroke-width="1" stroke-dasharray="3 5" opacity="0.25"/>
    <!-- PANEL A: qubit + optical readout -->
    <text x="180" y="30" fill="currentColor" font-size="13" font-weight="700" text-anchor="middle">A &#183; the qubit &amp; optical readout</text>
    <circle cx="60" cy="92" r="5" fill="currentColor" fill-opacity="0.45"/>
    <circle cx="60" cy="172" r="5" fill="currentColor" fill-opacity="0.45"/>
    <circle cx="150" cy="172" r="5" fill="currentColor" fill-opacity="0.45"/>
    <line x1="105" y1="132" x2="60" y2="92" stroke="currentColor" stroke-width="1.2" opacity="0.35"/>
    <line x1="105" y1="132" x2="60" y2="172" stroke="currentColor" stroke-width="1.2" opacity="0.35"/>
    <line x1="105" y1="132" x2="150" y2="172" stroke="currentColor" stroke-width="1.2" opacity="0.35"/>
    <line x1="105" y1="132" x2="150" y2="92" stroke="currentColor" stroke-width="1.2" stroke-dasharray="3 3" opacity="0.45"/>
    <circle cx="105" cy="132" r="10" fill="currentColor" fill-opacity="0.15" stroke="currentColor" stroke-width="2"/>
    <text x="105" y="136" fill="currentColor" font-size="10" text-anchor="middle">N</text>
    <circle cx="150" cy="92" r="9" fill="none" stroke="currentColor" stroke-width="1.4" stroke-dasharray="3 2.5"/>
    <text x="150" y="96" fill="currentColor" font-size="9.5" text-anchor="middle">V</text>
    <text x="100" y="200" fill="currentColor" font-size="11" text-anchor="middle">N&#8211;V center in diamond</text>
    <line x1="206" y1="172" x2="124" y2="138" stroke="#14b8a6" stroke-width="2" marker-end="url(#nvTeal)"/>
    <text x="214" y="182" fill="#14b8a6" font-size="10" text-anchor="start">green laser</text>
    <text x="214" y="194" fill="#14b8a6" font-size="9.5" text-anchor="start">(532 nm)</text>
    <path d="M122 124 q 14 -12 26 -4 q 12 8 24 -6 q 10 -10 22 -4" fill="none" stroke="#ef4444" stroke-width="2" marker-end="url(#nvRed)"/>
    <text x="222" y="96" fill="#ef4444" font-size="10" text-anchor="start">637 nm glow</text>
    <text x="180" y="240" fill="currentColor" font-size="11.5" font-weight="700" text-anchor="middle">spin-dependent fluorescence</text>
    <text x="48" y="273" fill="currentColor" font-size="11" text-anchor="start">m<tspan dy="3" font-size="8">s</tspan><tspan dy="-3">=0 = |0&#x27E9;</tspan></text>
    <circle cx="232" cy="268" r="9" fill="#ef4444" fill-opacity="0.85"/>
    <text x="248" y="272" fill="#ef4444" font-size="10.5" text-anchor="start">glows bright</text>
    <text x="48" y="313" fill="currentColor" font-size="11" text-anchor="start">m<tspan dy="3" font-size="8">s</tspan><tspan dy="-3">=&#8722;1 = |1&#x27E9;</tspan></text>
    <circle cx="232" cy="308" r="9" fill="#ef4444" fill-opacity="0.25" stroke="#ef4444" stroke-width="1" stroke-opacity="0.5"/>
    <text x="248" y="312" fill="#ef4444" font-size="10.5" text-anchor="start">stays dim</text>
    <text x="180" y="346" fill="currentColor" font-size="11" font-style="italic" text-anchor="middle">count the red photons &#8594; read the spin</text>
    <!-- PANEL B: networking -->
    <text x="540" y="30" fill="currentColor" font-size="13" font-weight="700" text-anchor="middle">B &#183; a click entangles two distant nodes</text>
    <path d="M427 126 Q 540 60 657 126" fill="none" stroke="#14b8a6" stroke-width="1.6" stroke-dasharray="6 4" opacity="0.9"/>
    <text x="540" y="52" fill="#14b8a6" font-size="11.5" text-anchor="middle">entangled &#8212; two spins that never met</text>
    <rect x="405" y="128" width="44" height="44" rx="6" fill="currentColor" fill-opacity="0.04" stroke="#14b8a6" stroke-width="1.6"/>
    <line x1="427" y1="164" x2="427" y2="138" stroke="#14b8a6" stroke-width="2.6" marker-end="url(#nvTeal)"/>
    <text x="427" y="190" fill="currentColor" font-size="10.5" text-anchor="middle">NV node A</text>
    <rect x="635" y="128" width="44" height="44" rx="6" fill="currentColor" fill-opacity="0.04" stroke="#14b8a6" stroke-width="1.6"/>
    <line x1="657" y1="138" x2="657" y2="164" stroke="#14b8a6" stroke-width="2.6" marker-end="url(#nvTeal)"/>
    <text x="657" y="190" fill="currentColor" font-size="10.5" text-anchor="middle">NV node B</text>
    <path d="M451 150 q 13 -9 26 0 q 13 9 26 0" fill="none" stroke="#4f7cff" stroke-width="1.8" marker-end="url(#nvBlue)"/>
    <path d="M633 150 q -13 -9 -26 0 q -13 9 -26 0" fill="none" stroke="#4f7cff" stroke-width="1.8" marker-end="url(#nvBlue)"/>
    <text x="488" y="142" fill="#4f7cff" font-size="9.5" text-anchor="middle">photon</text>
    <text x="592" y="142" fill="#4f7cff" font-size="9.5" text-anchor="middle">photon</text>
    <polygon points="540,136 556,150 540,164 524,150" fill="currentColor" fill-opacity="0.06" stroke="currentColor" stroke-width="1.4"/>
    <text x="540" y="120" fill="currentColor" font-size="9.5" text-anchor="middle">beam splitter</text>
    <line x1="540" y1="166" x2="540" y2="196" stroke="#4f7cff" stroke-width="1.8" marker-end="url(#nvBlue)"/>
    <rect x="515" y="197" width="50" height="26" rx="3" fill="currentColor" fill-opacity="0.05" stroke="currentColor" stroke-width="1.5"/>
    <text x="540" y="214" fill="currentColor" font-size="10.5" text-anchor="middle">detector</text>
    <text x="540" y="246" fill="#ef4444" font-size="12.5" font-weight="700" text-anchor="middle">click!</text>
    <text x="540" y="276" fill="currentColor" font-size="11" font-style="italic" text-anchor="middle">one click &#8594; both spins entangled</text>
  </svg>
  <figcaption style="margin-top:.5rem;"><b>Figure 3.</b> The nitrogen-vacancy center, and why it networks. <b>(A)</b> The qubit is the NV electron spin; a green laser excites it and the red fluorescence is *spin-dependent* — $m_s=0$ ($\vert 0\rangle$) glows brighter than $m_s=-1$ ($\vert 1\rangle$), so simply counting red photons reads the spin out, optically, at room temperature. <b>(B)</b> The networking move: each node emits a photon entangled with its own spin; the two photons meet at a beam splitter, and a single detector "click" — which erases *which* node emitted — swaps entanglement onto the two distant spins. This is the mechanism behind the 1.3 km Bell test and the three-node NV network.</figcaption>
</figure>

The costs are the mirror image of the strengths. **Scaling is brutal:** defects nucleate at essentially random positions in the diamond, so assembling many into a large, precisely aligned array is a fabrication nightmare — there is no lithographic "place an NV here" the way there is for a transistor. **Photon collection is poor:** only a few percent of an NV's emission lands in the coherent *zero-phonon line* (the sharp, usable part of the spectrum), and it comes out at 637 nm, well off the telecom band, so long hauls need wavelength conversion (the SiV-in-a-cavity approach is partly a fix for this). And network-grade coherence and optics generally want cooling to a few kelvin. None of this makes diamond a front-runner for *large-scale computing* — but as a *network node and sensor*, it pushes the solid state to its ceiling. Diamonds, it turns out, are a qubit's best friend: a flaw you talk to with green light, that moonlights as a magnetometer, and that can fire its state down a fiber to a node across the city.

## The long tail

Beyond the three main contenders runs a tail of platforms too early, too specialized, or too historic to headline — but worth knowing, if only to read the field's news correctly.

**Trapped electrons and electrons on solids.** Why trap a whole atom when the qubit lives on one electron? A small community traps *bare* electrons — historically floating on liquid helium, and more recently on a film of frozen neon. In 2022 a Chicago-led group integrated a single electron on solid neon into a superconducting-circuit (cQED) architecture and ran it as a charge qubit with surprisingly long coherence <d-cite key="zhou2022electronneon"></d-cite>. It is a genuinely new platform, years behind the leaders, but conceptually clean.

**Molecular qubits.** Individual ultracold polar molecules, held in optical tweezers like neutral atoms but with a far richer internal structure (rotational, vibrational, and spin states), have been proposed as qubits for years. In 2023 a Princeton group achieved **on-demand entanglement of two individually controlled molecules** in a tweezer array, using their dipole–dipole interaction to make a Bell pair <d-cite key="holland2023molecules"></d-cite> — a foundational proof of principle, not yet a processor.

**Rare-earth ions in crystals.** The tail's most network-relevant member. Single rare-earth ions — erbium or europium doped into a host crystal such as yttrium orthosilicate — pair optical addressability with exceptionally long-lived nuclear-spin memories. Erbium's appeal is specific and large: it emits *directly* in the ~1.5 μm telecom band that fiber networks are built around, sidestepping the very wavelength-conversion problem that dogs the NV's 637 nm light. Single erbium ions have now been detected and coherently controlled <d-cite key="dibos2018erbium"></d-cite><d-cite key="ourari2023erbium"></d-cite>, making this a quiet dark horse for telecom-native network nodes.

**Nuclear-spin ensembles (NMR).** The oldest qubit platform of all is also the most cautionary. Liquid-state nuclear magnetic resonance — radio pulses driving the nuclear spins of atoms in a molecule — ran the *first* quantum algorithms: Grover search in the late 1990s and, famously, the first physical run of Shor's algorithm, factoring 15 with a seven-spin molecule in 2001 <d-cite key="vandersypen2001shor"></d-cite>. But NMR fundamentally **does not scale**: the signal from a thermal ensemble shrinks exponentially with qubit number, and the "qubits" are an average over $\sim10^{18}$ molecules rather than individually controlled. It is of textbook-historic value now — a reminder that running an algorithm once is not the same as building a computer.

One honest caution to close the tail, because it trips up almost every popular ranking: **do not confuse qubit *counts* across architectures.** D-Wave's Advantage2 carries more than 4,400 superconducting flux qubits — far more than any gate-model machine <d-cite key="dwave2025advantage2"></d-cite>. But it is a **quantum annealer**: it relaxes toward the solution of an optimization problem, and it is *not* a universal gate-model computer. Its 4,400 qubits and the ~100–1,000+ qubits of a gate-model chip are simply different things, and cannot be compared head-to-head. It is a four-thousand-key piano that plays one kind of chord — more keys does not mean it can play the whole songbook.

## Where they sit

Line the contenders up and the survey's thesis snaps into focus: **each bets on a different breakthrough, patching exactly where the front-runners fall short** — silicon spin on mass production, color centers on networking, topological on hardware-level error correction. The map and table below spell out the trades; what unites the three is their shared soft spot, not their strengths. All are small-scale today — roughly a dozen working qubits each — with younger, more fragmented communities than the big four.

<figure class="l-body" style="text-align:center; margin:1.5rem auto; max-width:640px;">
  <svg viewBox="0 0 720 430" role="img" aria-label="A schematic positioning map of qubit platforms on two axes: the horizontal axis is manufacturability or mass-production, the vertical axis is how naturally a platform networks over light. Silicon spin sits at high manufacturability but low networking; color centers sit at high networking but low manufacturability; topological is drawn as a ghosted dashed question mark because it is unproven. The upper-right corner, where a platform would both mass-produce and network, is empty." style="width:100%; height:auto; font-family:sans-serif;">
    <defs>
      <marker id="mapAx" markerWidth="9" markerHeight="9" refX="7" refY="4.5" orient="auto"><path d="M0 0 L9 4.5 L0 9 Z" fill="currentColor"/></marker>
    </defs>
    <line x1="95" y1="350" x2="678" y2="350" stroke="currentColor" stroke-width="1.6" marker-end="url(#mapAx)"/>
    <line x1="95" y1="350" x2="95" y2="58" stroke="currentColor" stroke-width="1.6" marker-end="url(#mapAx)"/>
    <text x="388" y="384" fill="currentColor" font-size="12.5" text-anchor="middle">manufacturability (mass-production) &#8594;</text>
    <text x="62" y="205" fill="currentColor" font-size="12.5" text-anchor="middle" transform="rotate(-90 62 205)">networking over light &#8594;</text>
    <rect x="470" y="80" width="190" height="118" rx="6" fill="currentColor" fill-opacity="0.03" stroke="currentColor" stroke-width="1.1" stroke-dasharray="5 4" opacity="0.6"/>
    <text x="565" y="128" fill="currentColor" font-size="11.5" font-style="italic" text-anchor="middle">no platform</text>
    <text x="565" y="146" fill="currentColor" font-size="11.5" font-style="italic" text-anchor="middle">lives here yet</text>
    <text x="565" y="168" fill="currentColor" font-size="10" text-anchor="middle">(scales AND networks)</text>
    <circle cx="592" cy="300" r="9" fill="#14b8a6" fill-opacity="0.85"/>
    <text x="592" y="322" fill="#14b8a6" font-size="11.5" font-weight="700" text-anchor="middle">silicon spin</text>
    <circle cx="180" cy="120" r="9" fill="#4f7cff" fill-opacity="0.85"/>
    <text x="180" y="108" fill="#4f7cff" font-size="11.5" font-weight="700" text-anchor="middle">color centers</text>
    <circle cx="345" cy="205" r="11" fill="none" stroke="currentColor" stroke-width="1.8" stroke-dasharray="4 3" opacity="0.7"/>
    <text x="345" y="210" fill="currentColor" font-size="13" font-weight="700" text-anchor="middle" opacity="0.7">?</text>
    <text x="345" y="234" fill="currentColor" font-size="10.5" text-anchor="middle" opacity="0.7">topological (unproven)</text>
    <text x="388" y="414" fill="currentColor" font-size="11" font-style="italic" text-anchor="middle">the prize corner &#8212; scales AND networks &#8212; sits empty</text>
  </svg>
  <figcaption style="margin-top:.5rem;"><b>Figure 4.</b> Where the contenders sit (schematic). The horizontal axis is how readily a platform can be mass-produced; the vertical, how naturally it networks over light. Silicon spin owns the manufacturability axis; color centers own the networking axis; and topological is a ghost, its position still unmeasured. The prize corner — a qubit that *both* scales and networks — is empty.</figcaption>
</figure>

| | Silicon spin | Topological (Majorana) | Color center (NV/SiV) |
|---|---|---|---|
| **Qubit** | spin of one electron in a quantum dot | non-local parity of two Majorana modes | electron spin of a diamond defect |
| **Headline bet** | mass-produce on CMOS lines | hardware-level error protection | room-temperature network node |
| **Best fidelity** | up to 99.99% single-qubit (donor, 2025) | none demonstrated (disputed) | high, but few qubits |
| **Coherence** | ms (electron), s (nuclear) | unmeasured | ms at room temp; ~minute memory |
| **Operating temp** | ~0.1 K, even &gt;1 K ("hot") | ~10 mK (and unproven) | room temp; few K for networking |
| **As a network node** | needs transduction | n/a (not built) | natural and proven |
| **Status** | real, ~12 qubits | not proven | real, networking-focused |

And so the account closes, five builds deep. There is no universally best qubit — only different trades, each platform with its one gift and its matching tax. Superconducting is fast; trapped ions are precise; neutral atoms scale; photons fly; and the solid-state contenders each chase a single breakthrough none of the others can reach. The lesson that matters most for a quantum *network* is hiding in that sentence: the team that scales best (silicon spin) and the team that networks best (color centers) are not the same team — and no single platform yet has both. So the likeliest future is not one qubit seizing the crown, but a *quantum network* stitching many together — a superconducting or atomic processor here, a diamond node there, photons carrying entanglement between them, each doing the one job it does best. Which is, when you think about it, exactly the bet a quantum-network researcher is paid to make. The interesting question was never which qubit wins. It is how you wire them together.

---

**More in this series — [How to Build a Quantum Computer](/blog/2026/how-to-build-a-quantum-computer/):** [Superconducting](/blog/2026/superconducting-qubits/) · [Trapped ion](/blog/2026/trapped-ion-qubits/) · [Neutral atom](/blog/2026/neutral-atom-qubits/) · [Photonic](/blog/2026/photonic-qubits/) · [Other platforms](/blog/2026/other-qubit-platforms/)
