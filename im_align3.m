% algorithm for RANSAC 

function aligned_image = im_align3(image1, image2)
  
  [rows, columns] = size(image1);
  minimum = inf;
  %x1min=1;
  %x1max=rows;
  %n=400;
  %x1=round(x1min+rand(1,n)*(x1max-x1min));
  %y1min=1;
  %y1max=columns;
  %y1=round(y1min+rand(1,n)*(y1max-y1min));
  %x2min=1;
  %x2max=rows;
  %x2=round(x2min+rand(1,n)*(x2max-x2min));
  %y2min=1;
  %y2max=columns;
  %y2=round(y2min+rand(1,n)*(y2max-y2min));
  count1 = 1;
  count2 = 1;
  for i= 1 : rows
    for j= 1 : columns
      if image1(i,j) != 0
        x1(count1) = i;
        y1(count1) = j;
        count1 = count1 +1;
      endif
      if image2(i,j) != 0
        x2(count2) = i;
        y2(count2) = j;
        count2 = count2 +1;
      endif
 endfor
endfor
  
  
  x1min=1;
  x1max=size(x2,2);
  n=size(x2,2);
  x_max=round(x1min+rand(1,n)*(x1max-x1min));
  
  
  final_values = zeros(n);
  count = 1;
  outliers_val = 1;
  inliers_val = 1;
  
  inliers = zeros(size(x2,2),size(x1,2));
  outliers = zeros(size(x2,2),size(x1,2));
  x_shift = zeros(size(x2,2),size(x1,2));
  y_shift = zeros(size(x2,2),size(x1,2));
  ssd = zeros(size(x2,2),size(x1,2));
  for iterations= 1:size(x2,2)
    for i= 1:size(x1,2)
        shiftx = x1(i) - x2(x_max(count));
        shifty = y1(i) - y2(x_max(count));
        
        
        temp_image = circshift(image2,[shiftx,shifty]);
    
        ssd = image1 .- temp_image;
        inliers_val = nnz(ssd);
        outliers_val = rows*columns - inliers;
        x_shift(iterations,i) = shiftx;
        y_shift(iterations,i) =shifty;
        inliers(iterations,i) = inliers_val;
        %outliers(iterations,i) = outliers_val; 
          
      endfor
  endfor  
  
      
  disp(size(inliers));
  disp(size(outliers));
  disp(size(x_shift));
  disp(size(y_shift));
  [max_num,max_idx] = min(inliers(:));
  [X Y]=ind2sub(size(inliers),max_num);
  
  disp(X);
  disp(Y);
  disp(max_num);
  
  disp(x_shift(X,Y));
  disp(y_shift(X,Y));
  aligned_image = [x_shift(X,Y) y_shift(X,Y)];
          
  % Shift value is erraneous
  
  
endfunction
