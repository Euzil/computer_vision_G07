function img_cropped = ImageCropping(image, polygon)
    % Extract the x and y coordinates of the polygon vertices
    row1 = polygon(1, :);
    row2 = polygon(2, :);

    % Create a binary mask for the polygon
    BW=roipoly(image, row1, row2);

    % Apply the mask to the image
    g=double(image) .* double(BW);

    % Convert the result back to uint8 type
    img_cropped = uint8(g);
end