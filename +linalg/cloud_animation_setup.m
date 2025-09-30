function cloud_animation_setup(userString)
    grid on;
    xlabel('X-axis');
    ylabel('Y-axis');
    zlabel('Z-axis');
    title([userString ' Pixel Vectors Changing Over Time']);
    drawnow;
end