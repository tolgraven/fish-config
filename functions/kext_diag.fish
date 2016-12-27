function kext_diag
	kextfind /System/Library/Extensions \( -nonloadable \) -print -pp CFBundleIdentifier -print-diagnostics
end
