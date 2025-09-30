function blackPixelCoords = img_to_points(imagePath, invertColors)
    % Default horizontal shearing if not provided
    if nargin < 2
        invertColors = false;
    end

    % Read the image
    img = imread(imagePath);

    % If the image is colored, convert it to grayscale
    if size(img, 3) == 3
        grayImg = rgb2gray(img);
    else
        grayImg = img;
    end

    % Convert the grayscale image to black and white (binary image)
    bwImg = imbinarize(grayImg);

    % Optionally invert the black and white image based on the user's choice
    if invertColors
        bwImg = ~bwImg;  % Invert the binary image (0 becomes 1, 1 becomes 0)
    end

    % Resize the image to 216x384 pixels
    resizedImg = imresize(bwImg, [216, 384]);  % [height, width]

    % Find the indices of black pixels (which are 0 in a binary image)
    [row, col] = find(resizedImg == 0);

    % Invert the row indices (flip y-axis) to match Cartesian coordinates
    row = size(resizedImg, 1) - row + 1;

    % Combine column and row indices into coordinate pairs
    blackPixelCoords = [col, row];  % x corresponds to columns, y to rows
end
