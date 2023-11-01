clc,clear
%% path variable
save_path = 'D:/lung-paper/lung_reg/data/case1';
% control_point_path = 'D:/lung-paper/lung_reg/save_path/moving/cp_flt_dilate.nii';
%%
ref = struct;
ref.feature = fullfile(save_path, 'ref_feature.nii');
flo.feature = fullfile(save_path, 'flo_feature.nii');
flo.image = fullfile(save_path, 'flo_image.nii');

mkdir(fullfile(save_path, "reg"))
save_path = fullfile(save_path, "reg");

%% image registration using feature
system(['reg_aladin -ref ', ref.feature, ' -flo ', flo.feature, ' -res ', save_path, '/ref_Ref_feature_flo_Flt_feature_affine_result.nii -aff ', save_path, '/ref_Ref_feature_flo_Flt_feature_affine_matrix.txt'])

system(['reg_f3d -ref ', ref.feature, ' -flo ', flo.feature, ' -res ', save_path, '/ref_Ref_feature_flo_Flt_feature_nrr_result.nii -aff ', save_path, '/ref_Ref_feature_flo_Flt_feature_affine_matrix.txt -cpp ', save_path, '/ref_Ref_feature_flo_Flt_feature_nrr_cpp.nii',...
        ' --nmi -nmiw 0 0 -nmiw 1 0 -nmiw 2 0.5555 --ssd -ssdw 0 0.2222 -ssdw 1 0.2222 -ssdw 2 0 -sx 5.0 -be 0.001 -le 0.0'])
system(['reg_resample -ref ', ref.feature, ' -flo ', flo.image, ' -res ', save_path, '/propagated_Flt_image.nii -trans ', save_path, '/ref_Ref_feature_flo_Flt_feature_nrr_cpp.nii'])


%% control point
% system(['reg_resample -ref ', ref_feature_path, ' -flo ', control_point_path, ' -res ', save_path, '/  propagated_cp_flt_dilate.nii -trans ', save_path, '/ref_Ref_feature_flo_Flt_feature_nrr_cpp.nii -inter 0'])
