# Minecraft 26.1.2 Fabric port

The implementation base is Fabricators of Create. The required feature baseline is upstream Create 6.0.10. This branch is work in progress and is not a playable 26.1.2 release.

`source-lock.json` records the exact source revisions inspected. The old 1.21.1 Fabric development branch dates to March 2025; it is a migration reference, not a replacement for the newer 6.0.8.1 Fabric baseline. The baseline's CI provenance still needs matching to the supplied build-1744 JAR.

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
.\gradlew.bat build -PparchmentMavenUrl=https://maven.neoforged.net/releases
```

The target port requires Java 25 and the unobfuscated Fabric Loom plugin. Changing the version labels alone cannot port Create or its dependencies.
