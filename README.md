Detection of changes from permanent grassland to arable land using
Sentinel 2 satellite data in R

The purpose of this project is to demonstrate the detection of changes
from permanent grassland to arable land using freely available satellite
data and freely available statistical software R. The main goal is to
demonstrate the proposed methodological procedure, which is part of the
research within the dissertation and scientific publication (insert
link).

The proposed procedure is demonstrated on freely available satellite
data from Sentinel 2 and vector data from LPISU (Land Parcel
Identification System). Detection of changes takes place in the form of
supervised classification. The research aim of the proposed method is
the detection of the best predictors using the internal metrics of the
Random Forest classifier, which are best suited for the detection of
changes from grassland to arable land. It is well known that the large
number of redudant predictors in Remote Sensing, whether spectral bands
or other derived predictors (such as shape and texture characteristics),
reduces the overall accuracy of change detection and increases the total
computational time.

The methodical process of selection of suitable predictors is
implemented in statistical software R and thus enables easy portability
and adaptation based on user needs.

Let's begin

All data used for demonstrators in this project can be freely downloaded
from the Internet. Data from Sentinel 2 satellites are freely available
after registration under the Copernicus project, managed by the European
Space Agency (ESA). Reference data in the form of soil blocks from the
LPISU are also freely available for the territory of the Czech Republic,
where the study site is located, which in this case serves as a
demonstration site.

Installation

RStudio was used as the development environment for R. The R software
itself used an improved version of Microft (Microsoft R Open), which
includes various improvements to speed up computations. Version 3.5.3
was used.

You must first install the necessary packages, provided they are not
installed in bulk:

\`\`\`

install.packages(c("randomForest", "rgdal", "raster", "caret"),
dependencies=T)

\`\`\`

This step is not necessary provided that the affected packages are
already installed. An alternative installation method is possible within
RStudia via the *Tools - Install Packages* menu.

![](media/image1.png){width="2.9791666666666665in"
height="3.2916666666666665in"}

![](media/image2.png){width="3.9479166666666665in"
height="2.9479166666666665in"}

Input Data and their structure

All input data can be found
[[here]{.underline}](https://onedrive.live.com/?authkey=%21AKuWuZbfAWKF5W0&id=99EE3B48EE58BC1D%21346&cid=99EE3B48EE58BC1D).
There are two separate directories in the folder - *Image Data* and
*Training Data*

![](media/image3.png){width="2.6956528871391074in"
height="1.6173917322834646in"}

The *Image Data* folder contains input satellite data already modified
for change classification purposes. These are soil blocks with average
values of the NDVI vegetation index in raster form forming a
multitemporal time series in the form of the monitored locality (see the
publication).

![](media/image4.png){width="6.295833333333333in" height="5.6in"}

The Training Data folder contains reference points that are intended for
training the Random Forest classifier used. It is a point layer in shp
format (shapefile) with the following attributes:

![](media/image5.png){width="1.9826093613298337in"
height="2.520699912510936in"}

It is necessary to mention that the name of the training shapefile must
remain \"roi.shp\", otherwise the script will not work properly. It is
necessary to keep the strict names of the above attribute fields,
including their exact order.

The entry point layer contains a total of 2000 reference points. The
*Classified* attribute column is the identifier of each subpoint. The
*Class* attribute column contains the numeric code of the classification
classes, which takes the values 1 and 2. The value 1 determines the
classification class of changes from permanent grassland to arable land,
the value 2 soil blocks for which no changes have taken place.

Launching the RF\_VI\_TS.R Script

First of all, it is necessary to mention that all comments and comments
in the script are marked with a \"\#\". Before the first run of the
script, it is advisable to first set the required number of iterations,
ie the number of repetitions, how many times the classification of
changes from permanent grassland to arable land should be performed.
This option is indicated by the variable,,*Počet\_iteraci*", which is
set to 30 in the basic settings. If it is desired to classify changes
more or less, here everything can be set according to the user\'s needs.

![](media/image6.png){width="5.408696412948381in"
height="3.1076443569553804in"}

Run RStudio and open the appropriate script - *RF\_VI\_TS.R*. Then use
the keyboard shortcut Ctrl + A to select all the code and run the script
by clicking the Run button. After successful start-up, a sequence of
dialog boxes will follow, where it will be necessary to enter the input
data. In the first case, you must enter the path to the working
directory. This is a folder in which all the results will be saved in
the final after the script is completed.

![](media/image7.png){width="1.8591010498687663in"
height="2.373914041994751in"}

The following is a selection of input data that are subject to
classification. This is nothing more than a multitemporal raster set of
the NDVI vegetation index from the Image Data folder.

![](media/image8.png){width="3.226087051618548in"
height="2.4240124671916012in"}

In the last step, it is necessary to search the directory with reference
points.![](media/image9.png){width="2.8662226596675415in"
height="3.6086953193350833in"}

If everything was entered correctly in the previous steps, the script
should run without further error messages and just wait for the
calculation to finish.

Implemented script functions and their description

In summary, the implemented script functions can be summarized in
individual points:

1)  The division of reference points into training and validation,
    including their export to the hard disk in shp format

2)  Optional number of classification iterations

3)  Change classification itself using the Random Forest algorithm

4)  Prediction of the model in the form of a categorical classification,
    according to the attribute column *Class* of the training data

5)  Prediction of the model in the form of probabilities of
    classification classes

6)  Export of the error matrix derived according to the metric \"Out of
    the Bag\" in .txt format to the hard drive

7)  Export of predictor relevance according to MDA (Mean Decrease
    Accuracy), MDG (Mean Decrease Gini) in .jpg format

8)  Export of numerical values of MDA and MDG in .csv format

9)  Implementation of standard accuracy evaluation (Congalton et
    al. 2008) - error matrix, overall, user and processing accuracy,
    export to hard disk in .txt format

10) Merging the categorical classification - all classification results
    for each iteration, which were exported to the hard disk in one
    raster in one raster

11) Time record in the form of the total calculation time - the result
    is exported to the hard drive in the form of a separate .txt file
    after the calculation

Add 1) The division of the original set of reference points into
training and validation occurs at each iteration with the appropriate
names \"*training\_points*\" and \"*validation\_points*\" of the output
shp file on the hard drive.

![](media/image10.png){width="6.2in" height="0.8661417322834646in"}

![](media/image11.png){width="6.219444444444444in"
height="0.8729166666666667in"}

Add 2) The optional option to set the total number of iterations has
been described above

Add 3) Classification of changes is implemented using the
\"*randomForest*\" function of the library of the same name

Add 4) The prediction of the model in the form of a categorical
classification includes the classical classification of land cover, in
this case the classification of changes from grassland to arable land.
The result is in raster form, containing integer values in .img format
(Erdas Imagine)

![](media/image12.png){width="6.208333333333333in"
height="0.4395833333333333in"}

Add 5) Prediction of the probability of classification classes is given
by the ability of the Random Forest algorithm, which determines the
probability of occurrence of a given class within a pixel or objects (or
other basic image units). The result is again in raster format .tif with
the appropriate name

![](media/image13.png){width="6.184722222222222in"
height="0.18472222222222223in"}

Add 6) Based on its internal structure, Random Forest contains the \"Out
of the Bag Error\" metric, which is able to determine the potential
accuracy of future classification - details can be found in the original
text of Breiman (2001). This metric is exported in a .txt file named
\"*cm\_OOB.txt*\" and always at the end with the appropriate number of
the iteration

![](media/image14.png){width="6.219444444444444in"
height="0.2604166666666667in"}

Add 7) The script offers the export of a simple graph for easy
evaluation and visualization of the most important predictors within a
partial iteration for both MDA and MDG metrics. A graph with a raster
file in the .jpeg format has the name \"*predictors* \", where at the
end of its name is always the number of a specific iteration

![](media/image15.png){width="6.196527777777778in"
height="0.21944444444444444in"}

Add 8) The numeric values of both MDA and MDG metrics can be found in a
file named \"*variable\_importance*\" in .csv format, where a number
indicating the appropriate iteration is present at the end of the name.

![](media/image16.png){width="6.2in" height="0.2in"}

Add 9) This is an export of a standard error matrix and its basic
metrics (overall, user and processing accuracy). The implemented
Accuracy Assessment procedure is according to the methodologies of
Congalton (1991) and Congalton and Green (2008). The complete error
matrix is stored in a file named \"*confusion\_matrix*\" with the
appropriate iteration number. The corresponding metrics are also stored
in the appropriate file names in .txt format for each iteration
separately

![](media/image17.png){width="6.115277777777778in"
height="0.21944444444444444in"}

User's accuracy is located in the file called ,,*User's accuracy\_RF"*

![](media/image18.png){width="6.134027777777778in"
height="0.2534722222222222in"}

Producer's accuracy is located in the file called *,,Producer's
accuracy" *

![](media/image19.png){width="6.201388888888889in"
height="0.2611111111111111in"}

Add 10) All outputs of categorical classifications for each iteration
(land cover classification) are combined into one raster file at the end
of the calculation. This function was implemented due to the potential
implementation of post-classification adjustments - for example, the
application of a median filter. File with the appropriate name
\"*RandomForest\_stacked.img*\"

![](media/image20.png){width="6.2in" height="0.5in"}

Add 11) A text file named \"*Overall\_Time.txt*\" provides information
about the total calculation time

![](media/image21.png){width="6.238888888888889in" height="0.26875in"}

Launching Script VI\_PLOT\_TOOL.R

The script calculates the average MDA and displays it in a clear graph
according to the importance of individual predictors.

To run this script, you must first install the ggplot 2 library,
provided it has not been installed before:

\`\`\`

install.packages("ggplot2", dependencies=T)

\`\`\`

Before running the script for the first time, you must first copy to a
separate directory all the \"variable\_importance\" files that were
obtained by running the \"*RF\_VI\_TS.R*\" script, depending on the
number of iterations required.

![](media/image16.png){width="6.2in" height="0.2in"}

The script is launched in the same way as described above in the section
\"*Running the Script* *RF\_VI\_TS.R*\". After successful startup, you
will be prompted to enter the path to the working directory. This is
nothing more than the folder to which the \"*variable importance*\"
files were copied in the previous step.

![](media/image22.png){width="1.840097331583552in"
height="2.5671642607174103in"}

After successful completion of the calculation, a file named
\"*RF\_MDA\_GGPLOT.png*\" will appear in the selected folder.

![](media/image23.png){width="6.184722222222222in"
height="0.2604166666666667in"}

The resulting graph shows the relevance of the individual predictors
that were the subject of the classification:

![Obsah obrázku snímek obrazovky, pták Popis byl vytvořen
automaticky](media/image24.png){width="4.005780839895013in"
height="2.861271872265967in"}

Contacts

Contact:
[[sanderajiri\@outlook.com]{.underline}](mailto:sanderajiri@outlook.com)

Project Link:
[[https://github.com/Iricek/Remote-Sensing-in-R]{.underline}](https://github.com/Iricek/Remote-Sensing-in-R)

References

Breiman, L. (2001). Random forests. *Machine learning*, *45*(1), 5-32.

Congalton, R. G. (1991). A review of assessing the accuracy of
classifications of remotely sensed data. *Remote sensing of
environment*, *37*(1), 35-46.

Congalton, R. G., & Green, K. (2008). *Assessing the accuracy of
remotely sensed data: principles and practices*. CRC press
