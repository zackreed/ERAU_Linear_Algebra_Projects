function show_img(tensor, scale)
   % Convert the tensor to uint8
   img = uint8(tensor);

   % Resize the image if a scale factor is provided
   if nargin == 2
       img = imresize(img, scale); % scale can be a factor (e.g., 0.5 or 2)
   end

   % Show the resized image
   imshow(img);
end