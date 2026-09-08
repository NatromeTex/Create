plugins {
    id("net.fabricmc.fabric-loom") version "1.17.20"
}

repositories {
    mavenCentral()
}

dependencies {
    minecraft("com.mojang:minecraft:26.1.2")
    implementation("net.fabricmc:fabric-loader:0.19.5")
    implementation("net.fabricmc.fabric-api:fabric-api:0.155.3+26.1.2")
}

java {
    toolchain.languageVersion = JavaLanguageVersion.of(25)
}

// This verifies the target classpath; it is not a Create mod or a deliverable.
tasks.jar {
    enabled = false
}

tasks.register("verifyTarget") {
    group = "verification"
    description = "Compile against official Minecraft 26.1.2 and Fabric APIs."
    dependsOn(tasks.compileJava)
}
