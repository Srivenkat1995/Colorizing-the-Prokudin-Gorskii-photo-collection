% Implementing Harris Corner Detector

function corner_detection = harris(image)
  
  %Initializing variables
  image = im2double(image);
  [rows, columns] = size(image);
  sigma = 1;
  hsize = [7 7];
  threshold = 0.3;
  gaussian_blur = fspecial('gaussian',hsize,sigma);
  constant_k = 0.05;
  
  [dx dy] = meshgrid(-3:3 , -3:3);
  
  %derivative_image_x = conv2(image,dx);
  %derivative_image_y = conv2(image,dy);
  
  % Using Gaussian Function as Window Function
  Gxy = exp(-(dx .^ 2 + dy .^ 2) / (2 * sigma ^ 2));

  Gx = dx .* exp(-(dx .^ 2 + dy .^ 2) / (2 * sigma ^ 2));
  Gy = dy .* exp(-(dx .^ 2 + dy .^ 2) / (2 * sigma ^ 2));
  
  % Applying the Gauss blur on the image
  %gauss_derivative_x = conv2(gaussian_blur,derivative_image_x);
  %gauss_derivative_y = conv2(gaussian_blur,derivative_image_y);
   
  %filter_image_x = filter2(gaussian_blur,gauss_derivative_x.^2);
  %filter_image_y = filter2(gaussian_blur,gauss_derivative_y.^2);
  %filter_image_xy = filter2(gaussian_blur,gauss_derivative_x.*gauss_derivative_y);
  Ix = conv2(Gx, image);
  Iy = conv2(Gy, image);
  
  Sx2 = conv2(Gxy, Ix .^ 2);
  Sy2 = conv2(Gxy, Iy .^ 2);
  Sxy = conv2(Gxy, Ix .* Iy);
  % Calculating the M and R value
  
  temp_image = zeros(rows,columns);
  count = 0;
  maximum = -inf;
  minimum = inf;
  for i = 1:rows
    for j = 1:columns
      
      
      M = [Sx2(i, j) Sxy(i, j); Sxy(i, j) Sy2(i, j)];
      R = det(M) - constant_k * (trace(M)^2);
      
      if R > threshold
        temp_image(i,j) = R ;
        if R > maximum
          maximum = R;
        endif  
        if R < minimum
          minimum = R;
        endif  
        count = count + 1;
        
      endif
    endfor  
  endfor  
  
  
  corner_detection = temp_image > imdilate(temp_image, [1 1 1; 1 0 1; 1 1 1]); 
    
  
  
  
  
  
 endfunction