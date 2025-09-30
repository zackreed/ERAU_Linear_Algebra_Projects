function smiley_show(matrix)
   %change to uint8
   smiley_img=uint8(matrix);

   %Show the image
   imshow(smiley_img,'InitialMagnification','fit');
   axis on
    xticks(1:size(matrix, 2)); % Set x-axis ticks to the column indices
    yticks(1:size(matrix, 1)); % Set y-axis ticks to the row indices
end
