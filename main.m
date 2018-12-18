pkg load image
for i = 1 : 6
image_name = strcat("image", num2str(i) ,".jpg");

I = imread(image_name);
disp("Reading Image");

[rows,columns] = size(I);

no = round(rows /3);
disp(no)
image_blue = I(1:no, :);
image_green = I(no+1:2*no,:);
image_red = I(2*no+1:rows,:);


% Cropping image 

[row_redchannel,column_redchannel] = size(image_red);
[row_bluechannel,column_bluechannel] = size(image_blue);
[row_greenchannel,column_greenchannel] = size(image_green);

margin_row = round(0.1*row_redchannel);
margin_column =  round(0.1*column_redchannel);


image_red_cropped = image_red(margin_row:row_redchannel-margin_row,margin_column:column_redchannel - margin_column); 
image_blue_cropped = image_blue(margin_row:row_bluechannel-margin_row,margin_column:column_bluechannel - margin_column);
image_green_cropped = image_green(margin_row:row_greenchannel-margin_row,margin_column:column_greenchannel-margin_column);

image_red_cropped_new = imresize(image_red_cropped,size(image_blue_cropped));


unaligned_image = cat(3,image_blue_cropped,image_green_cropped,image_red_cropped_new);
string_unaligned_image = strcat("image", num2str(i) ,"-color.jpg");
imwrite(unaligned_image,string_unaligned_image);

displacement_red_blue = im_align1(image_blue_cropped, image_red_cropped_new);
displacement_green_blue = im_align1(image_blue_cropped, image_green_cropped);

disp (displacement_red_blue);
disp (displacement_green_blue);

aligned_red = circshift(image_red_cropped_new, displacement_red_blue);

aligned_green = circshift(image_green_cropped, displacement_green_blue);


aligned_image_ssd = cat(3,image_blue_cropped,aligned_green,aligned_red);

string_aligned_ssd = strcat("image", num2str(i) ,"-ssd.jpg");
imwrite(aligned_image_ssd,string_aligned_ssd);
normal_red_blue = im_align2(image_blue_cropped, image_red_cropped_new);
normal_green_blue = im_align2(image_blue_cropped,image_green_cropped);

normal_aligened_red = circshift(image_red_cropped_new, normal_red_blue);
normal_aligened_green = circshift(image_green_cropped, normal_green_blue);

normal_aligned_image = cat(3, image_blue_cropped,normal_aligened_green,normal_aligened_red);
string_aligned_ncc = strcat("image", num2str(i) ,"-ncc.jpg");
imwrite(normal_aligned_image,string_aligned_ncc);

harris_image_blue = harris(image_blue_cropped);
harris_image_red = harris(image_red_cropped_new);
harris_image_green = harris(image_green_cropped);

displacement_ransac_red = im_align3(harris_image_blue,harris_image_red);
displacement_ransac_green = im_align3(harris_image_blue,harris_image_green);

aligned_green_ransac = circshift(image_green_cropped, displacement_ransac_green);
aligned_red_ransac = circshift(image_red_cropped_new, displacement_ransac_red);


aligned_ransac = cat(3,image_blue_cropped,aligned_green_ransac,aligned_red_ransac);
string_aligned_corner = strcat("image", num2str(i) ,"-corner.jpg");
imwrite(aligned_ransac,string_aligned_corner);

endfor
%Channels 




