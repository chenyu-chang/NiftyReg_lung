clc,clear

%% path variable
save_path = 'D:\lung-paper\data\nii\Results';

ref = struct;
ref.feature = fullfile(save_path, 'ref_feature.nii');
flo.feature = fullfile(save_path, 'flo_feature.nii');
ref.image = fullfile(save_path, 'ref_image.nii');
flo.image = fullfile(save_path, 'flo_image.nii');

%% load flt & ref control point
load([save_path '\record_pts_post_ori.mat']);
load([save_path '\record_pts_pre_ori.mat']);
flt_cp_matrix = record_pts_post_ori;
ref_cp_matrix = record_pts_pre_ori;

%% flt_cp_matrix 
flo_image = niftiread(flo.image);

cp_flt = zeros(size(flo_image));
for i=1:size(flt_cp_matrix, 1)
    % i
    y = flt_cp_matrix(i,1);
    x = flt_cp_matrix(i,2);
    z = flt_cp_matrix(i,3);
    cp_flt(int16(y), int16(x), int16(z)) = i;
end
%% ref_cp_matrix 
ref_image = niftiread(ref.image);

cp_ref = zeros(size(ref_image));
for i=1:size(ref_cp_matrix, 1)
    y = ref_cp_matrix(i,1);
    x = ref_cp_matrix(i,2);
    z = ref_cp_matrix(i,3);
    cp_ref(int16(y), int16(x), int16(z)) = i;
end

%% cp dilate
cp_flt_dilate = imdilate(cp_flt, strel('sphere',2), 'same');
cp_ref_dilate = imdilate(cp_ref, strel('sphere',2), 'same');

%% save cp to nifty
control_point_path = [save_path, '\cp_flt_dilate.nii'];
niftiwrite(cp_flt_dilate, control_point_path);

%% check
volumeSegmenter(flo_image, cp_flt_dilate);
keyboard

%% niftyreg control point
mkdir(fullfile(save_path, 'reg'))
save_path = fullfile(save_path, 'reg');
system(['reg_resample -ref ', ref.feature, ' -flo ', control_point_path, ' -res ', save_path, '/propagated_cp_flt_dilate.nii -trans ', save_path, '/ref_Ref_feature_flo_Flt_feature_nrr_cpp.nii -inter 0']);

%% show registration cp result

propagated_cp_dilate = niftiread([save_path, '\propagated_cp_flt_dilate.nii']);

volumeSegmenter(ref_image, propagated_cp_dilate);
volumeSegmenter(ref_image, cp_ref_dilate);
keyboard

%% eval TRE
centroids = [];
for i=1:size(flt_cp_matrix, 1)
    tmp_img = propagated_cp_dilate;
    tmp_img(tmp_img ~= i) = 0;
    tmp_img(tmp_img == i) = 1;
    s = regionprops(tmp_img,'centroid');
    centroids = cat(1,centroids,s.Centroid); %(x, y, z)
end
centroids_yxz = [centroids(:,2),centroids(:,1),centroids(:,3)];


errors =  sqrt(sum((centroids_yxz - ref_cp_matrix).^2, 2));
fprintf("errors:\n")
disp(errors)
fprintf("mean: %f\n", mean(errors))
fprintf("std: %f\n", std(errors))
