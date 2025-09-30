function smiley_show_no_grid(matrix)
   %change to uint8
   smiley_img=uint8(matrix);

   %Show the image
   imshow(smiley_img,'InitialMagnification',1500);
end
