# Remote-Sensing-in-R

The purpose of this project is to demonstrate the detection of changes from permanent grassland to arable land using freely available satellite data and freely available statistical software R. The main goal is to demonstrate the proposed methodological procedure, which is part of the research within the dissertation and scientific publication (insert link).
The proposed procedure is demonstrated on freely available satellite data from Sentinel 2 and vector data from LPISU (Land Parcel Identification System). Detection of changes takes place in the form of supervised classification. The research aim of the proposed method is the detection of the best predictors using the internal metrics of the Random Forest classifier, which are best suited for the detection of changes from grassland to arable land. It is well known that the large number of redudant predictors in Remote Sensing, whether spectral bands or other derived predictors (such as shape and texture characteristics), reduces the overall accuracy of change detection and increases the total computational time.
The methodical process of selection of suitable predictors is implemented in statistical software R and thus enables easy portability and adaptation based on user needs.
