run("8-bit");
run("Subtract Background...", "rolling=80");
setAutoThreshold("Default dark");
//run("Threshold...");
setOption("BlackBackground", false);
run("Convert to Mask");
run("Analyze Particles...", "size=0.20-Infinity circularity=0.20-1.00 show=Outlines display clear summarize");
