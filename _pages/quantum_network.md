---
layout: page
permalink: /quantum-network/
title: quantum network
description:
nav: true
nav_order: 7
---

## What is a Quantum Network?

A quantum network is a communication infrastructure designed for transmitting quantum information — such as qubits and entanglement — between distant nodes. Unlike classical networks that carry bits (0s and 1s), quantum networks leverage the principles of quantum mechanics, including superposition and entanglement, to enable fundamentally new capabilities in computing, sensing, and security.

<div class="row justify-content-center">
    <div class="col-12 col-md-10">
        <img src="/assets/img/quantum_network_what.svg" alt="Quantum network diagram showing nodes transmitting quantum information" class="img-fluid rounded" />
    </div>
</div>

## Why Quantum Networks?

Quantum networks unlock transformative applications across multiple domains:

### 1. Scalable Quantum Computing — Distributed Quantum Computing

Single quantum processors face physical limits on the number of qubits they can reliably support. Quantum networks enable **distributed quantum computing**, where multiple quantum processors are interconnected to work collectively as a single, more powerful machine. This provides a scalable path toward fault-tolerant, large-scale quantum computation.

### 2. Advanced Physics Discovery — Distributed Quantum Sensing

By distributing entangled states across a network of sensors, quantum networks enable **distributed quantum sensing** with precision beyond the classical shot-noise limit. This has profound implications for fundamental physics experiments, including gravitational wave detection, dark matter searches, and high-precision metrology.

### 3. Secured Communication — Quantum Key Distribution

Quantum networks support **Quantum Key Distribution (QKD)**, which allows two parties to generate shared secret keys with security guaranteed by the laws of physics. Any attempt to eavesdrop on the quantum channel introduces detectable disturbances, providing information-theoretic security that is unattainable with classical cryptographic methods.

<div class="row justify-content-center mt-4">
    <div class="col-12 col-md-10">
        <img src="/assets/img/quantum_network_why.svg" alt="Three pillars of quantum networks: distributed computing, sensing, and QKD" class="img-fluid rounded" />
    </div>
</div>

## How Do Quantum Networks Work?

The key enabling technology for quantum networks is the **quantum repeater**. Quantum information cannot be amplified like classical signals due to the no-cloning theorem, which means direct transmission of qubits over long distances suffers from exponential photon loss in optical fibers. Quantum repeaters overcome this challenge by dividing a long-distance link into shorter segments and using **entanglement generation**, **entanglement swapping**, and **entanglement distillation** to establish high-fidelity end-to-end entanglement across the entire network.

By chaining quantum repeaters together, quantum networks can distribute entanglement over continental and eventually global scales, forming the backbone of a future **quantum internet**.

<div class="row justify-content-center mt-4">
    <div class="col-12 col-md-10">
        <img src="/assets/img/quantum_network_how.svg" alt="Quantum repeater chain showing entanglement generation, swapping, and distillation" class="img-fluid rounded" />
    </div>
</div>
