setBatchMode(false);
"\\Clear";
fs=File.separator;
pathFile=File.openDialog("Select LIF File to Process");
dirFiles=File.getDirectory(pathFile);
allFiles=getFileList(dirFiles);
print(allFiles.length);
File.makeDirectory(dirFiles+"Comptage");

Dialog.create("Channel to analyze ?");
Dialog.addChoice("Channel:", newArray("1", "2", "3"));
Dialog.addCheckbox("Crop", true);
Dialog.show();
type0=Dialog.getChoice();
crop=Dialog.getCheckbox();

if (roiManager("count")>0) 
{
roiManager("Delete");
}
if (roiManager("count")>0) 
{	
roiManager("Delete");
}

run("Set Measurements...", "area limit redirect=None decimal=3");

t_nom_image=newArray(10000000);
nameStore=newArray(10000000);
t_aire=newArray(10000000);
t_nbre=newArray(10000000);

for(f=0; f<allFiles.length; f++) 
{
if (endsWith(allFiles[f], ".lif"))
   fileName=allFiles[f];
   folderName=substring(fileName,0,lastIndexOf(fileName, "."));
   condName=folderName;
   dirPath= File.getParent(pathFile)+fs;
   savePath=dirPath + folderName + fs;
   run("Bio-Formats Macro Extensions");
   Ext.setId(dirFiles+fileName);
   Ext.getSeriesCount(seriesCount);
   sCount=seriesCount;

for(l=1;l<=sCount;l++)
{
   run("Bio-Formats Importer", "open=["+dirPath+fileName+"] autoscale color_mode=Default view=Hyperstack stack_order=XYCZT series_"+(l));
   nameStore[l]=getTitle();
   t_nom_image[l]=File.name;
   getDateAndTime(year, month, dayOfWeek, dayOfMonth, hour, minute, second, msec);
   print(hour+":"+minute+":"+second+" - Processing Series "+(l)+" of "+seriesCount);
   Stack.getDimensions(width, height, channels, slices, frames);
   if(crop==true)
   {
   	setTool("rectangle");
   	makeRectangle(0, 0, 7755, 7755);
   	waitForUser("Define region");
   	run("Crop");
   }
   run("Clear Results");
   if(type0=="1")
   {
   	Stack.setActiveChannels("100");
   	setSlice(1);
   }
    if(type0=="2")
   {
   	Stack.setActiveChannels("020");
   	setSlice(2);
   }
    if(type0=="3")
   {
   	Stack.setActiveChannels("001");
   	setSlice(3);
   }			
   	run("Duplicate...", " ");
	rename("analyze");
	run("Duplicate...", " ");
	rename("RGB");
	selectWindow("analyze");
	run("Median...", "radius=3");
	run("Threshold...");
	if(type0=="2")
   {
	setThreshold(158, 65535, "raw");
   }
   if(type0=="3")
   {
	setThreshold(130, 65535, "raw");
   }
	waitForUser("Set Threthold");
	run("Convert to Mask");
	run("Close-");
	run("Watershed");
	run("Analyze Particles...", "size=1-Infinity add");
	setAutoThreshold("Default dark");
	run("Measure");
	t_aire[l]=getResult("Area", 0);
	run("Clear Results");
   
t_nbre[l]=roiManager("count");
      
selectWindow("analyze"); 
close();
selectWindow("RGB"); 
run("RGB Color");
roiManager("Show All without labels");
if (roiManager("count")>0) 
{
run("From ROI Manager");
}

saveAs("JPEG", dirFiles+"Comptage"+File.separator+nameStore[l]);
close();
run("Close All");
if (roiManager("count")>0) 
{
roiManager("Delete");
}
if (roiManager("count")>0) 
{	
roiManager("Delete");
}
}
run("Clear Results");
}


for(l=0;l<=sCount;l++)
{
setResult("Label",l,nameStore[l]);
setResult("Nbre",l,t_nbre[l]);
setResult("Aire µm²",l,t_aire[l]);

}
	updateResults;
	
selectWindow("Results"); 
saveAs("Results",dirFiles+"Comptage"+File.separator+"Results per image.xls");

