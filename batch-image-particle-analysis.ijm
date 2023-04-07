dir1 = getDirectory("Choose Source Directory ");
format = getFormat();
dir2 = getDirectory("Choose Destination Directory ");
list = getFileList(dir1);
setBatchMode(true);
for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
 	open(dir1+list[i]);
	run("Set Scale...", "distance=1024 known=125 unit=µm");
 	run("8-bit");
	run("Subtract Background...", "rolling=80");
	setAutoThreshold("Default dark");
	//run("Threshold...");
	//setThreshold(160, 183);
	setOption("BlackBackground", false);
	run("Convert to Mask");
	run("Analyze Particles...", "size=0.20-Infinity circularity=0.20-1.00 show=Outlines display clear summarize");
    	selectWindow("Results");
	saveAs("Results", dir2+list[i] + "_result.csv" );

 	if (format=="8-bit TIFF" || format=="GIF")
 	convertTo8Bit();
 	saveAs(format, dir2+list[i]);
	close();
}

function getFormat() {
 formats = newArray("TIFF", "8-bit TIFF", "JPEG", "GIF", "PNG",
 "PGM", "BMP", "FITS", "Text Image", "ZIP", "Raw");
 Dialog.create("Batch Convert");
 Dialog.addChoice("Convert to: ", formats, "TIFF");
 Dialog.show();
 return Dialog.getChoice();
}

function convertTo8Bit() {
 if (bitDepth==24)
 run("8-bit Color", "number=256");
 else
 run("8-bit");
}
