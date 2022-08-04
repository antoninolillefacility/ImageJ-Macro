"\\Clear";
run("Clear Results");
run("Colors...", "foreground=white background=white selection=green");
dir=getDirectory("Repertoire images ?");
files=getFileList(dir)

//setBatchMode(true);
t_nom_image=newArray(100000);
cells=newArray(1000000);
surface_cells=newArray(1000000);
granule=newArray(1000000);
granule2=newArray(1000000);
surface_granule=newArray(1000000);
surface_granule100=newArray(1000000);
total_surf=newArray(1000000);
ratio100=newArray(1000000);

for(num=0;num<files.length;num++)
{
"\\Clear";
filename = files[num];	
filepath=dir+filename;
run("Bio-Formats", "open=["+filepath+"] color_mode=Default view=[Hyperstack] stack_order=XYCZT series_3");
filename=File.name;
rename(filename);
if (roiManager("count")>0) 
{	
roiManager("Delete");
}
if (roiManager("count")>0) 
{	
roiManager("Delete");
}
t_nom_image[num]=File.name;
run("Set Measurements...", "area mean redirect=None decimal=6");
run("Properties...", "channels=3 slices=1 frames=1 unit=µm pixel_width=0.8800000 pixel_height=0.8800000 voxel_depth=1.0000000 global");
run("RGB Color");
rename("RGB");
selectWindow(filename);
close();
selectWindow("RGB");
rename(filename);
run("Colors...", "foreground=white background=white selection=green");
run("Line Width...", "line=10");
run("Clear Results");
selectWindow(filename);
run("Duplicate...", " ");
rename("global");
run("Duplicate...", " ");
rename("RGB");
run("Tile");
selectWindow("global");
run("8-bit");
//run("Find Edges");
selectWindow("global");
setAutoThreshold("Default");
setThreshold(1, 170);
run("Convert to Mask");
run("Fill Holes");
run("Options...", "iterations=5 count=1 black do=Dilate");
run("Close-");
run("Fill Holes");
//run("Analyze Particles...", "size=5000-Infinity add");
run("Analyze Particles...", "size=10000-Infinity add");
selectWindow("global");
close();



roi=roiManager("count");

if (roi>1)
{
array1 = newArray("0");; 
for (i=1;i<roi;i++)
{ 
        array1 = Array.concat(array1,i); 
        Array.print(array1); 
} 
roiManager("select", array1); 
roiManager("Combine");
roiManager("Add");
roiManager("Delete"); 
}



run("Clear Results");
selectWindow("RGB");
roiManager("Select", 0);
run("Measure");
total_surf[num]=getResult("Area",0);
run("Colors...", "foreground=green background=white selection=green");
run("Draw", "slice");
run("Clear Results");
selectWindow(filename);
roiManager("Select", 0);
run("Colors...", "foreground=white background=white selection=green");
run("Clear Outside");
if (roiManager("count")>0) 
{	
roiManager("Delete");
}
if (roiManager("count")>0) 
{	
roiManager("Delete");
}
rename("cells");
run("Select All");
run("Colour Deconvolution", "vectors=[User values] [r1]=0.54628474 [g1]=0.5926244 [b1]=0.59191996 [r2]=0.6322842 [g2]=0.5945282 [b2]=0.49674228 [r3]=0.40140206 [g3]=0.76537985 [b3]=0.5030607");
selectWindow("cells");
close();
selectWindow("cells-(Colour_1)");
close();
selectWindow("cells-(Colour_2)");
close();
selectWindow("Colour Deconvolution");
close();
selectWindow("cells-(Colour_3)");
rename("cells");
run("Duplicate...", " ");
rename("granule");
selectWindow("cells");
setAutoThreshold("Default");
setThreshold(0,123);
run("Convert to Mask");
run("Analyze Particles...", "size=8.01-100.00 circularity=0.6-1.00 add");
selectWindow("cells");
close();
run("Colors...", "foreground=blue background=white selection=blue");
run("Line Width...", "line=1");
cells[num]=roiManager("count");

if (cells[num]>0)
{
	for (i=0;i<cells[num];i++)
	{
		roiManager("Select", i);
		run("Measure");
		surface_cells[num]=surface_cells[num]+getResult("Area", 0);
		run("Clear Results");
		selectWindow("RGB");
		roiManager("Select", i);
		run("Draw", "slice");
	}

if (roiManager("count")>0) 
{	
roiManager("Delete");
}
if (roiManager("count")>0) 
{	
roiManager("Delete");
}
selectWindow("granule");
setAutoThreshold("Default");
setThreshold(0,180);
run("Convert to Mask");
//run("Fill Holes");
run("Analyze Particles...", "size=2-8 add");
granule[num]=roiManager("count");
run("Colors...", "foreground=red background=white selection=blue");
for (j=0;j<granule[num];j++)
	{
		roiManager("Select", j);
		run("Measure");
		surface_granule[num]=surface_granule[num]+getResult("Area", 0);
		run("Clear Results");
		selectWindow("RGB");
		roiManager("Select", j);
		run("Draw", "slice");
	
	}
	
if (roiManager("count")>0) 
{	
roiManager("Delete");
}
if (roiManager("count")>0) 
{	
roiManager("Delete");
}


selectWindow("granule");
run("Select All");
run("Analyze Particles...", "size=100.01-200 add");
granule2[num]=roiManager("count");
run("Colors...", "foreground=red background=white selection=blue");
for (k=0;k<granule2[num];k++)
	{
		roiManager("Select", k);
		run("Measure");
		surface_granule100[num]=surface_granule100[num]+getResult("Area", 0);
		run("Clear Results");
		selectWindow("RGB");
		roiManager("Select", k);
		run("Draw", "slice");
	}
ratio100[num]=(surface_granule100[num]*100)/total_surf[num];

print("***********************************************************");
print("label;"+t_nom_image[num]);
print("Nombre cellule;"+cells[num]);
print("surface_cells;"+surface_cells[num]);
print("Nombre granule [3-8];"+granule[num]);
print("Surface granule [3-8];"+surface_granule[num]);
print("Nombre granule > 100;"+granule2[num]);
print("Surface granule >100;"+surface_granule100[num]);
print("Surface biopsie um²;"+total_surf[num]);
print("ratio granule100/surface total um;"+ratio100[num]);



selectWindow("granule");
close();

}
else 
{
cells[num]=0;
granule[num]=0;
granule2[num]=0;
surface_cells[num]=0;
ratio100[num]=0;
surface_granule[num]=0
surface_granule100[num]=0;
}

selectWindow("RGB");
saveAs("JPEG", dir+File.separator+filename+"-RGB");
close();
if (roiManager("count")>0) 
{	
roiManager("Delete");
}
if (roiManager("count")>0) 
{	
roiManager("Delete");
}
}

	
for(num=0;num<files.length;num++)
{
setResult("Label",num,t_nom_image[num]);
setResult("Nombre cellule",num,cells[num]);
setResult("Surface cellule",num,surface_cells[num]);
setResult("Nombre granule [3-8]",num,granule[num]);
setResult("Surface granule [3-8]",num,surface_granule[num]);
setResult("Nombre granule > 100",num,granule2[num]);
setResult("Surface granule >100",num,surface_granule100[num]);
setResult("Surface biopsie um²",num,total_surf[num]);
setResult("Ratio granule100/surface totale um²",num,ratio100[num]);
}
	updateResults;

selectWindow("Results"); 
saveAs("Results",dir+"Results.xls");


