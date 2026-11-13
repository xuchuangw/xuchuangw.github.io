---
layout: about
title: about
permalink: /
subtitle: Assistant Professor, Department of Computer Science, HKBU
# <a href='#'>Affiliations</a>. Address. Contacts. Moto. Etc.

profile:
  align: left
  image: headshot-cs-cqcc27.jpeg
  image_alt: Xuchuang Wang
  image_circular: true # crops the image to make it circular
  more_info: >
    Assistant Professor,<br>
    Dept. of Computer Science, HKBU<br>
    <a href="mailto:xuchuangw@hkbu.edu.hk">xuchuangw [at] hkbu.edu.hk</a><br>
    <a href="https://scholar.google.com/citations?user=QJ66dEcAAAAJ">Google Scholar</a>

news: true # includes a list of news items
latest_posts: false # includes a list of the newest posts
selected_papers: false # includes a list of papers marked as "selected={true}"
social: true # includes social icons at the bottom of the page
---

I am an Assistant Professor in the [Department of Computer Science](https://www.comp.hkbu.edu.hk/v1/) at [Hong Kong Baptist University](https://www.hkbu.edu.hk/). My research develops the **algorithmic foundations of quantum information and computing**, with a focus on **quantum networking**, **quantum machine learning**, and an expanding direction in **distributed quantum computing**.

I study how quantum resources can be used efficiently for communication, learning, and computation:

<!-- prettier-ignore -->
- **Quantum networking:** how to distribute entanglement, select reliable paths, and characterize noisy quantum links.
- **Quantum machine learning:** when quantum access to information can accelerate learning and sequential decision-making.
- **Distributed quantum computing:** how to coordinate entanglement, communication, and computation across interconnected quantum processors.
{: .research-overview }

My approach combines **learning theory, quantum algorithms, and optimization**. Online learning, bandits, and reinforcement learning provide tools for making decisions under uncertainty; quantum information brings new opportunities and constraints. I aim to develop algorithms with **provable guarantees** that account for noise, limited measurements, and scarce quantum resources.

<div class="recruiting-notice">
<strong>Join my group at HKBU:</strong> I am recruiting a fully funded Postdoc, fully funded Ph.D. students (Spring / Fall 2027), and Research Assistants for research in quantum information and computing. Opportunities are available in Hong Kong, Guangzhou, or remotely, depending on the position. See <a href="/openings/">openings and how to apply</a>.
</div>

## research highlights and directions

<div class="research-highlights" markdown="1">

### Quantum networking

I develop learning algorithms for the **quantum internet**, including entanglement routing, link selection, and network tomography. The central challenge is to make reliable decisions when link quality is uncertain and measurements consume valuable quantum resources.

- **Network characterization:** quantum-classical coexistence tomography ([QCE'26](https://arxiv.org/abs/2608.09364), **Best Paper Award**), adaptive probe allocation ([QCNC'26](https://arxiv.org/abs/2504.21549)), and network evaluation ([Mergecast preprint](https://arxiv.org/abs/2511.01074)).
- **Routing and resource allocation:** learning entanglement paths ([INFOCOM'25](https://www.arxiv.org/pdf/2506.12462)) and selecting quantum links with fidelity estimation ([INFOCOM'24](https://ieeexplore.ieee.org/document/10621263)).

### Quantum machine learning

I study **quantum advantages in learning and sequential decision-making**, especially quantum bandits and best-arm identification. My work examines both the speedups enabled by quantum access and the constraints that affect whether those speedups can be realized.

- **Quantum learning algorithms:** best-arm and top-arm identification with quantum oracles ([AAAI'25](/publications/#wang2025best), [QCE'25](/publications/#wang2025toparms)).
- **Resource constraints:** quantum learning with limited rounds of adaptivity ([NeurIPS'26a](/publications/#li2026quantum)) and quantum bandits under memory decoherence ([NeurIPS'26b](/publications/#muralitharan2026quantum)).

### Learning theory and broader applications

My broader work develops foundations for learning with limited, heterogeneous, or unreliable feedback. Topics include communication-efficient cooperative learning ([SIGMETRICS'25](https://dl.acm.org/doi/10.1145/3711696), [NeurIPS'25](https://openreview.net/pdf?id=o3x3RV8XHd)), robustness to manipulated feedback ([ICLR'25](https://openreview.net/pdf?id=vOFx8HDcvF)), and learning from multiple feedback sources ([ICML'25](https://arxiv.org/pdf/2504.15812), [NeurIPS'23](https://proceedings.neurips.cc/paper_files/paper/2023/hash/64602b87c31db70a3ef060f6c5d5b01d-Abstract-Conference.html)). Related applications include [agentic networking](/blog/2026/agentic-networking/) and LLM evaluation and alignment ([AAAI'26](https://arxiv.org/abs/2501.01849)).

</div>

See my [publications](/publications/) for the full list of papers and my [quantum networking overview](/blog/2026/quantum-networking/) for an introduction to that area.

## joining the lab

I welcome students and researchers interested in the mathematical and algorithmic questions behind **quantum networks, quantum learning, and distributed quantum computation**. Strong foundations in probability, optimization, or theoretical computer science are especially useful. Applicants from **computer science, mathematics, and physics** are all welcome.

Alongside Ph.D. and postdoctoral positions, I host **Research Assistants on 3- or 6-month terms**, remotely or onsite at HKBU. These positions suit senior undergraduates, master's students, and recent graduates who want to explore research, prepare for a Ph.D., or develop a project toward publication.

Students in my group publish at venues including NeurIPS, ICML, ICLR, AAAI, SIGMETRICS, and INFOCOM, and collaborate with researchers at UMass, CUHK, CityU, NJU, and SJTU. Meet recent mentees and see their work on the [team page](/team/). For available positions, research topics, and application instructions, visit [openings](/openings/).

## background

Before joining HKBU, I was an [RGC Junior Research Fellow](https://www.ugc.edu.hk/eng/rgc/funding_opport/jrfs/) in the [Department of Computer Science and Engineering](https://www.cse.cuhk.edu.hk/) at [The Chinese University of Hong Kong](https://www.cuhk.edu.hk/). Previously, I spent three years as a postdoctoral researcher at [UMass Amherst](https://www.cics.umass.edu/), working with [Don Towsley](https://www-net.cs.umass.edu/personnel/towsley.html) in [ACQUIRE Lab](https://acquire.cs.umass.edu/) and [Mohammad Hajiesmaili](https://groups.cs.umass.edu/hajiesmaili/) in [SOLAR Lab](https://solar.cs.umass.edu/).

I received my Ph.D. in Computer Science and Engineering from CUHK, advised by [John C.S. Lui](https://www.cse.cuhk.edu.hk/~cslui/) in [ANSR Lab](http://ansrlab.cse.cuhk.edu.hk/), and my B.Eng. with Honours from [Xi'an Jiaotong University](https://en.xjtu.edu.cn/) through the honours program now known as [Qian Xuesen Honors College](https://bjb.xjtu.edu.cn/).

My work has received the <span style="color: var(--global-theme-color);">**Best Paper Award at IEEE Quantum Week (QCE) 2026**</span> and the <span style="color: var(--global-theme-color);">**Best Paper Runner-Up at ACM SIGMETRICS 2025**</span>.
