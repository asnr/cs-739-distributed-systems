Why do computers stop and what can be done about it?, Jim Gray, 1985

Disk failures in the real world: What does an MTTF of 1,000,000 hours mean to you?, Bianca Schroeder, Garth A. Gibson, 2007

## What aspect of Gray's paper is most correct still today? Which is most wrong? What is the most important result from the Schroeder/Gibson disk failure paper for system designers?

There are aspects of the Gray paper that one can nitpick, for example, the assertion that "if a transaction commits [on a remote system], the messages on the [network] session will be delivered exactly ONCE". This won't be true if the final "transaction complete" message gets lost/times out. Also, many of the numbers that Gray provides are no longer applicable to modern systems. For instance, Gray states that "well-managed transaction processing systems fail about once every two weeks", typically taking approximately 90 minutes to recover, mostly due to the long start up time of a "large terminal network". From my experience, these numbers are all too large and restarting a "large terminal network" is not a common part of system recovery.

Zooming out, Gray's architecture of composing systems using processes that communicate via OS messaging isn't a pattern that I've encountered in business applications. Taking a stab in the dark, I would say that concerns around operations and deployment make process-level modularity unpopular. Perhaps this is more prevalent in control systems?

Broadly speaking though, many of Gray's observations still hold today. In particular, his observation that administrative mistakes are a top cause of errors and that they should be controlled by making systems that require minimal configuration and maintenance still rings true. That several of the worst (publicly described) outages at Google and Facebook heavily feature operator error supports this.

The most important result from the Schroeder/Gibson disk failure paper for system designers is the figure of 2-4% for observed Annualised Replacement Rate of disks. This figure is so high that designers of mission-critical systems with hard data loss or uptime requirements must have a strategy for handling at the least single disk failure.

The next most important observation for system designers is that a second disk failure is more likely to happen soon after a first disk fails. Thus when calculating the probability that, for a example, a piece of data is lost when two disks in a RAID 5 configuration fail in quick succession, designers must expect that simply multiplying probabilities of individual disk failures will significantly understimate the true probability.

## Extra notes, Gray:

- numbers off, but general direction of observations still hold
  - modern disks MTBF > 10k hours, ~ 1 hard failure/year

- combine redundancy and and modularity to achieve availability (e.g. use two terminals)
  - also, components should fail fast

- start w/ underreported 7.8 yr MTBF
- ignore 'infant mortality' and non-duplexed disc failures -> 11 yr MTBF


- "The top priority for improving system availability is to reduce administrative
mistakes by making self-configured systems with minimal maintenance and minimal
operator interaction"

The discussion on software updates is interesting, esp. compared to opinions on hardware. With hardware, Gray takes hard line: "One cannot forego hardware preventative maintenance... One must install hardware fixes in a timely fashion". With software, less hard: install a software fix "only if the bug is causing outages", otherwise, "wait for a major software release"

Fault tolerant software:
- static (compile time) checks insufficient
- use runtime techniques: modularise work into processes which do not share state and communicate via kernel mediated messages
- most software faults are 'soft': 'heisenbugs' rather than 'bohrbugs'. Restarting a process and then retrying on failure often succeeds
- can use redundant processes as well to bring down MTBF. Process-pairs work well, process-triples give you nothing extra because operator failure have orders of magnitudes worse MTBFs.
  - There are a variety of programming models put forward for process-pairs. Gray advocates writing applications to make use of transactions and then simply rerunning a transaction on failure.

## Extra notes, Schroeder, Gibson:

- observed disk failures indicate that disks get less reliable with time. This is in contrast to the widely accepted 'bathtub model' of failure which states that disks are least reliable when first put in service and after a period of 5-7 years of relatively reliable function.
