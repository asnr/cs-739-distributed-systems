## What was the most interesting or important aspect in the Hamilton paper? In the Dean slides? Which aspect of each do you think is least relevant or important today?

Most interesting part of the Hamilton paper is its breadth. There are so many things to keep track of! I wonder if any one of the systems in Microsoft at the time made use of all of these techniques, or was this list a union of them? Also, the 'big red switch', or tested process for shedding load when at capacity, seems like a really good idea! I've heard of people doing this on the fly, but having a tested process makes this much more reliable.

I think the Hamilton paper by and large stands the test of time. There are a couple of points that one can maybe argue against. For example, under 'Dependency Management' Hamilton cautions against depending on small services; the microservices movement would argue that doing the opposite leads to an improvement in velocity (and in his slides Dean writes 'break large complex systems down into many services'). However, Hamilton provides some very reasonable criteria for when to build a new service, so it's hard to be too hard on him here.

The most interesting part of the Dean paper is how fluently he does back of the envelope calculations with very basic assumptions. When I do similar calculations, I usually start by taking measurements using a prototype close to the final product I'm considering, but Dean seems like he would be happy to proceed without building anything.

Surprisingly, the 'numbers everyone should know' have not gotten wildly out of date. Here is a quick comparison of some numbers from Dean against modern benchmarks:

- L1 cache reference. Dean: 0.5ns. Skylake: 4-5 cycles, 1-3 ns. 
- Branch mispredict. Dean: 5ns. Skylake: 16.5 cycles (average), 5-10 ns.
- L2 cache reference. Dean: 7ns. Skylake: 14 cycles, 4-9 ns.

The Skylake cache latency figures have come from combining Wikichip's information on [cache miss latencies](https://en.wikichip.org/wiki/intel/microarchitectures/skylake_%28server%29#Memory_Hierarchy) (measured in cycles) with Wikichip's table of Skylake [clock frequencies](https://en.wikichip.org/wiki/intel/microarchitectures/skylake_%28server%29#All_Skylake_Chips).

The details of BigTable don't seem particularly relevant anymore. I'm intrigued by having timestamp as one of the fundamental ways to index your data. It doesn't seem particularly general, but I guess if you never want to delete any data it might be useful? Is this (i.e. never overwriting, but rather writing a new record with a more recent timestamp) a thing?
