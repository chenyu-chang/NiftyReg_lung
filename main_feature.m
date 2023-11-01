clc,clear
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% folder sturcure:
% ├─case1
% │  ├─20110224
% │  │  ├─dicom
% │  │  └─mask
% │  └─20110526
% │      ├─dicom
% │      └─mask
% └─case2
%     ├─20110525
%     │  ├─dicom
%     │  └─mask
%     └─20110926
%         ├─dicom
%         └─mask
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% path variable
ref_dicom_path = 'D:\lung-paper\lung_reg\data\case1\20110224\dicom';
flo_dicom_path = 'D:\lung-paper\lung_reg\data\case1\20110526\dicom';
ref_mask_path = 'D:\lung-paper\lung_reg\data\case1\20110224\mask';
flo_mask_path = 'D:\lung-paper\lung_reg\data\case1\20110526\mask';
save_path = 'D:\lung-paper\lung_reg\data\case1';

dicom_path = struct;
dicom_path.ref = ref_dicom_path;
dicom_path.flo = flo_dicom_path;
mask_path = struct;
mask_path.ref = ref_mask_path;
mask_path.flo = flo_mask_path;

for status=["ref", "flo"]
fprintf("%s...\n", status);
%% stack 2d dicom image to 3d array
dicom_list = dir(fullfile(dicom_path.(status), "*.dcm"));
img2D = dicomread(fullfile(dicom_list(1).folder, dicom_list(1).name));
img3D = zeros([size(img2D), length(dicom_list)], 'double');

for i = 1 : length(dicom_list)
    img3D(:, :, i) = double(dicomread([dicom_list(i).folder, '\', dicom_list(i).name]));
end

%% lung distance transform
mask_lungs_path = fullfile(mask_path.(status), "lungs.mat");
mask_lungs = load(mask_lungs_path);
mask_lungs = double(mask_lungs.image);
mask_lungs(mask_lungs > 0) = 1;

mask_lung_surface_path = fullfile(mask_path.(status), "lung_surface.mat");
surface_lungs = load(mask_lung_surface_path);
surface_lungs = double(surface_lungs.image);   
dt_lungs = masked_distance_transform(mask_lungs, surface_lungs);

load("custom_colormap.mat")
figure, mesh(dt_lungs(:,:,80))
colormap (custom_colormap);
overlayVolume(img3D, dt_lungs)
keyboard
%% airways mask distance transform
mask_airways_path = fullfile(mask_path.(status), "airways.mat");
mask_airways = load(mask_airways_path);
mask_airways = double(mask_airways.image);
mask_airways(mask_airways == 3) = 0;
surface_airways = edge3(mask_airways,'approxcanny',0.5);
dt_airways = masked_distance_transform(mask_airways, surface_airways);

figure, mesh(dt_airways(:,:,50))
colormap (custom_colormap);
overlayVolume(img3D, dt_airways)
keyboard

%% vessel segment to binary mask
vessel_path = fullfile(mask_path.(status), "vessel.mat");
vessel = load(vessel_path);
vessel = double(vessel.image);
vessel(vessel > 0) = 1;
overlayVolume(img3D, vessel)
keyboard

%% save all feature and image
feature = cat(4, dt_lungs, dt_airways,vessel);
keyboard

figure, imshow3D(feature)
niftiwrite(feature, fullfile(save_path, status+"_feature.nii"));
save(fullfile(save_path, status+"_feature.mat"), "feature");

niftiwrite(img3D, fullfile(save_path, status+"_image.nii"));
save(fullfile(save_path, status+"_image.mat"), "feature");

niftiwrite(img3D, fullfile(save_path, status+"_image.nii"));
image = img3D;
save(fullfile(save_path, status+"_image.mat"), "image");

end