---
layout: page
permalink: /agentic-network/
title: agentic network
description:
nav: false
nav_order: 8
---

> **A 5-minute primer on what agentic networks are, why they matter, how they work — and the algorithmic questions my group works on.**

The next wave of intelligent systems will not be a single, monolithic model behind an API. It will be **many AI agents** — LLMs, planners, tool-users, sensors, controllers — **talking to each other** to act in the world. This page is a quick tour of where the field is heading, and where my recent research fits in.

## What is an agentic network?

An **agentic network** is a system of AI agents that **communicate, coordinate, and learn together** to accomplish tasks that no single agent can solve alone. Each agent gathers its own observations, acts in its own slice of the world, and exchanges messages with peers to share what it has learned. The network is the unit of intelligence — not any individual agent.

The basic primitive is not "make a prediction" but "**share what you learned, decide what to do next**." Almost every interesting question about agentic networks reduces to: *how should agents exchange information so the group learns and acts as efficiently as possible — under bandwidth, privacy, and heterogeneity constraints?*

<div class="row justify-content-center">
    <div class="col-12 col-md-10">
        <img src="/assets/img/agentic_network_what.svg" alt="Agentic network diagram: an LLM reasoner, planner, tool-user, sensor, and actuator exchange messages over links so the group acts as one." class="img-fluid rounded" />
    </div>
</div>

## Why agentic networks?

Three flagship application areas drive the field — and they map onto three big technological frontiers.

### 1. Learning at scale — many agents, one shared experience

A single agent learns from a single stream of data. A *population* of agents can pool experience and converge dramatically faster — the AI analogue of how distributed training scales by interconnect, not by model size. This is the most plausible path to learning agents that adapt to new environments in minutes rather than days.

### 2. Heterogeneous teams — different sensors, different skills, one goal

Real deployments mix agents with **different observations, action sets, and rewards**: a recommendation system with users who like different things; a sensor network whose nodes see overlapping but distinct slices of the environment; a team of LLM agents specialized for different tools. Coordinating heterogeneous agents is fundamentally harder than coordinating identical ones — and it is the regime that matters in practice.

### 3. Aligned LLM agents — many models, one user

As LLM agents proliferate, *which* response should be served, and *which* agent's feedback should be trusted? Agentic-network methods let a population of LLMs jointly **evaluate, rank, and align** their outputs to a particular user, turning what would otherwise be a fragmented model zoo into a coherent assistant.

<div class="row justify-content-center mt-4">
    <div class="col-12 col-md-10">
        <img src="/assets/img/agentic_network_why.svg" alt="Three flagship applications of agentic networks: learning at scale, heterogeneous teams, and aligned LLM agents." class="img-fluid rounded" />
    </div>
</div>

## How do agentic networks work?

The headline obstacle is the **cost of communication**: naive "tell everyone everything every round" scales quadratically in agents and saturates any realistic link. Worse, agents see *partial, noisy* feedback — and even what they observe is often correlated with the messages they receive, breaking the independence assumptions that make single-agent learning tractable.

The fix is a small set of design primitives that recur across cooperative learning:

- **Selective communication** — agents decide *when* and *what* to share, often by message-saving triggers tied to how informative an observation is.
- **Aggregation and consensus** — local estimates are combined (averaged, leader-coordinated, or fully distributed) to form a shared view of the world.
- **Robustness to heterogeneity and adversaries** — protocols must survive agents with different reward distributions, asynchronous clocks, or even maliciously corrupted feedback.

Stitching these primitives together yields cooperative algorithms whose **per-agent regret matches single-agent optimal**, while **total communication grows only logarithmically (or better) with the horizon** — the substrate of a scalable agentic network.

<div class="row justify-content-center mt-4">
    <div class="col-12 col-md-10">
        <img src="/assets/img/agentic_network_how.svg" alt="How agentic networks work: selective communication, aggregation and consensus, and robustness combine to give near-optimal per-agent regret with low total communication." class="img-fluid rounded" />
    </div>
</div>

## Where my research fits

The vision above hides a tower of unsolved **algorithmic** questions. Agents have bounded bandwidth. They disagree on what they see. They run on different clocks. Some are adversarial. Some are LLMs whose feedback is human and noisy. My recent work tackles four of these head-on.

### Communication-efficient cooperation — getting near-optimal regret on a budget

When can a group of cooperating learners match the regret of a single learner with all the data — *without* flooding the network? We design protocols whose communication cost grows much slower than the regret it saves, and analyze the fundamental tradeoff between the two.

- **[Asynchronous Multi-Agent Bandits: Fully Distributed vs. Leader-Coordinated Algorithms](https://dl.acm.org/doi/10.1145/3711696)** (SIGMETRICS 2025) — drops the lock-step assumption that pervades multi-agent bandit analyses and clarifies the communication-vs-regret tradeoff for cooperating learners.
- **Federated Multi-armed Bandits with Efficient Bit-Level Communications** (NeurIPS 2025).
- **[Achieve Near-Optimal Individual Regret & Low Communications in Multi-Agent Bandits](https://openreview.net/forum?id=QTXKTXJKIh)** (ICLR 2023).
- **[On-Demand Communication for Asynchronous Multi-Agent Bandits](https://proceedings.mlr.press/v206/chen23c)** (AISTATS 2023).

### Heterogeneous and asymmetric cooperation — when agents do not see the same world

Real teams are not identical. Agents may have different reward distributions, different observation models, or only partial knowledge of each other's existence. We characterize when heterogeneity *helps* (exploration for free) and design algorithms that exploit it.

- **[Heterogeneous Multi-Agent Multi-Armed Bandits on Stochastic Block Models](https://arxiv.org/abs/2502.08003)** (SIGMETRICS 2026).
- **[Heterogeneous Multi-Agent Bandits with Parsimonious Hints](https://ojs.aaai.org/index.php/AAAI/article/view/34143)** (AAAI 2025).
- **[Optimal Regret Bounds for Federated Multi-armed Bandits with Fully Distributed Communication](https://openreview.net/pdf?id=CaIlqE8AKU)** (UAI 2025).
- **[Exploration for Free: How Does Reward Heterogeneity Improve Regret in Cooperative Multi-agent Bandits?](https://proceedings.mlr.press/v216/wang23a.html)** (UAI 2023).

### Scalable agent grouping and shareable policies — when resources, not agents, are the bottleneck

In large agentic systems, multiple agents often want to use the *same* resource (an arm, a server, a tool). We design algorithms for **shareable** arms and resource-aware cooperation, where the right unit of optimization is the resource, not the agent.

- **[Online Learning for Ski-Rental Problem](https://arxiv.org/abs/2507.15727)** (Preprint).
- **[Multiple-Play Stochastic Bandits with Shareable Finite-Capacity Arms](https://proceedings.mlr.press/v162/wang22af)** (ICML 2022).
- **[Multi-Player Multi-Armed Bandits with Finite Shareable Resources Arms](https://www.ijcai.org/proceedings/2022/491)** (IJCAI 2022).

### Aligning LLM agents from interactive feedback — a population of models, a single user

When the agents are LLMs and the feedback is human, the problem becomes: *which* response, from *which* model, should the user see? We cast this as an online learning problem over a conversational multi-agent system that jointly evaluates and selects user-aligned responses.

- **[A Multi-Agent Conversational Bandit Approach to Online Evaluation and Selection of User-Aligned LLM Responses](https://arxiv.org/abs/2501.01849)** (AAAI 2026) — an online algorithm for selecting user-aligned LLM responses from a population of agents under interactive feedback.

Together, these threads contribute pieces of an **algorithmic foundation for networked AI agents**: how to learn, communicate, and align in a world where intelligence is collective and feedback is noisy. If any of this excites you, [come build it with me](/#joining-the-lab).
