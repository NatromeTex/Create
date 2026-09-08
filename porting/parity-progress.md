# Changes adapted from Create 6.0.10

These changes are in the Fabric source and the 1.20.1 build passed. The new plough GameTest and the existing moving-plough test passed on 1.20.1. Broader parity validation and all 26.1.2 gameplay validation remain pending; these changes do not make the project compatible with 26.1.2 yet.

| Upstream commit | Adaptation | Validation required |
| --- | --- | --- |
| `6517d2672f09585f2a3434f5bf19c118c96994e8` | Plough whitelist/blacklist, snow whitelist, portals blacklist; retained 1.20.1 resource paths until the data-format migration | New rule test and existing moving-plough test passed on 1.20.1; custom datapack overrides and 26.1.2 still pending |
| `180b6c4b019fb483df8f926a5015383cdc051966` | Transfer passengers during assembly using `create:seats` | Assembly with vanilla Create seats and compatible tagged custom seats |
| `0a17a7243c3e5e6e3ceb34450d9c6df240af1b83` | Remove the 512-tick cap from mixer recipe processing | Custom long-duration recipe at multiple mixer speeds |
| `f3a90f1a32694359d3816176da90689e26e7bd32` | Use the 6.0.10 rotation-speed comparison tolerance, replacing the Fabric baseline's exact equality | Gear networks with floating-point ratios; no propagation loop or incorrect speed |

Only the plough-related changes from the plough commit were adapted; its unrelated generated food-tag changes still require review. The complete delta inventory remains in `upstream-delta.csv`, with entries left as `needs-review` until the full commit and its dependencies are reconciled.
