# Test and production use cases

Use cases to discuss - how Globus Compute (GC) should communicate with the
harvester instance

## Current test setup

- Target machine: Perlmutter
  - `globus_wrapper`: get payload (from harvester queue), exec payload
  - GC endpoint: exec `globus_wrapper`

## Test setup to trigger GC from the outside

- Target machine: Perlmutter
  - `globus_wrapper`: get payload (from harvester queue), exec payload
  - GC endpoint: exec `globus_wrapper`

- Submitter machine: Polaris
  - Harvester submitter for GC*
    - Exec `Perlmutter:globus_wrapper` through GC

## Ultimate setup

- Target machine: Perlmutter
  - GC endpoint: exec payload

- Submitter machine (a.k.a. Harvester machine)
  - Harvester submitter for GC
    - get payload (from harvester queue)
    - submit payload (to GC endpoint)

---

(*) Example of SLURM submitter: https://github.com/HSF/harvester/blob/master/pandaharvester/harvestersubmitter/slurm_submitter.py

