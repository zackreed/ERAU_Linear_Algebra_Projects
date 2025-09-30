function img_animation_setup(userString)
    % Add a caption using annotation
    annotation('textbox', [0.1, 0.01, 0.8, 0.05], 'String', [userString ' Image Changing Over Time'], ...
        'EdgeColor', 'none', 'HorizontalAlignment', 'center', 'FontSize', 12);
    drawnow; % Ensure that everything renders
end