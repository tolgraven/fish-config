function kext_diag -d "kext diagnostics"
kextfind /System/Library/Extensions \( -nonloadable \) -print -pp CFBundleIdentifier -print-diagnostics
end
