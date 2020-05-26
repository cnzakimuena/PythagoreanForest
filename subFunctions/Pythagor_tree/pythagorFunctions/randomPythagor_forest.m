function randomPythagor_forest(dataStruc, c1, c2)

H = figure('color','w');
for i = 1:9

    D = dataStruc{i,1};
    d = dataStruc{i,2};
%     ColorM = ColorM_assigment(colorNum, d);
    % create a default color map ranging from color c1 to c2
    colormapSize = d+1;
    ColorM = [linspace(c1(1),c2(1),colormapSize)', linspace(c1(2),c2(2),colormapSize)', linspace(c1(3),c2(3),colormapSize)'];
    
    subplot(3,3,i);
    hold on
    axis equal
    axis off
    for i=1:size(D,1)
        cx    = D(i,1);
        cy    = D(i,2);
        theta = D(i,3);
        si    = D(i,4);
        M     = mat_rot(theta);
        x     = si*[0 1 1 0 0];
        y     = si*[0 0 1 1 0];
        pts   = M*[x;y];
        fill(cx+pts(1,:),cy+pts(2,:),ColorM(D(i,5)+1,:));
        % plot(cx+pts(1,1:2),cy+pts(2,1:2),'r');
    end
%     darkBackground(H,[0 0 0],[1 1 1])
    % imageData = screencapture(gcf);
    % startNum = 100;
    % offset = 20;
    % endNum = size(imageData,1)-offset;
    % endNum2 = size(imageData,2)-offset;
    % imageData0 = imageData(startNum:endNum,offset:endNum2,:);
    % imwrite(imageData0,'sample_tree.png');  % save the captured image to file
    
end

% %% Write results to an SVG file
% Pythagor_tree_write2svg(m,n,Colormap,M);
% 
% function Pythagor_tree_write2svg(m,n,Colormap,M)
% % Determine the bounding box of the tree with an offset
% % Display_metadata = false;
% Display_metadata = true;
% 
% nEle    = size(M,1);
% r2      = sqrt(2);
% LOffset = M(nEle,4) + 0.1;
% min_x   = min(M(:,1)-r2*M(:,4)) - LOffset;
% max_x   = max(M(:,1)+r2*M(:,4)) + LOffset;
% min_y   = min(M(:,2)          ) - LOffset;  % -r2*M(:,4)
% max_y   = max(M(:,2)+r2*M(:,4)) + LOffset;
% 
% % Compute the color of tree
% ColorM = zeros(n+1,3);
% eval(['ColorM = flipud(' Colormap '(n+1));']);
% co   = 100;
% Wfig = ceil(co*(max_x-min_x));
% Hfig = ceil(co*(max_y-min_y));
% filename = ['Pythagoras_tree_1_' strrep(num2str(m),'.','_') '_'...
%              num2str(n) '_' Colormap '.svg'];
% fid  = fopen(filename, 'wt');
% fprintf(fid,'<?xml version="1.0" encoding="UTF-8" standalone="no"?>\n');
% if ~Display_metadata
%     fprintf(fid,'<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN"\n'); 
%     fprintf(fid,'  "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">\n');
% end
% fprintf(fid,'<svg width="%d" height="%d" version="1.1"\n',Wfig,Hfig); % 
% % fprintf(fid,['<svg width="12cm" height="4cm" version="1.1"\n']); % Wfig,
% 
% % fprintf(fid,['<svg width="15cm" height="10cm" '...
% %              'viewBox="0 0 %d %d" version="1.1"\n'],...
% %              Wfig,Hfig);
% if Display_metadata
%     fprintf(fid,'\txmlns:dc="http://purl.org/dc/elements/1.1/"\n');
%     fprintf(fid,'\txmlns:cc="http://creativecommons.org/ns#"\n');
%     fprintf(fid,['\txmlns:rdf="http://www.w3.org/1999/02/22'...
%                  '-rdf-syntax-ns#"\n']);
% end
% fprintf(fid,'\txmlns:svg="http://www.w3.org/2000/svg"\n');
% fprintf(fid,'\txmlns="http://www.w3.org/2000/svg"\n');
% fprintf(fid,'\txmlns:xlink="http://www.w3.org/1999/xlink">\n');
% 
% if Display_metadata
%     fprintf(fid,'\t<title>Pythagoras tree</title>\n');
%     fprintf(fid,'\t<metadata>\n');
%     fprintf(fid,'\t\t<rdf:RDF>\n');
%     fprintf(fid,'\t\t\t<cc:Work\n');
%     fprintf(fid,'\t\t\t\trdf:about="">\n');
%     fprintf(fid,'\t\t\t\t<dc:format>image/svg+xml</dc:format>\n');
%     fprintf(fid,'\t\t\t\t<dc:type\n');
%     fprintf(fid,'\t\t\t\t\trdf:resource="http://purl.org/dc/dcmitype/StillImage" />\n');
%     fprintf(fid,'\t\t\t\t<dc:title>Pythagoras tree</dc:title>\n');
%     fprintf(fid,'\t\t\t\t<dc:creator>\n');
%     fprintf(fid,'\t\t\t\t\t<cc:Agent>\n');
%     fprintf(fid,'\t\t\t\t\t\t<dc:title>Guillaume Jacquenot</dc:title>\n');
%     fprintf(fid,'\t\t\t\t\t</cc:Agent>\n');
%     fprintf(fid,'\t\t\t\t</dc:creator>\n');
%     fprintf(fid,'\t\t\t\t<cc:license\n');
%     fprintf(fid,'\t\t\t\t\t\trdf:resource="http://creativecommons.org/licenses/by-nc-sa/3.0/" />\n');
%     fprintf(fid,'\t\t\t</cc:Work>\n');
%     fprintf(fid,'\t\t\t<cc:License\n');
%     fprintf(fid,'\t\t\t\trdf:about="http://creativecommons.org/licenses/by-nc-sa/3.0/">\n');
%     fprintf(fid,'\t\t\t\t<cc:permits\n');
%     fprintf(fid,'\t\t\t\t\trdf:resource="http://creativecommons.org/ns#Reproduction" />\n');
%     fprintf(fid,'\t\t\t\t<cc:permits\n');
%     fprintf(fid,'\t\t\t\t\trdf:resource="http://creativecommons.org/ns#Reproduction" />\n');
%     fprintf(fid,'\t\t\t\t<cc:permits\n');
%     fprintf(fid,'\t\t\t\t\trdf:resource="http://creativecommons.org/ns#Distribution" />\n');
%     fprintf(fid,'\t\t\t\t<cc:requires\n');
%     fprintf(fid,'\t\t\t\t\trdf:resource="http://creativecommons.org/ns#Notice" />\n');
%     fprintf(fid,'\t\t\t\t<cc:requires\n');
%     fprintf(fid,'\t\t\t\t\trdf:resource="http://creativecommons.org/ns#Attribution" />\n');
%     fprintf(fid,'\t\t\t\t<cc:prohibits\n');
%     fprintf(fid,'\t\t\t\t\trdf:resource="http://creativecommons.org/ns#CommercialUse" />\n');
%     fprintf(fid,'\t\t\t\t<cc:permits\n');
%     fprintf(fid,'\t\t\t\t\trdf:resource="http://creativecommons.org/ns#DerivativeWorks" />\n');
%     fprintf(fid,'\t\t\t\t<cc:requires\n');
%     fprintf(fid,'\t\t\t\t\trdf:resource="http://creativecommons.org/ns#ShareAlike" />\n');
%     fprintf(fid,'\t\t\t</cc:License>\n');
%     fprintf(fid,'\t\t</rdf:RDF>\n');
%     fprintf(fid,'\t</metadata>\n'); 
% end
% fprintf(fid,'\t<defs>\n');
% fprintf(fid,'\t\t<rect width="%d" height="%d" \n',co,co);
% fprintf(fid,'\t\t\tx="0" y="0"\n');
% fprintf(fid,'\t\t\tstyle="fill-opacity:1;stroke:#00d900;stroke-opacity:1"\n');
% fprintf(fid,'\t\t\tid="squa"\n');
% fprintf(fid,'\t\t/>	\n');
% fprintf(fid,'\t</defs>\n');
% fprintf(fid,'\t<g transform="translate(%d %d) rotate(180) " >\n',...
%                 round(co*max_x),round(co*max_y));
% for i = 0:n
%     fprintf(fid,'\t\t<g style="fill:#%s;" >\n',...
%                 generate_color_hexadecimal(ColorM(i+1,:)));            
%     Offset = 2^i-1;
%     for j = 1:2^i
%         k = j + Offset;
%         fprintf(fid,['\t\t\t<use xlink:href="#squa" ',...
%                      'transform="translate(%+010.5f %+010.5f)'...
%                      ' rotate(%+010.5f) scale(%8.6f)" />\n'],...
%                     co*M(k,1),co*M(k,2),M(k,3)*180/pi,M(k,4));   
%     end
%     fprintf(fid,'\t\t</g>\n');
% end
% fprintf(fid,'\t</g>\n');
% fprintf(fid,'</svg>\n');
% fclose(fid);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function M = mat_rot(x)
c = cos(x);
s = sin(x);
M=[c -s; s c];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Scolor = generate_color_hexadecimal(color)
Scolor = '000000';
for i=1:3
    c = dec2hex(round(255*color(i)));
    if numel(c)==1
        Scolor(2*(i-1)+1) = c;
    else
        Scolor(2*(i-1)+(1:2)) = c;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function  res = iscolormap(cmap)
% This function returns true if 'cmap' is a valid colormap
LCmap = {...
    'autumn'
    'bone'
    'colorcube'
    'cool'
    'copper'
    'flag'
    'gray'
    'hot'
    'hsv'
    'jet'
    'lines'
    'pink'
    'prism'
    'spring'
    'summer'
    'white'
    'winter'
};

res = ~isempty(strmatch(cmap,LCmap,'exact'));
