function update_cloud_animation(handle, matrix)
    set(handle, 'XData', matrix(:,1), 'YData', matrix(:,2),'ZData',matrix(:,3));
    drawnow; % Update the plot immediately
end