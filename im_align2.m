% Normalized cross correlation

function correlation_value = im_align2(base_image,align_image)
  maximum = -inf;
  base_image = im2double(base_image);
  align_image = im2double(align_image);
  for i = -15:15 
    for j = -15:15
      temp_image = circshift(align_image, [i j]);
      normal_correlation = dot(base_image(:),temp_image(:))/norm(base_image(:))/norm(temp_image(:));
      %disp(ssd)
      if normal_correlation > maximum
        maximum = normal_correlation;
        correlation_value = [i j];
      endif
    endfor
  endfor
endfunction

