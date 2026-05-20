---
layout: page
permalink: /quantum-network/
title: quantum network
description:
nav: false
nav_order: 7
---

> **A 5-minute primer on what quantum networks are, why they matter, how they work — and the algorithmic questions my group works on.**

The internet you are reading this on moves **bits**. The next one will also move **qubits and entanglement** — a fundamentally different kind of resource that unlocks computing, sensing, and security guarantees no classical network can match. This page is a quick tour of where the field is heading, and where my recent research fits in.

## What is a quantum network?

A **quantum network** is communication infrastructure for transmitting *quantum* information — qubits and, crucially, **entanglement** — between distant nodes. Where classical networks shuttle 0s and 1s, quantum networks exploit superposition and entanglement to enable capabilities that are *provably impossible* in a classical world.

The basic primitive is not "send a bit" but "**share an entangled pair** between two remote nodes." Once two nodes share entanglement, they can teleport qubits, generate shared secret keys, or coordinate measurements with sub-classical noise. Almost every application of a quantum network reduces to: *how do we deliver high-fidelity entanglement, where it is needed, when it is needed?*

<div class="row justify-content-center">
    <div class="col-12 col-md-10">
        <img src="/assets/img/quantum_network_what.svg" alt="Quantum network diagram showing nodes transmitting quantum information" class="img-fluid rounded" />
    </div>
</div>

## Why quantum networks?

Three flagship applications drive the field — and they map onto three big technological frontiers.

### 1. Distributed quantum computing — scaling beyond a single chip

A single quantum processor is bounded by how many qubits it can host coherently. Networking many smaller processors via entanglement turns them into a **single, larger virtual machine** — the quantum analogue of how classical data centers scale by interconnect, not by chip size. This is the most plausible path to fault-tolerant, large-scale quantum computation.

### 2. Distributed quantum sensing — precision past the shot-noise limit

Distributing entangled states across an array of sensors lets them measure in concert, achieving precision *beyond* what any classical sensor network can reach. Applications include gravitational-wave detection, dark-matter searches, ultra-precise clock networks, and long-baseline interferometry.

### 3. Quantum key distribution — security guaranteed by physics

**QKD** lets two parties generate a shared secret key whose security rests on the laws of quantum mechanics: any eavesdropper *must* disturb the channel, and that disturbance is detectable. This is information-theoretic security — it does not break when the adversary buys a bigger computer (or a quantum one).

<div class="row justify-content-center mt-4">
    <div class="col-12 col-md-10">
        <img src="/assets/img/quantum_network_why.svg" alt="Three pillars of quantum networks: distributed computing, sensing, and QKD" class="img-fluid rounded" />
    </div>
</div>

## How do quantum networks work?

The headline obstacle is the **no-cloning theorem**: unknown qubits cannot be copied, so classical signal amplification is off the table. Photons sent through optical fiber are lost *exponentially* with distance — a death sentence for any naive long-haul link.

The fix is the **quantum repeater**. A long link is broken into short segments, and three primitives are chained together:

- **Entanglement generation** — neighboring nodes establish short-range entangled pairs.
- **Entanglement swapping** — a middle node "fuses" two short pairs into one longer-range pair.
- **Entanglement distillation** — many noisy pairs are sacrificed to produce fewer high-fidelity pairs.

Stitching repeaters together extends entanglement to continental and ultimately global scales — the substrate of a future **quantum internet**.

<div class="row justify-content-center mt-4">
    <div class="col-12 col-md-10">
        <img src="/assets/img/quantum_network_how.svg" alt="Quantum repeater chain showing entanglement generation, swapping, and distillation" class="img-fluid rounded" />
    </div>
</div>

## Where my research fits

The hardware story above hides a tower of unsolved **algorithmic** questions. Link fidelities are noisy, drift over time, and are never known up front. Repeater memories are scarce. Probes that measure the network themselves consume the resource being measured. My recent work tackles two of these head-on.

### Quantum routing — finding good entanglement paths under uncertainty

Even if you have a working repeater network, *which path* should you use to connect Alice and Bob? Path fidelity depends on every link, and link fidelities are unknown and time-varying. We cast this as an **online learning** problem: probe paths, observe noisy outcomes, and converge on a near-optimal path while paying as little regret as possible.

- **[Learning Best Paths in Quantum Networks](https://www.arxiv.org/pdf/2506.12462)** (INFOCOM 2025) — an online algorithm for entanglement-path selection with provable regret guarantees under unknown, noisy link fidelities.
- **[LinkSelFiE: Link Selection and Fidelity Estimation in Quantum Networks](https://ieeexplore.ieee.org/document/10621263)** (INFOCOM 2024) — joint link selection and fidelity estimation as a building block for routing.

### Quantum network tomography — measuring the network you cannot observe classically

Before you can route well, you need to *know the network* — link fidelities, decoherence rates, error parameters. But every probe consumes entanglement, probes interact in non-trivial ways across shared links, and the measurements themselves are noisy. **Quantum network tomography** asks: *what* can we identify from probe data, and *how* should we allocate a limited probe budget to learn it as fast as possible?

- **[Quantum Network Tomography for General Topology with SPAM Errors](https://arxiv.org/abs/2511.01074)** (preprint, 2025) — identifies and estimates per-link channel parameters on arbitrary network topologies while accounting for state-preparation and measurement (SPAM) errors.
- **[Online Optimal Probe Allocation for Quantum Network Tomography](https://arxiv.org/abs/2504.21549)** (QCNC 2026) — an online probe-allocation algorithm that matches the offline optimum up to vanishing terms.

Together, these threads contribute pieces of an **algorithmic foundation for the quantum internet**: how to learn, route, and measure on a network whose physics is unforgiving and whose state is never fully observable. If any of this excites you, [come build it with me](/#joining-the-lab).
