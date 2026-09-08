package porting;

import net.fabricmc.api.ModInitializer;
import net.fabricmc.fabric.api.transfer.v1.storage.Storage;
import net.minecraft.world.level.Level;

/** Compile-time check only; never packaged as a mod. */
final class TargetApiProbe {
    Level level;
    ModInitializer initializer;
    Storage<?> storage;
}
