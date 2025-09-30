function update_img_animation(handle, matrix)
    img_matrix=uint8(matrix);
    
    % Update the scatterplot
    set(handle, 'CData', img_matrix);
    drawnow; % Update the plot immediately
end