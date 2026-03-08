function palette = generatePalette(baseColors, shades, showPlot)

if nargin < 3
    showPlot = true;
end

palette = zeros(shades, baseColors, 3);

% Random base hues
baseHues = linspace(0,1,baseColors) + 0.05*randn(1,baseColors);
baseHues = mod(baseHues,1);

for c = 1:baseColors
    
    h = baseHues(c);
    
    for s = 1:shades
        
        t = (s-1)/(shades-1);   % 0 → 1
        
        % Dark → Light progression
        val = 0.05 + 0.95*t;
        sat = 0.95 - 0.3*(t^2); 
        
        rgb = hsv2rgb([h sat val]);
        
        palette(s,c,:) = rgb;
        
    end
end

if showPlot
    figure
    image(palette)
    axis equal off
end

end