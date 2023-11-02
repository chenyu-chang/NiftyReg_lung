# Feature-based NiftyReg

By utilizing lung masks, airway masks, and vesselness masks, we apply distance transforms to the lungs and airways to create gradient-enhanced mask boundaries. Ultimately, we employ the distance-transformed lung mask, the distance-transformed airway mask, and the vesselness mask for the purpose of registration.

# Folder Structure
- data
  - case1
    - 20110224
      - dicom
      - mask
    - 20110526
      - dicom
      - mask
  - case2
    - 20110525
      - dicom
      - mask
    - 20110926
      - dicom
      - mask

##  Flow Chart

```mermaid
graph LR

A[lung segmentation tool] -- "lungs.mat" --> B[main_feature.m]
A[lung segmentation tool] -- "lung_surface.mat" --> B[main_feature.m]
A[lung segmentation tool] -- "airways.mat" --> B[main_feature.m]
A[lung segmentation tool] -- "vessel.mat" --> B[main_feature.m]
B --> C[main_niftyreg.m]
```
## Feature Demo

 1. masked lungs mask distance tranceform

![masked lung mask distance tranceform](https://github.com/chenyu-chang/NiftyReg_lung/blob/main/image/dt_lung.png)

2. masked airways mask distance tranceform

![masked airways distance tranceform](https://github.com/chenyu-chang/NiftyReg_lung/blob/main/image/dt_airway.png)

3. 4D feature

![enter image description here](https://github.com/chenyu-chang/NiftyReg_lung/blob/main/image/4D_feature.png)

## Reference
[1] A. Stavropoulou et al., “A multichannel feature-based approach for longitudinal lung CT registration in the presence of radiation induced lung damage,” Physics in Medicine &amp;amp; Biology, vol. 66, no. 17, p. 175020, 2021. doi:10.1088/1361-6560/ac1b1d 