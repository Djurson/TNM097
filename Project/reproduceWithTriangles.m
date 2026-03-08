function reproduceWithTriangles(img, gridSize)
    imgDouble = im2double(img);
    [rows, cols, ~] = size(imgDouble);

    [X, Y] = meshgrid(1:gridSize:cols, 1:gridSize:rows);

    X = X + randn(size(X)) * (gridSize / 3);
    Y = Y + randn(size(Y)) * (gridSize / 3);

    X = max(min(X, cols), 1);
    Y = max(min(Y, rows), 1);

    x_points = X(:);
    y_points = Y(:);

    DT = delaunay(x_points, y_points);
    numTriangles = size(DT, 1);

    figure;
    hold on;
    axis ij;
    axis equal;
    axis([1 cols 1 rows]);
    axis off;

    for i = 1:numTriangles
        tri_x = x_points(DT(i, :));
        tri_y = y_points(DT(i, :));

        cx = round(mean(tri_x));
        cy = round(mean(tri_y));

        cx = max(min(cx, cols), 1);
        cy = max(min(cy, rows), 1);

        triColor = squeeze(imgDouble(cy, cx, :))';

        patch(tri_x, tri_y, triColor, 'EdgeColor', 'none');
    end

    title(['Triangelreproduktion (Gridstorlek: ', num2str(gridSize), ')']);
    hold off;
end