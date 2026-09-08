# Minecraft 26.1.2 Fabric port

The implementation base is Fabricators of Create. The required feature baseline is upstream Create 6.0.10. This branch is work in progress and is not a playable 26.1.2 release.

`source-lock.json` records the exact source revisions inspected. The old 1.21.1 Fabric development branch dates to March 2025; it is a migration reference, not a replacement for the newer 6.0.8.1 Fabric baseline. Public CI run 19868316996 confirms that build 1744 used the pinned `4c3fe779d135d592548e4cb09da04d742d2637b7` source revision.

## Upstream parity

Run `scripts/porting/Export-UpstreamDelta.ps1` to regenerate `upstream-delta.csv`. It inventories non-merge commits from the 1.21.1 6.0.8 tag through 6.0.10. Review existing Fabric backports before applying each change. Inspect merge resolutions and the differences between the 1.20.1 and 1.21.1 lines separately; this CSV is not a complete parity verdict.

## Dependency findings

- Flywheel's `26.1.2/dev` branch still declares Minecraft 1.21.1, Java 21, and Architectury Loom 1.7.412. Its branch name does not establish 26.1.2 compatibility.
- Ponder's `mc26.1/dev` branch targets 26.1.2 but excludes configuration classes in its build convention. It expects `flywheel-fabric-26.1:1.0.6-beta`, which was not found at the official Maven metadata path during inspection.
- Porting Lib's latest inspected branch is 1.21.11. It still uses remapping-era build APIs and needs a source port.
- Registrate Fabric's latest relevant inspected branch targets 1.21.1 and uses older Porting Lib modules.

These are source/build findings, not runtime test results. Required functionality must be restored and tested before these libraries can be used in the final port.

## Baseline build

Use the repository's Gradle 9.1.0 wrapper, a compatible Gradle JVM, and a Java 17 compilation toolchain. The original Parchment Maven endpoint refused connections in this workspace. The optional property below selects the verified NeoForged mirror without changing mappings or gameplay:

```powershell
.\gradlew.bat build -PparchmentMavenUrl=https://maven.neoforged.net/releases -Dfabric.loom.ci=true
```

Loom's CI flag skips downloading/remapping dependency source JARs; all mod code is still compiled. This avoids a lengthy IDE-source preparation step on Windows. Omit it when setting up source navigation in an IDE. The target port requires Java 25 and the unobfuscated Fabric Loom plugin. Changing the version labels alone cannot port Create or its dependencies.

## Target toolchain check

`toolchain/` compiled successfully against Minecraft 26.1.2, Fabric Loader 0.19.5, and Fabric API 0.155.3+26.1.2 using Java 25, Gradle 9.5.1, and Loom 1.17.20. From `porting/toolchain`, run its own `gradlew.bat verifyTarget` wrapper with Java 25. Its JAR task is disabled: this checks classpath compatibility and does not produce a playable mod or verify game startup.

`parity-progress.md` records the first gameplay changes adapted from upstream and their validation status. The modified 1.20.1 build passed. The first complete GameTest report contains 61 tests, 59 passing and two failing (`TestFluids.thresholdSwitch`, `TestItems.attributeFilters`); the new plough test passed. Baseline comparison is in progress. These results do not establish 26.1.2 compatibility.
