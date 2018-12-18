% Sum of Squared Differences

function displacement_value = im_align1(base_image,align_image)
  minimum = inf;
  for i = -15:15 
    for j = -15:15
      temp_image = circshift(align_image, [i j]);
      ssd = sum(sum((base_image - temp_image).^2));
      %disp(ssd)
      if ssd < minimum
        minimum = ssd;
        displacement_value = [i j];
      endif
    endfor
  endfor
endfunction
