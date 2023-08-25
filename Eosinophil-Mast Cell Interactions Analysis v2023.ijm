Dialog.create("Type");

Dialog.addChoice("Type:", newArray("Interstitial diffuse inflitrates", "Granulomatoid nodules", "Dense diffuse Infitrates"));
Dialog.show();

type0=Dialog.getChoice();

if(type0=="Interstitial diffuse inflitrates")
{
	
"\\Clear";
dir=getDirectory("Repertoire images ?");
files=getFileList(dir);
File.makeDirectory(dir+"RESULTATS");

run("Colors...", "foreground=green background=white selection=green");
run("Set Measurements...", "area center limit redirect=None decimal=3");
run("Line Width...", "line=1");


name=newArray(1000);
nbre_bleu=newArray(1000);
nbre_marron=newArray(1000);
nbre_rose=newArray(1000);



for(num=0;num<files.length;num++)
{


if (indexOf(files[num],".tif")>0)
{


if (roiManager("count")>0) 
{	
roiManager("Delete");
}
if (roiManager("count")>0) 
{	
roiManager("Delete");
}
run("Clear Results");

open(dir+files[num]);
filename=File.name;
name[num]=File.name;

run("Properties...", "channels=1 slices=1 frames=1 pixel_width=0.2200000 pixel_height=0.2200000 voxel_depth=1.0000000");

run("Duplicate...", "title=RGB");
run("Properties...", "channels=1 slices=1 frames=1 pixel_width=0.2200000 pixel_height=0.2200000 voxel_depth=1.0000000 global");
selectWindow(filename);
print("************************************************************");
print(filename);
rename("image");
run("Colour Deconvolution", "vectors=[User values] [r1]=0.690755 [g1]=0.5670558 [b1]=0.44867048 [r2]=0.3986399 [g2]=0.61066055 [b2]=0.68423676 [r3]=0.29862659 [g3]=0.7763817 [b3]=0.5548643");
selectWindow("Colour Deconvolution");
close();
selectWindow("image-(Colour_1)");
rename("blue");
selectWindow("image-(Colour_2)");
rename("marron");
selectWindow("image-(Colour_3)");
rename("rose");

//Noyau bleu
selectWindow("blue");
run("Colors...", "foreground=blue background=white selection=blue");
run("Properties...", "channels=1 slices=1 frames=1 pixel_width=0.2200000 pixel_height=0.2200000 voxel_depth=1");
run("8-bit");
run("Gaussian Blur...", "sigma=2");
setThreshold(0, 135);
run("Convert to Mask");
run("Watershed");
run("Analyze Particles...", "size=5-Infinity add");
nbre_bleu[num]=roiManager("count");


for(i=0;i<nbre_bleu[num];i++)
{
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
selectWindow("blue");
close();




//cellules marrons
selectWindow("marron");
run("Colors...", "foreground=yellow background=white selection=yellow");
run("Properties...", "channels=1 slices=1 frames=1 pixel_width=0.2200000 pixel_height=0.2200000 voxel_depth=1");
run("8-bit");
run("Gaussian Blur...", "sigma=2");
setThreshold(0, 135);
run("Convert to Mask");
run("Watershed");
run("Analyze Particles...", "size=5-Infinity add");
nbre_marron[num]=roiManager("count");

print("Surface ckit************");
for(i=0;i<nbre_marron[num];i++)
{
	run("Clear Results");
	selectWindow("RGB");
	roiManager("Select", i);
	run("Measure");
	area_marron=getResult("Area", 0);
	print(area_marron);
	run("Draw", "slice");
	run("Clear Results");
}


if (roiManager("count")>0) 
{	
roiManager("Delete");
}
if (roiManager("count")>0) 
{	
roiManager("Delete");
}	
selectWindow("marron");
close();



//cellules roses
selectWindow("rose");
run("Colors...", "foreground=magenta background=white selection=magenta");
run("Properties...", "channels=1 slices=1 frames=1 pixel_width=0.2200000 pixel_height=0.2200000 voxel_depth=1");
run("8-bit");
run("Gaussian Blur...", "sigma=2");
setThreshold(0, 135);
run("Convert to Mask");
run("Watershed");
run("Analyze Particles...", "size=5-Infinity add");
nbre_rose[num]=roiManager("count");

print("Surface EPX************");
for(i=0;i<nbre_rose[num];i++)
{
	run("Clear Results");
	selectWindow("RGB");
	roiManager("Select", i);
	run("Measure");
	area_rose=getResult("Area", 0);
	print(area_rose);
	run("Draw", "slice");
	run("Clear Results");
}


if (roiManager("count")>0) 
{	
roiManager("Delete");
}
if (roiManager("count")>0) 
{	
roiManager("Delete");
}	
selectWindow("rose");
close();





selectWindow("RGB");
saveAs("JPEG", dir+"RESULTATS"+File.separator+filename);
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
}


for(num=0;num<files.length;num++)
{
				setResult("Label",num,name[num]);
				setResult("Nombre de cellule total",num,nbre_bleu[num]);
				setResult("Nombre ckit",num,nbre_marron[num]);
				setResult("Nombre EPX",num,nbre_rose[num]);
}
					updateResults;
					
				selectWindow("Results"); 
				saveAs("Results",dir+"RESULTATS"+File.separator+"Resultats par image.xls");
				selectWindow("Log");
				saveAs("txt",dir+"RESULTATS"+File.separator+"Results par cellule.txt");
		

}

if(type0=="Granulomatoid nodules")
{
dir=getDirectory("Repertoire images ?");
files=getFileList(dir);
File.makeDirectory(dir+"RINGS");
File.makeDirectory(dir+"RESULTATS");

run("Colors...", "foreground=green background=white selection=green");
run("Set Measurements...", "area center limit redirect=None decimal=3");
run("Line Width...", "line=20");


name0=newArray(1000);
area_nodule=newArray(1000);
surface_cells_rose_nodule=newArray(1000);
nbre_cells_rose_nodule=newArray(1000);


for(num=0;num<files.length;num++)
{


if (indexOf(files[num],".tif")>0)
{


if (roiManager("count")>0) 
{	
roiManager("Delete");
}
if (roiManager("count")>0) 
{	
roiManager("Delete");
}
run("Clear Results");
"\\Clear";
open(dir+files[num]);
filename=File.name;
name0[num]=File.name;

run("Properties...", "channels=1 slices=1 frames=1 pixel_width=0.2200000 pixel_height=0.2200000 voxel_depth=1.0000000");
default1 = "10";
default2 = "20";
default3 = "100";
Dialog.create("Ring value ?");
Dialog.addNumber("Start value µm:", default1);
Dialog.addNumber("Ring diameter µm:", default2);
Dialog.addNumber("Max. distance to center µm:", default3);
Dialog.show();
start = Dialog.getNumber();
ring = Dialog.getNumber();
max = Dialog.getNumber();

nbre_ring=floor((max-start)/ring);
print(nbre_ring);

run("Clear Results");
run("Duplicate...", "title=RGB");
run("Duplicate...", "title=analyse");
run("Duplicate...", "title=nodule");
selectWindow(filename);
run("Colour Deconvolution", "vectors=[User values] [r1]=0.74031687 [g1]=0.5755547 [b1]=0.3473726 [r2]=0.3986399 [g2]=0.61066055 [b2]=0.68423676 [r3]=0.29862659 [g3]=0.7763817 [b3]=0.5548643");
selectWindow("Colour Deconvolution");
close();
selectWindow(filename+"-(Colour_1)");
close();
selectWindow(filename+"-(Colour_3)");
close();

selectWindow(filename+"-(Colour_2)");
run("Properties...", "channels=1 slices=1 frames=1 pixel_width=0.2200000 pixel_height=0.2200000 voxel_depth=1");
run("8-bit");
setAutoThreshold("Default");
setOption("BlackBackground", false);
run("Convert to Mask");
run("Fill Holes");
run("Options...", "iterations=10 count=1 do=Erode");
run("Options...", "iterations=10 count=1 do=Dilate");
run("Analyze Particles...", "size=10000-Infinity add");
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

selectWindow(filename);
close();
selectWindow(filename+"-(Colour_2)");
close();



if (roiManager("count")>0) 
{
	

ring1=start+ring;

for (j=1;j<=nbre_ring;j++)
{
roiManager("Show None");
//1ere bande
selectWindow("analyse");
run("Select All");
run("Duplicate...", " ");
rename(ring1+"µm");
selectWindow("analyse");
roiManager("Select", 0);
run("Enlarge...", "enlarge="+ring+"");
roiManager("Add");
roiManager("Select", 0);
run("Make Band...", "band="+ring+"");
roiManager("Add");

selectWindow(ring1+"µm");
roiManager("Select", 2);
	
run("Clear Outside");
saveAs("tif", dir+"RINGS"+File.separator+filename+"-"+ring1+"µm");
close();

roiManager("Select", 0);
roiManager("Delete");
roiManager("Select", 1);
roiManager("Delete");

ring1=ring1+ring;
}


selectWindow("analyse");
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
else 
{
selectWindow("analyse");
close();
selectWindow("RGB");
close();	
}

//Analyse du nodule
run("Clear Results");
selectWindow("nodule");
run("Colour Deconvolution", "vectors=[User values] [r1]=0.74031687 [g1]=0.5755547 [b1]=0.3473726 [r2]=0.3986399 [g2]=0.61066055 [b2]=0.68423676 [r3]=0.29862659 [g3]=0.7763817 [b3]=0.5548643");
selectWindow("Colour Deconvolution");
close();
selectWindow("nodule-(Colour_1)");
close();



selectWindow("nodule-(Colour_2)");
run("Properties...", "channels=1 slices=1 frames=1 pixel_width=0.2200000 pixel_height=0.2200000 voxel_depth=1.0000000");
run("8-bit");
setAutoThreshold("Default");
setOption("BlackBackground", false);
run("Convert to Mask");
run("Fill Holes");
run("Options...", "iterations=5 count=1 do=Erode");
run("Options...", "iterations=15 count=1 do=Dilate");
run("Analyze Particles...", "size=10000-Infinity add");
selectWindow("nodule-(Colour_2)");
close();


run("Line Width...", "line=6");
selectWindow("RGB");
roiManager("Select", 0);
run("Colors...", "foreground=red background=white selection=red");
run("Draw", "slice");


run("Colors...", "foreground=magenta background=white selection=magenta");
run("Line Width...", "line=1");
selectWindow("nodule-(Colour_3)");
run("Properties...", "channels=1 slices=1 frames=1 pixel_width=0.2200000 pixel_height=0.2200000 voxel_depth=1.0000000");
run("Median...", "radius=4");
roiManager("Select", 0);
run("Measure");
area_nodule[num]=getResult("Area", 0);
run("Clear Results");
run("Clear Outside");

if (roiManager("count")>0) 
{	
roiManager("Delete");
}
if (roiManager("count")>0) 
{	
roiManager("Delete");
}

setThreshold(0, 130);
run("Convert to Mask");
run("Analyze Particles...", "size=10-Infinity show=Masks add");
nbre_cells_rose_nodule[num]=roiManager("count");
selectWindow("Mask of nodule-(Colour_3)");
setAutoThreshold("Default");
run("Measure");
surface_cells_rose_nodule[num]=getResult("Area", 0);
run("Clear Results");


selectWindow("Mask of nodule-(Colour_3)");
close();
selectWindow("nodule");
close();
roiManager("Show All without labels");
selectWindow("RGB");
run("From ROI Manager");
saveAs("JPEG", dir+"RESULTATS"+File.separator+filename);
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
}


for(num=0;num<files.length;num++)
				{
				setResult("Label",num,name0[num]);
				setResult("Surface nodule",num,area_nodule[num]);
				setResult("Nombre EPX dans nodule",num,nbre_cells_rose_nodule[num]);
				setResult("Surface EPX dans nodule",num,surface_cells_rose_nodule[num]);
				}
					updateResults;
					
				selectWindow("Results"); 
				saveAs("Results",dir+"RESULTATS"+File.separator+"Resultats par nodule.xls");


name=newArray(1000);
surface=newArray(1000);
surface_cells_marron=newArray(1000);
surface_cells_rose=newArray(1000);
R_marron=newArray(1000);
R_rose=newArray(1000);

//2ème boucle RINGS
dir2=dir+File.separator+"RINGS"+File.separator;
files2=getFileList(dir2);
run("Line Width...", "line=1");
for(num2=0;num2<files2.length;num2++)
{
if (indexOf(files2[num2],".tif")>0)
{

if (roiManager("count")>0) 
{
roiManager("Delete");
}
if (roiManager("count")>0) 
{	
roiManager("Delete");
}	
run("Clear Results");


open(dir2+files2[num2]);
name[num2]=File.name;
run("Measure");
surface[num2]=getResult("Area", 0);
run("Clear Results");
run("Select All");
run("Duplicate...", "title=RGB");
selectWindow(name[num2]);
run("Colour Deconvolution", "vectors=[User values] [r1]=0.74031687 [g1]=0.5755547 [b1]=0.3473726 [r2]=0.3986399 [g2]=0.61066055 [b2]=0.68423676 [r3]=0.29862659 [g3]=0.7763817 [b3]=0.5548643");
selectWindow("Colour Deconvolution");
close();
selectWindow(name[num2]+"-(Colour_1)");
close();

//Cellules marrons
selectWindow(name[num2]+"-(Colour_2)");
run("Median...", "radius=5");
setThreshold(0, 152);
run("Convert to Mask");
run("Analyze Particles...", "size=50-infinity show=Nothing add");
roi=roiManager("count");
run("Colors...", "foreground=yellow background=white selection=yellow");
for (i=0;i<roi;i++)
{
	run("Clear Results");
	selectWindow("RGB");
	roiManager("Select", i);
	run("Draw", "slice");
	run("Measure");
	surface_cells_marron[num2]=surface_cells_marron[num2]+getResult("Area", 0);
	run("Clear Results");
}


selectWindow(name[num2]+"-(Colour_2)");
close();

if (roiManager("count")>0) 
{	
roiManager("Delete");
}
if (roiManager("count")>0) 
{	
roiManager("Delete");
}



//Cellules roses
selectWindow(name[num2]+"-(Colour_3)");
run("Median...", "radius=2");
setThreshold(0, 130);
run("Convert to Mask");
run("Analyze Particles...", "size=10-infinity show=Nothing add");
roi=roiManager("count");
run("Colors...", "foreground=magenta background=white selection=magenta");
for (i=0;i<roi;i++)
{
	run("Clear Results");
	selectWindow("RGB");
	roiManager("Select", i);
	run("Draw", "slice");
	run("Measure");
	surface_cells_rose[num2]=surface_cells_rose[num2]+getResult("Area", 0);
	run("Clear Results");
}


selectWindow(name[num2]+"-(Colour_3)");
close();

if (roiManager("count")>0) 
{	
roiManager("Delete");
}
if (roiManager("count")>0) 
{	
roiManager("Delete");
}
R_marron[num2]=surface_cells_marron[num2]/surface[num2];
R_rose[num2]=surface_cells_rose[num2]/surface[num2];
selectWindow(name[num2]);
close();
selectWindow("RGB");
saveAs("JPEG", dir+"RESULTATS"+File.separator+name[num2]+"-RGB");
close();
run("Close All");
}
}

for(num2=0;num2<files2.length;num2++)
				{
				setResult("Label",num2,name[num2]);
				setResult("Surface ring",num2,surface[num2]);
				setResult("Surface ckit",num2,surface_cells_marron[num2]);
				setResult("Surface EPX",num2,surface_cells_rose[num2]);
				setResult("Ratio ckit",num2,R_marron[num2]);
				setResult("Ratio EPX",num2,R_rose[num2]);
				}
					updateResults;
					
				selectWindow("Results"); 
				saveAs("Results",dir+"RESULTATS"+File.separator+"Resultats par anneaux.xls");	
}


if(type0=="Dense diffuse Infitrates")
{
"\\Clear";
dir=getDirectory("Repertoire images ?");
files=getFileList(dir);
File.makeDirectory(dir+"RESULTATS");

run("Colors...", "foreground=green background=white selection=green");
run("Set Measurements...", "area limit redirect=None decimal=3");
run("Line Width...", "line=1");


name=newArray(1000);
surface_image=newArray(1000);
surface_marron=newArray(1000);
surface_rose=newArray(1000);
ratio_marron=newArray(1000);
ratio_rose=newArray(1000);
nbre_rose=newArray(1000);
ratio_nbre_EPX=newArray(1000);

for(num=0;num<files.length;num++)
{


if (indexOf(files[num],".tif")>0)
{


if (roiManager("count")>0) 
{	
roiManager("Delete");
}
if (roiManager("count")>0) 
{	
roiManager("Delete");
}
run("Clear Results");

open(dir+files[num]);
filename=File.name;
name[num]=File.name;

run("Properties...", "channels=1 slices=1 frames=1 pixel_width=0.22 pixel_height=0.22 voxel_depth=1");
run("Select All");
run("Measure");
surface_image[num]=getResult("Area", 0)/1000000;
run("Clear Results");
run("Duplicate...", "title=RGB");
run("Properties...", "channels=1 slices=1 frames=1 pixel_width=0.22 pixel_height=0.22 voxel_depth=1");
selectWindow(filename);
rename("image");
run("Colour Deconvolution", "vectors=[User values] [r1]=0.690755 [g1]=0.5670558 [b1]=0.44867048 [r2]=0.3986399 [g2]=0.61066055 [b2]=0.68423676 [r3]=0.29862659 [g3]=0.7763817 [b3]=0.5548643");
selectWindow("Colour Deconvolution");
close();
selectWindow("image-(Colour_1)");
close();
selectWindow("image-(Colour_2)");
rename("marron");
selectWindow("image-(Colour_3)");
rename("rose");



//cellules marrons
selectWindow("marron");
run("Properties...", "channels=1 slices=1 frames=1 pixel_width=0.22 pixel_height=0.22 voxel_depth=1");
run("Colors...", "foreground=yellow background=white selection=yellow");
run("Properties...", "channels=1 slices=1 frames=1 pixel_width=0.2200000 pixel_height=0.2200000 voxel_depth=1");
run("8-bit");
run("Gaussian Blur...", "sigma=2");
run("Clear Results");
setThreshold(0, 135);
run("Measure");
surface_marron[num]=getResult("Area", 0)/1000000;
run("Clear Results");
run("Convert to Mask");
run("Analyze Particles...", "size=5-Infinity add");
roi=roiManager("count");


for(i=0;i<roi;i++)
{
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
selectWindow("marron");
close();



//cellules marrons
selectWindow("rose");
run("Properties...", "channels=1 slices=1 frames=1 pixel_width=0.22 pixel_height=0.22 voxel_depth=1");
run("Colors...", "foreground=magenta background=white selection=magenta");
run("Properties...", "channels=1 slices=1 frames=1 pixel_width=0.2200000 pixel_height=0.2200000 voxel_depth=1");
run("8-bit");
run("Gaussian Blur...", "sigma=2");
run("Clear Results");
setThreshold(0, 135);
run("Measure");
surface_rose[num]=getResult("Area", 0)/1000000;
run("Clear Results");
run("Convert to Mask");
run("Analyze Particles...", "size=5-Infinity add");
nbre_rose[num]=roiManager("count");


for(i=0;i<nbre_rose[num];i++)
{
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
selectWindow("rose");
close();

ratio_marron[num]=surface_marron[num]/surface_image[num];
ratio_rose[num]=surface_rose[num]/surface_image[num];
ratio_nbre_EPX[num]=nbre_rose[num]/surface_image[num];

selectWindow("RGB");
saveAs("JPEG", dir+"RESULTATS"+File.separator+filename);
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
}


for(num=0;num<files.length;num++)
{
				setResult("Label",num,name[num]);
				setResult("Ratio surface ckit",num,ratio_marron[num]);
				setResult("Ratio surface EPX",num,ratio_rose[num]);
				setResult("Nombre EPX",num,nbre_rose[num]);
				setResult("EPX par mm²",num,ratio_nbre_EPX[num]);

}
					updateResults;
					
				selectWindow("Results"); 
				saveAs("Results",dir+"RESULTATS"+File.separator+"Resultats par image.xls");
		
}
