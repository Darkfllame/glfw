const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "xcode-frameworks",
        .root_source_file = b.addWriteFiles().add("empty.zig", ""),
        .target = target,
        .optimize = optimize,
    });
    addPaths(b, lib.root_module); // just for testing
    lib.installHeadersDirectory(b.path("include"), ".", .{});
    b.installArtifact(lib);
}

pub fn addPaths(xf: *std.Build, mod: *std.Build.Module) void {
    mod.addSystemFrameworkPath(xf.path("Frameworks/"));
    mod.addSystemIncludePath(xf.path("include/"));
    mod.addLibraryPath(xf.path("lib/"));
}
